import 'package:flutter/material.dart';
import 'package:swappr/features/profile/routes/names.dart';
import 'package:swappr/features/profile/screens/bank_accounts.dart';
import 'package:swappr/features/profile/screens/profile.dart';
import '../../../data/routes/guard_route.dart';

Map<String, WidgetBuilder> profileRoutes = {
  PROFILE_SCREEN: (context) => const AuthGuard(widget: ProfileScreen()),
  BANK_ACCOUNT_SCREEN: (context) => const AuthGuard(
    widget: BankAccounts(),
  ),
};
