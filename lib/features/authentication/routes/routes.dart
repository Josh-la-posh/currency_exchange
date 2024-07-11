import 'package:flutter/material.dart';
import 'package:pouch/features/authentication/screens/reset_password/forgot_password.dart';
import 'package:pouch/features/authentication/screens/onboarding/onboarding.dart';
import '../screens/login/login.dart';
import '../screens/sign_up/sign_up.dart';
import 'names.dart';


Map<String, WidgetBuilder> authRoutes = {
  AUTH_ONBOARDING_SCREEN_ROUTE: (context) => const OnboardingScreen(),
  AUTH_CREATE_ACCOUNT_SCREEN_ROUTE: (context) => const CreateAccountScreen(),
  AUTH_LOGIN_SCREEN_ROUTE: (context) => const LoginScreen(),
  AUTH_FORGOT_PASSWORD_SCREEN_ROUTE: (context) => const ForgotPasswordScreen(),
};

