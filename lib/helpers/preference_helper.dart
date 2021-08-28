import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static Future<bool?> saveReminder(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('reminder', value);
    return value;
  }

  static Future<bool?> getReminder() async {
    final prefs = await SharedPreferences.getInstance();
    final reminder = prefs.getBool('reminder');
    return reminder;
  }

  static Future<void> clearPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
