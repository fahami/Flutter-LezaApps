import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:resto/config/color.dart';
import 'package:resto/config/text_style.dart';
import 'package:resto/constant/enum.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  ResultState _state = ResultState.NoData;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _state == ResultState.Loading
            ? Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/animations/loading.json', width: 200),
                    Text("Mencoba masuk...")
                  ],
                ),
              )
            : Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        image: AssetImage('assets/img/restaurant.jpeg'),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [colorAccent.withOpacity(0.2), Colors.white],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.25,
                    left: 32,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: heading1,
                        ),
                        Text(
                          'Selamat datang kembali',
                          style: heading2,
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: SizedBox(
                      // height: MediaQuery.of(context).size.height * 0.6,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(32),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                InputForm(
                                  controller: emailController,
                                  validator: (value) {
                                    if (!value!.contains('@')) {
                                      return 'Email tidak valid';
                                    } else
                                      return null;
                                  },
                                  label: 'Email',
                                  labelStyle: heading3,
                                ),
                                SizedBox(height: 16),
                                InputForm(
                                  obsecure: true,
                                  controller: passController,
                                  validator: (value) {
                                    if (value!.length < 4) {
                                      return 'Password minimal 8 karakter';
                                    }
                                    return null;
                                  },
                                  label: 'Kata sandi',
                                  labelStyle: heading3,
                                ),
                                SizedBox(height: 16),
                                SignInButton(Buttons.Email,
                                    text: 'Daftar dengan Email',
                                    onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(
                                        () => _state = ResultState.Loading);
                                    try {
                                      await _auth
                                          .createUserWithEmailAndPassword(
                                              email: emailController.text,
                                              password: passController.text);

                                      Get.offAllNamed('/');
                                    } on FirebaseAuthException catch (e) {
                                      final snackBar = SnackBar(
                                          content: Text(e.message ??
                                              'Pastikan informasi anda telah benar'));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                      setState(
                                          () => _state = ResultState.Error);
                                    }
                                  }
                                }),
                                Row(
                                  children: [
                                    Expanded(child: Divider()),
                                    Text('  atau  '),
                                    Expanded(child: Divider())
                                  ],
                                ),
                                SignInButton(
                                  Buttons.Email,
                                  text: 'Masuk dengan Email',
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(
                                          () => _state = ResultState.Loading);
                                      try {
                                        await _auth.signInWithEmailAndPassword(
                                            email: emailController.text,
                                            password: passController.text);
                                        Get.offAllNamed('/');
                                      } on FirebaseAuthException catch (e) {
                                        final snackBar = SnackBar(
                                            content: Text(e.message ??
                                                'Pastikan informasi anda telah benar'));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                        setState(
                                            () => _state = ResultState.Error);
                                      }
                                    }
                                  },
                                ),
                                SignInButton(
                                  Buttons.Google,
                                  text: 'Masuk dengan Google',
                                  onPressed: () async {
                                    setState(
                                        () => _state = ResultState.Loading);
                                    try {
                                      await signInWithGoogle();
                                      Get.offAllNamed('/');
                                    } on FirebaseAuthException catch (e) {
                                      print(e.message);
                                      setState(
                                          () => _state = ResultState.Error);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }
}

class InputForm extends StatelessWidget {
  const InputForm({
    Key? key,
    required this.controller,
    required this.validator,
    required this.label,
    required this.labelStyle,
    this.obsecure,
  }) : super(key: key);

  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final String label;
  final TextStyle labelStyle;
  final bool? obsecure;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: labelStyle),
        SizedBox(height: 5),
        TextFormField(
          obscureText: obsecure ?? false,
          cursorColor: colorAccent,
          decoration: InputDecoration(
            focusColor: colorAccent,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorAccent),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
          controller: controller,
          validator: validator,
        ),
      ],
    );
  }
}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth =
      await googleUser!.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
