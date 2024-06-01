import 'package:flutter/material.dart';
import '../../../data/routes/guard_route.dart';
import '../screens/home.dart';
import 'names.dart';


Map<String, WidgetBuilder> homeRoute = {
  DASHBOARD_SCREEN_ROUTE: (context) => const AuthGuard(widget: HomeScreen()),
};
