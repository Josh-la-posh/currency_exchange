import 'package:flutter/material.dart';
import 'package:pouch/features/profile/routes/names.dart';
import 'package:pouch/features/profile/screens/bank_account/add_bank_account.dart';
import 'package:pouch/features/profile/screens/security/biometric_authentication.dart';
import 'package:pouch/features/profile/screens/security/change_password.dart';
import 'package:pouch/features/profile/screens/profile.dart';
import 'package:pouch/features/profile/screens/security/security.dart';
import '../../../data/routes/guard_route.dart';
import '../screens/bank_account/bank_account.dart';


Map<String, WidgetBuilder> profileRoutes = {
  PROFILE_SCREEN_ROUTE: (context) => const ProfileScreen(),
  BANK_ACCOUNT_SCREEN_ROUTE: (context) => AuthGuard(
    widget: BankAccountScreen()),
  ADD_BANK_ACCOUNT_SCREEN_ROUTE: (context) => AuthGuard(
    widget: AddBankAccountScreen(),
  ),
  CHANGE_PASSWORD_SCREEN_ROUTE: (context) => AuthGuard(
    widget: ChangePasswordScreen(),
  ),
  SECURITY_SCREEN_ROUTE: (context) => SecurityScreen(),
  BIOMETRIC_SCREEN_ROUTE: (context) => BiometricAuthenticationScreen(),
};
