import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:resto/detail.dart';
import 'package:resto/favorite.dart';
import 'package:resto/helpers/notifications_helper.dart';
import 'package:resto/review.dart';
import 'landing.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
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
  @override
  void initState() {
    super.initState();
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
      themeMode: ThemeMode.light,
      title: 'Restaurant App',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => Home()),
        GetPage(name: '/restaurantDetail', page: () => Details()),
        GetPage(name: '/review', page: () => Review()),
        GetPage(name: '/favorite', page: () => FavoriteRestaurant())
      ],
    );
  }
}
