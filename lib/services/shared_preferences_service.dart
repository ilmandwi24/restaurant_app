import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences _preferences;

  SharedPreferencesService(this._preferences);

  static const String _keyDarkMode = "MYDARKMODE";
  static const String _keyDailyReminder = "MYDAILYREMINDER";
  

  Future<void> saveDarkModeValue(bool value) async {
    try {
      await _preferences.setBool(_keyDarkMode, value);
    } catch (e) {
      throw Exception("Shared preferences cannot save the setting value.");
    }
  }

  Future<bool> getDarkModeValue() async{
    try {
      final result = _preferences.getBool(_keyDarkMode);
   
      return result ?? false;
    } catch (e) {
      throw Exception("Shared preferences cannot get the setting value.");
    }
  }

    Future<bool> getReminderStatus() async {
    try {
      final result = _preferences.getBool(_keyDailyReminder);
   
      return result ?? false;
    } catch (e) {
      throw Exception("Shared preferences cannot get the setting value.");
    }
  }

  Future<void> setReminderStatus(bool isEnabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyDailyReminder, isEnabled);
  }
}
