import 'package:flutter/material.dart';
import 'package:resto/constant/enum.dart';
import 'package:resto/helpers/preference_helper.dart';

class SettingProvider extends ChangeNotifier {
  bool _reminder = false;
  bool get reminder => _reminder;

  late ResultState _state;
  ResultState get state => _state;
  SettingProvider() {
    getReminder();
  }
  Future<bool?> getReminder() async {
    final reminder = await PreferencesHelper.getReminder();
    notifyListeners();
    _reminder = reminder ?? false;
  }

  Future<bool?> setReminder(bool reminder) async {
    _reminder = reminder;
    try {
      await PreferencesHelper.saveReminder(reminder);
      getReminder();
      notifyListeners();
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
    }
  }
}
