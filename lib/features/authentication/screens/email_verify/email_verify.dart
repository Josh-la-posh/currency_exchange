import 'package:flutter/material.dart';
import 'package:swappr/common/styles/spacing_styles.dart';
import 'package:swappr/features/authentication/screens/email_verify/widgets/email_verify_form.dart';
import 'package:swappr/utils/layouts/auth_layout.dart';
import '../../../../common/widgets/buttons/app_bar.dart';

class EmailVerificationScreen extends StatelessWidget {
  final bool sendEmailOtpOnBuild;
  final String email;
  final VoidCallback? onSuccess;
  const EmailVerificationScreen({
    super.key,
    this.sendEmailOtpOnBuild = false,
    required this.email,
    this.onSuccess = null
  });

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
        title: '', heading: 'Email Verification',
        child: EmailVerificationForm(email: email)
    );
  }
}