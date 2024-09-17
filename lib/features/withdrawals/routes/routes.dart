import 'package:flutter/material.dart';
import 'package:pouch/features/withdrawals/routes/names.dart';
import '../../../data/routes/guard_route.dart';
import '../screens/withdrawal.dart';


Map<String, WidgetBuilder> withdrawRoute = {
  WITHDRAWAL_SCREEN_ROUTE: (context) => AuthGuard(
    widget: WithdrawalScreen(),
  ),
};
