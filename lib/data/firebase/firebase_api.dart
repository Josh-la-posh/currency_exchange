import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../../features/notification/screens/notification.dart';

class FirebaseApi {

  // create an instance of Firebase Messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    // request permission from user
    await _firebaseMessaging.requestPermission();

    // fetch the FCM token for this device
    final fcmToken = await _firebaseMessaging.getToken();

    // print the token
    print('Token: $fcmToken');

    initPushNotifications();
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
}