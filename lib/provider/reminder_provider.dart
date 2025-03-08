import 'package:flutter/material.dart';
import 'package:restaurant_app/services/local_notification_service.dart';
// import 'package:restaurant_app/services/local_notification_service.dart';
import 'package:restaurant_app/services/shared_preferences_service.dart';

class ReminderProvider extends ChangeNotifier {
  final SharedPreferencesService _service;
  final LocalNotificationService _flutterNotificationService;

  // final NotificationService _notificationService = NotificationService();

  ReminderProvider(this._service, this._flutterNotificationService) {
    loadReminderStatus();
  }

  bool _isReminderOn = false;
  bool get isReminderOn => _isReminderOn;

  void toggleReminder() {
    _isReminderOn = !_isReminderOn;
    _saveReminder();
    notifyListeners();
  }

  Future<void> loadReminderStatus() async {
    try {
      print("loadReminderStatus=====>");
      _isReminderOn = await _service.getReminderStatus();
      if (_isReminderOn) {
        await _flutterNotificationService.scheduleDailyNotification();
      } else {
        await _flutterNotificationService.cancelNotification();
      }
    } catch (e) {
      print("Error=====>$e");
    }
    notifyListeners();
  }

  Future<void> _saveReminder() async {
    await _service.setReminderStatus(_isReminderOn);

    if (_isReminderOn) {
      await _flutterNotificationService.scheduleDailyNotification();
    } else {
      await _flutterNotificationService.cancelNotification();
    }

    notifyListeners();
  }
}
