import 'package:flutter/material.dart';
import 'package:swappr/features/authentication/screens/forgot_poassword/widgets/forgot_password_form.dart';
import 'package:swappr/utils/layouts/auth_layout.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(title: 'Enter your email', heading: 'Forgot password', child: const ForgetPasswordForm());
  }
}


