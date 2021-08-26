import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:resto/utils/background_service.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;
  bool get isScheduled => _isScheduled;

  Future<bool> scheduledRecommendation(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      print('Scheduling Recommended Restaurant Activated');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        Duration(days: 1),
        1,
        BackgroundService.callback,
        wakeup: true,
        exact: true,
        startAt: DateTime.now(),
      );
    } else {
      print('Scheduling Recommended Restaurant Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
