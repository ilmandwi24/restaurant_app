import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences _preferences;

  SharedPreferencesService(this._preferences);

  static const String keyDarkMode = "MYDARKMODE";
  static const String keyDailyReminder = "MYDAILYREMINDER";

  Future<void> saveDarkModeValue(bool value) async {
    try {
      await _preferences.setBool(keyDarkMode, value);
    } catch (e) {
      throw Exception("Shared preferences cannot save the setting value.");
    }
  }

  Future<bool> getDarkModeValue() async{
    try {
      final result = await _preferences.getBool(keyDarkMode);
   
      return result ?? false;
    } catch (e) {
      throw Exception("Shared preferences cannot get the setting value.");
    }
  }
}
