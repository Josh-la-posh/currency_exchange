import 'package:flutter/material.dart';
import 'package:swappr/common/styles/spacing_styles.dart';
import 'package:swappr/features/authentication/screens/email_verify/widgets/email_verify_form.dart';
import 'package:swappr/features/authentication/screens/reset_password/widgets/resetPasswordOtpForm.dart';
import 'package:swappr/features/authentication/screens/reset_password/widgets/reset_password_form.dart';
import 'package:swappr/utils/layouts/auth_layout.dart';
import '../../../../common/widgets/buttons/app_bar.dart';

class ResetPasswordOtpScreen extends StatelessWidget {
  final String email;
  const ResetPasswordOtpScreen({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
        title: '', heading: 'Reset Password',
        child: ResetPasswordOtpForm(email: email)
    );
  }
}