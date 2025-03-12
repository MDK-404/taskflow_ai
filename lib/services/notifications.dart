import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    var androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initSettings = InitializationSettings(android: androidInit);
    await _notifications.initialize(initSettings);
  }

  static Future<void> showNotification(String title, String body) async {
    var androidDetails = AndroidNotificationDetails(
        "channelId", "Task Notifications",
        importance: Importance.high);
    var details = NotificationDetails(android: androidDetails);
    await _notifications.show(0, title, body, details);
  }
}
