import 'package:flutter/material.dart';
import 'package:pouch/features/notification/screens/notification.dart';
import '../../../data/routes/guard_route.dart';
import 'named.dart';


Map<String, WidgetBuilder> notificationRoutes = {
  NOTIFICATION_SCREEN_ROUTE: (context) => AuthGuard(widget: NotificationScreen()),
};
