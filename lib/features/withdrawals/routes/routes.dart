import 'package:flutter/material.dart';
import 'package:swappr/features/withdrawals/routes/names.dart';
import 'package:swappr/features/withdrawals/screens/withdrawal_success.dart';
import '../../../data/routes/guard_route.dart';
import '../screens/withdrawal.dart';


Map<String, WidgetBuilder> withdrawRoute = {
  WITHDRAWAL_SCREEN_ROUTE: (context) => const AuthGuard(
    widget: WithdrawalScreen(),
  ),
};
