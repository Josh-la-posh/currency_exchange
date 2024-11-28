import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pouch/features/notification/controller/notification_controller.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../data/modules/storage_session_controller.dart';

class SocketManager {
  final NotificationController notificationController = Get.put(NotificationController());
  final userSessionController = Get.find<UserSessionController>();

  static final SocketManager singleton = SocketManager._internal();
  SocketManager._internal();
  static SocketManager get shared => singleton;

  void initSocket() async {
    String? token = await userSessionController.getAccessToken();
    IO.Socket socket = IO.io('https://api-uat.mypouch.me', <String, dynamic> {
      'transports': ['websocket'],
      'autoConnect': true,
      'extraHeaders': {
        'Authorization': 'Bearer $token'
      },
      'timeout': 5000,
    });

    socket.onConnect((_) {
      print('connect');
      socket.emit('notification', 'test');
    });

    socket.on("connect", (data) {
      print('socket connected with ease');
      if (kDebugMode) {
        print("Socket Connect Done");
      }
    });

    socket.on("connect_error", (data) {
      if (kDebugMode) {
        print("Socket connect_error");
        print('resal errrro $data');
      }
    });

    socket.on("reconnect_attempt", (attempt) {
      if (kDebugMode) {
        print("Reconnect attempt: $attempt");
      }
    });

    socket.on("error", (data) {
      if (kDebugMode) {
        print("Socket error");
        print(data);
      }
    });

    socket.on("notification", (data) {
      if (kDebugMode) {
        print("UpdateSocket ----------------------");
        notificationController.notificationLength(data);
        print('The data foun cand be called: $data');
      }
    });

    socket.on("disconnect", (data) {
      if (kDebugMode) {
        print("Socket disconnect");
      }
    });
  }
}