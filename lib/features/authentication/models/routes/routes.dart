import 'package:flutter/material.dart';
import 'package:swappr/features/authentication/screens/email_verify/email_verify.dart';
import 'package:swappr/features/authentication/screens/forgot_poassword/forgot_password.dart';
import 'package:swappr/features/authentication/screens/onboarding/onboarding.dart';

import '../../screens/login/login.dart';
import '../../screens/sign_up/sign_up.dart';
import 'names.dart';


Map<String, WidgetBuilder> authRoutes = {
  AUTH_ONBOARDING_SCREEN_ROUTE: (context) => const OnboardingScreen(),
  AUTH_CREATE_ACCOUNT_SCREEN_ROUTE: (context) => const CreateAccountScreen(),
  AUTH_LOGIN_SCREEN_ROUTE: (context) => const LoginScreen(),
  AUTH_FORGOT_PASSWORD_SCREEN_ROUTE: (context) => const ForgotPasswordScreen(),
  AUTH_VERIFY_EMAIL_SCREEN_ROUTE: (context) => const EmailVerificationScreen(),
  // AUTH_RESET_PASSWORD_OTP_SCREEN_ROUTE: (context) =>
  // const ResetPasswordOtpScreen(),
  // AUTH_NEW_PASSWORD_SCREEN_ROUTE: (context) => const AuthNewPasswordScreen(),
};

