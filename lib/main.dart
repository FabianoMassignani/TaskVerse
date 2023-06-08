import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:taskverse/initialization/initialization.dart';
import 'package:taskverse/services/notification.service.dart';
import 'initialization/module/firebase_options.dart';
import 'package:timezone/data/latest.dart' as tz;

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();

  NotificationService notificationService = NotificationService();
  await notificationService.initNotification();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const TaskVerse());
}
