import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:resto/utils/background_service.dart';
import 'package:resto/helpers/datetime_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  Future<bool?> scheduledRecommendation(bool value) async {
    if (value) {
      notifyListeners();
      print('Scheduling Recommended Restaurant Activated');
      await AndroidAlarmManager.periodic(
          Duration(hours: 24), 1, BackgroundService.callback,
          wakeup: true, exact: true, startAt: DateTimeHelper.format());
    } else {
      print('Scheduling Recommended Restaurant Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
