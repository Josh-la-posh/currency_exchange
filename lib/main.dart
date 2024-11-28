import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:leak_tracker/leak_tracker.dart';
import 'package:pouch/data/modules/inactivity_service.dart';
import 'package:pouch/data/modules/storage_session_controller.dart';
import 'package:pouch/utils/local_storage/local_storage.dart';
import 'package:pouch/utils/socket/my_http_override.dart';
import 'app.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling background message: ${message.messageId}");
  print('Message data: ${message.data}');
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> initializeLocalNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> main() async {
  LeakTracking.start(
    config: LeakTrackingConfig(
      checkPeriod: const Duration(seconds: 10),
      onLeaks: (leaks) {
        print('Detected leaks: ${leaks}');
      }
    )
  );
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverride();
  await LocalStorage.instance.initialize();
  await dotenv.load();
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    print('Firebase initialization error: $e');
  }
  // initializeLocalNotifications();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  Get.put(UserSessionController(), permanent: true);
  await Get.putAsync(() async => InactivityService());
  // await FirebaseApi().initNotifications();
  runApp(const MyApp());
}

