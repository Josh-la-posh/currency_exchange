import 'package:flutter/material.dart';

import '../../features/notification/model/get_user_notification.dart';

class NotificationProvider extends ChangeNotifier {
  List<GetUserNotification> _userNotifications = [];

  List<GetUserNotification> get userNotifications => _userNotifications;

  void saveUserNotifications(List<GetUserNotification> val) {
    _userNotifications = val;
    notifyListeners();
  }

  resetState() {
    _userNotifications = [];
  }
}