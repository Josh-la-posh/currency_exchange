import 'package:flutter/material.dart';
import 'package:pouch/features/subscription/routes/names.dart';
import 'package:pouch/features/subscription/screens/add_subscription.dart';
import 'package:pouch/features/subscription/screens/subscribe.dart';
import '../../../data/routes/guard_route.dart';

// Map<String, WidgetBuilder> subscriptionRoutes = {
//   SUBSCRIPTION_SCREEN_ROUTE: (context) => const SubscribeScreen(),
//   CREATE_SUBSCRIPTION_SCREEN: (context) => const AddSubscriptionScreen(),
// };



Map<String, WidgetBuilder> subscriptionRoutes = {
  SUBSCRIPTION_SCREEN_ROUTE: (context) => AuthGuard(widget: SubscribeScreen()),
  CREATE_SUBSCRIPTION_SCREEN: (context) => AuthGuard(
    widget: AddSubscriptionScreen(),
  ),
};
