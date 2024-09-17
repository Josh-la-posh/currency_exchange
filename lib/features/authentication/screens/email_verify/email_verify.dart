import 'package:flutter/material.dart';
import 'package:pouch/features/authentication/screens/email_verify/widgets/email_verify_form.dart';
import 'package:pouch/utils/layouts/auth_layout.dart';

class EmailVerificationScreen extends StatelessWidget {
  final String email;
  final String password;
  const EmailVerificationScreen({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
        title: '', heading: 'Email Verification',
        child: EmailVerificationForm(email: email, password: password,)
    );
  }
}