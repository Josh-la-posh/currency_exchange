import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:pouch/data/modules/storage_session_controller.dart';
import 'package:pouch/features/notification/apis/api.dart';

import '../../features/notification/screens/notification.dart';

class FirebaseApi {
  static final FirebaseApi _instance = FirebaseApi._internal();
  factory FirebaseApi() => _instance;
  FirebaseApi._internal();

  final UserSessionController userSessionController = Get.find();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    await requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();

    if (fcmToken != null) {
      userSessionController.setDeviceToken(fcmToken);
    }
    print('Token: $fcmToken');

    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      userSessionController.setDeviceToken(newToken);
      updateDeviceToken();
    });
  }

  Future<void> requestPermission() async {
    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }


  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    print('New message: ${message.data}');
    if (message.notification != null) {
      print('Notification title: ${message.notification?.title}');
      print('Notification body: ${message.notification?.body}');
    }
    if (Get.currentRoute != '/notification') {
      Get.to(() => NotificationScreen(), arguments: message);
    }
  }

  Future<void> initPushNotifications() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Foreground message received: ${message.messageId}');
      handleMessage(message);
    });

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        print('App launched from notification: ${message.messageId}');
        handleMessage(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification opened: ${message.messageId}');
      handleMessage(message);
    });
  }


  // Future<void> initPushNotifications() async {
  //   FirebaseMessaging.onMessage.listen(handleMessage);
  //   FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
  //   FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  // }

  Future<void> registerDeviceToken() async {
    try {
      final token = await userSessionController.getDeviceToken();
      final response = await NotificationService.instance.registerDeviceToken({
        "token": token,
      });
      print('Register token response: ${response.data}');
    } catch (e) {
      print('Register token error: $e');
    }
  }

  Future<void> updateDeviceToken() async {
    try {
      final token = await userSessionController.getDeviceToken();
      final response = await NotificationService.instance.updateDeviceToken({
        "token": token,
      });
      print('Update token response: ${response.data}');
    } catch (e) {
      print('Update token error: $e');
    }
  }
}
