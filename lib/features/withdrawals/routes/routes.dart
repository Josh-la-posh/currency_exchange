import 'package:flutter/material.dart';
import 'package:pouch/features/withdrawals/routes/names.dart';
import 'package:pouch/features/withdrawals/screens/foreign_withdrawal.dart';
import 'package:pouch/features/withdrawals/screens/local_withdrawal.dart';
import '../../../data/routes/guard_route.dart';
import '../screens/withdrawal.dart';


Map<String, WidgetBuilder> withdrawRoute = {
  WITHDRAWAL_SCREEN_ROUTE: (context) => AuthGuard(
    widget: WithdrawalScreen(),
  ),
  LOCAL_WITHDRAWAL_SCREEN_ROUTE: (context) => AuthGuard(
    widget: LocalWithdrawalScreen(),
  ),
  FOREIGN_WITHDRAWAL_SCREEN_ROUTE: (context) => AuthGuard(
    widget: ForeignWithdrawalScreen(),
  ),
};
