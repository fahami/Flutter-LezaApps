import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUtils {
  User? user = FirebaseAuth.instance.currentUser;
}
