import 'package:flutter/material.dart';
import 'package:restaurant_app/services/shared_preferences_service.dart';

class ThemeProvider extends ChangeNotifier {
  final SharedPreferencesService _service;

  ThemeProvider(this._service) {
    
    _loadTheme();
    
  }

  String _message = "";
  String get message => _message;

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _saveTheme();
    notifyListeners();
  }

  Future<void> _saveTheme() async {
    try {
      await _service.saveDarkModeValue(_isDarkMode);
      _message = "Your data is saved";
    } catch (e) {
      _message = "Failed to save your data";
    }
  }

   Future<void> _loadTheme() async {
    try {
      print("loadDark=====>");
    print(_isDarkMode);
      _isDarkMode = await _service.getDarkModeValue();
      _message = "Data successfully retrieved";
      print("loadDarkAfter=====>");
    print(_isDarkMode);
    } catch (e) {
      print("=====>$e");
      _message = "Failed to get your data";
    }
    notifyListeners();
  }
}
