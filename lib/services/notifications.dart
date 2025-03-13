import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'dart:io'; // Import for platform checks
import 'package:permission_handler/permission_handler.dart'; // Import permission handler

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    var androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initSettings = InitializationSettings(android: androidInit);
    await _notifications.initialize(initSettings);

    // Request permissions
    await requestPermissions();

    // Initialize time zones
    tz.initializeTimeZones();
  }

  static Future<void> requestPermissions() async {
    if (Platform.isAndroid) {
      // Request exact alarm permission for Android 13+
      if (await Permission.scheduleExactAlarm.request().isDenied) {
        print("Exact alarm permission denied");
      }

      // Request notification permission for Android 13+
      if (await Permission.notification.request().isDenied) {
        print("Notification permission denied");
      }
    }
  }

  static Future<void> scheduleNotification(
      String title, String body, DateTime scheduledTime) async {
    var androidDetails = AndroidNotificationDetails(
      "task_channel",
      "Task Notifications",
      importance: Importance.high,
      priority: Priority.high,
    );

    var details = NotificationDetails(android: androidDetails);

    tz.TZDateTime tzScheduledTime = tz.TZDateTime.from(scheduledTime, tz.local);

    await _notifications.zonedSchedule(
      scheduledTime.millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      tzScheduledTime,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
