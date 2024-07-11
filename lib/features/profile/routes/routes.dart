import 'package:flutter/material.dart';
import 'package:pouch/features/profile/routes/names.dart';
import 'package:pouch/features/profile/screens/bank_account/add_bank_account.dart';
import 'package:pouch/features/profile/screens/change_password.dart';
import 'package:pouch/features/profile/screens/profile.dart';
import '../../../data/routes/guard_route.dart';
import '../screens/bank_account/bank_account.dart';


Map<String, WidgetBuilder> profileRoutes = {
  PROFILE_SCREEN_ROUTE: (context) => const AuthGuard(widget: ProfileScreen()),
  BANK_ACCOUNT_SCREEN_ROUTE: (context) => const AuthGuard(
    widget: BankAccountScreen()),
  ADD_BANK_ACCOUNT_SCREEN_ROUTE: (context) => const AuthGuard(
    widget: AddBankAccountScreen(),
  ),
  CHANGE_PASSWORD_SCREEN_ROUTE: (context) => const AuthGuard(
    widget: ChangePasswordScreen(),
  ),
};
