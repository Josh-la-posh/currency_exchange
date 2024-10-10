import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:pouch/data/modules/storage_session_controller.dart';
import 'package:pouch/features/notification/apis/api.dart';

import '../../features/notification/screens/notification.dart';

class FirebaseApi {
  UserSessionController userSessionController = Get.find();

  // create an instance of Firebase Messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    // request permission from user
    await _firebaseMessaging.requestPermission();

    // fetch the FCM token for this device
    final fcmToken = await _firebaseMessaging.getToken();

    if (fcmToken != null) {
      userSessionController.setDeviceToken(fcmToken.toString());
    }

    print('Token: $fcmToken');
  }

  // function to handle received messages

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    // navigate to new screen when message is received
    print('The new message: $message');
    Get.to(() => NotificationScreen());
    // Get.toNamed('/notification', arguments: message);
  }

  Future initPushNotifications() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }

  Future registerDeviceToken() async {
    try {
      final token = await userSessionController.getDeviceToken();
      final response = await NotificationService.instance.registerDeviceToken({
        "token": token,
        // "deviceId": deviceId
      });

      print('register token resposne ${response.data}');
    } catch (e) {
      print('register token error ${e}');
    }
  }

  Future updateDeviceToken() async {
    try {
      final token = await userSessionController.getDeviceToken();
      final response = await NotificationService.instance.updateDeviceToken({
        "token": token,
        // "deviceId": deviceId
      });

      print('register token resposne ${response.data}');
    } catch (e) {
      print('register token error ${e}');
    }
  }
}