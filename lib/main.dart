import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:resto/detail.dart';
import 'package:resto/favorite.dart';
import 'package:resto/helpers/notifications_helper.dart';
import 'package:resto/onboarding.dart';
import 'package:resto/login.dart';
import 'package:resto/review.dart';
import 'package:resto/settings.dart';
import 'landing.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _homeRoute = '/';
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    if (user != null) {
      _homeRoute = '/';
    } else {
      _homeRoute = '/onboard';
    }
    NotificationHelper.init();
    listenNotifications();
  }

  void listenNotifications() =>
      NotificationHelper.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) {
    print(payload);
    Get.toNamed('/restaurantDetail', arguments: payload);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.light(),
      themeMode: ThemeMode.light,
      title: 'Restaurant App',
      initialRoute: _homeRoute,
      getPages: [
        GetPage(name: '/', page: () => Landing()),
        GetPage(name: '/restaurantDetail', page: () => Details()),
        GetPage(name: '/review', page: () => Review()),
        GetPage(name: '/favorite', page: () => FavoriteRestaurant()),
        GetPage(name: '/settings', page: () => Settings()),
        GetPage(name: '/login', page: () => Login()),
        GetPage(name: '/onboard', page: () => OnBoarding())
      ],
    );
  }
}
