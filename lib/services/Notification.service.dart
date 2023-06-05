import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    const androidInitialize =
        AndroidInitializationSettings('mipmap/ic_launcher');

    const initializationsSettings = InitializationSettings(
      android: androidInitialize,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  }

  Future<void> showNotification(
      int id, String? title, String? body, tz.TZDateTime time) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      time,
      const NotificationDetails(
          android: AndroidNotificationDetails(
              'Scheduled_channel', 'Scheduled Notification',
              importance: Importance.max, priority: Priority.max)),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
