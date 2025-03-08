import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/services/local_notification_service.dart';

class LocalNotificationProvider extends ChangeNotifier {
  final LocalNotificationService flutterNotificationService;

  LocalNotificationProvider(this.flutterNotificationService);

   int _notificationId = 0;
 bool? _permission = false;
 bool? get permission => _permission;

 List<PendingNotificationRequest> pendingNotificationRequests = [];


  Future<void> requestPermissions() async {
   _permission = await flutterNotificationService.requestPermissions();
   notifyListeners();
 }

 void showNotification() {
   _notificationId += 1;
   flutterNotificationService.showNotification(
     id: _notificationId,
     title: "New Notification",
     body: "This is a new notification with id $_notificationId",
     payload: "This is a payload from notification with id $_notificationId",
   );
 }

 void scheduleDailyNotification() {
   flutterNotificationService.scheduleDailyNotification( );
 }



 Future<void> checkPendingNotificationRequests(BuildContext context) async {
   pendingNotificationRequests =
       await flutterNotificationService.pendingNotificationRequests();
   notifyListeners();
 }

  Future<void> cancelNotification() async {
   await flutterNotificationService.cancelNotification();
 }
}
