// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class NoificationRepository {
//   static AndroidNotificationChannel channel = const AndroidNotificationChannel(
//     'Channel_id',
//     'Channel_title',
//     description: 'This channel is used for important notifications.',
//     importance: Importance.high,
//     playSound: true,
//   );
//
// // Creating notification channel
//   static Future<void> notificationPlugin()async {
//     final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(notificationChannel);
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//     AndroidFlutterLocalNotificationsPlugin>()
//         ?.requestNotificationsPermission();
// // Android Initialization
//     AndroidInitializationSettings initializationSettingsAndroid =
//     const AndroidInitializationSettings('@mipmap/ic_launcher');
// // iOS initialization
//     DarwinInitializationSettings iosInitializationSettings =
//     DarwinInitializationSettings(
//       onDidReceiveLocalNotification: (id, title, body, payload) async {
//         return await showDialog(
//           context: Messaging.openContext,
//           builder: (BuildContext context) => CupertinoAlertDialog(
//             title: Text(title ?? ""),
//             content: Text(body ?? ""),
//             actions: [
//               CupertinoDialogAction(
//                 isDefaultAction: true,
//                 child: const Text('Ok'),
//                 onPressed: () async {
//                   Navigator.of(context, rootNavigator: true).pop();
//                   await Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => Screen(
//                         text: '',
//                       ),
//                     ),
//                   );
//                 },
//               )
//             ],
//           ),
//         );
//       },
//     );
// // Initializing android and iOS settings
//     InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: iosInitializationSettings,
//     );
// // Initializing flutter local notification
//     flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onDidReceiveNotificationResponse: (details) async {
//           await Navigator.push(
//             Messaging.openContext,
//             MaterialPageRoute<void>(
//                 builder: (context) => Screen(text: details.toString())),
//           );
//         }
//     );
//   }
// }