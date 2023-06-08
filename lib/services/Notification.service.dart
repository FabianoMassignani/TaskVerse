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

  Future<void> initNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<bool> scheduleNotification(
      int id, String? title, String? body, tz.TZDateTime time) async {
    try {
      if (time.isAfter(tz.TZDateTime.now(tz.local))) {
        await flutterLocalNotificationsPlugin.zonedSchedule(
          id,
          title,
          body,
          time,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'Scheduled_channel',
              'Scheduled Notification',
              importance: Importance.max,
              priority: Priority.max,
            ),
          ),
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          // ignore: deprecated_member_use
          androidAllowWhileIdle: true,
        );
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
