import 'package:flutter/material.dart';

import '../../features/notification/model/get_user_notification.dart';

class NotificationProvider extends ChangeNotifier {
  List<GetUserNotification> _userNotifications = [];
  List _socketNotifications = [];
  List<String> idsArray = [];

  List<GetUserNotification> get userNotifications => _userNotifications;
  List get socketNotifications => _socketNotifications;

  void saveUserNotifications(List<GetUserNotification> val) {
    _userNotifications = val;
    notifyListeners();
  }

  void updateNotificationLength(List val) {
    _socketNotifications = val;
    List socketIds = val.map((item) => item['id'].toString()).toList();
    idsArray = socketIds.map((id) => id.toString()).toList();
    print(idsArray);
    notifyListeners();
  }

  resetState() {
    _userNotifications = [];
  }
}