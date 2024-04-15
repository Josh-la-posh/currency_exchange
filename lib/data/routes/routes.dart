import 'package:flutter/material.dart';
import 'package:swappr/features/home/routes/routes.dart';
import 'package:swappr/features/profile/routes/routes.dart';
import 'package:swappr/features/subscription/routes/routes.dart';
import 'package:swappr/features/transaction_history/routes/routes.dart';

import '../../features/authentication/models/routes/routes.dart';

Route _createCustomRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0.0); // Start position (off-screen to the right)
      var end = Offset.zero; // End position (centered)
      var curve = Curves.ease; // Define the animation curve

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

Map<String, WidgetBuilder> routes = {
  // ...splashRoutes,
  ...authRoutes,
  ...subscriptionRoutes,
  ...transactionRoutes,
  ...profileRoutes,
  ...homeRoute
};


