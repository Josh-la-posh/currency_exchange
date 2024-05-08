import 'package:flutter/material.dart';
import 'package:swappr/common/styles/spacing_styles.dart';
import 'package:swappr/features/authentication/screens/email_verify/widgets/email_verify_form.dart';
import 'package:swappr/features/authentication/screens/reset_password/widgets/reset_password_form.dart';
import 'package:swappr/utils/layouts/auth_layout.dart';
import '../../../../common/widgets/buttons/app_bar.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
        title: '', heading: 'Reset Password',
        child: const ResetPasswordForm()
    );
  }
}