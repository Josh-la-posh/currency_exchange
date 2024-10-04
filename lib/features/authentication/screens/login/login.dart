import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/authentication/screens/login/widgets/login_form.dart';
import 'package:pouch/features/authentication/screens/onboarding/onboarding.dart';
import 'package:pouch/utils/layouts/auth_layout.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      onTap: () {
        Get.to(() => const OnboardingScreen());
      },
      heading: 'Log In',
      title: 'Welcome Back!',
      child: LoginForm(),
    );
  }
}
