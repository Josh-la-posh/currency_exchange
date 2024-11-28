import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pouch/features/authentication/screens/reset_password/widgets/resetPasswordOtpForm.dart';
import 'package:pouch/utils/layouts/auth_layout.dart';

import '../../controllers/reset_password_controller.dart';

class ResetPasswordOtpScreen extends StatelessWidget {
  final String email;
  const ResetPasswordOtpScreen({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    final ResetPasswordOtpFormController controller = Get.put(ResetPasswordOtpFormController(
      sendEmailOtpOnBuild: false,
      email: email,
    ));
    return AuthLayout(
        title: '', heading: 'Reset Password',
        child: ResetPasswordOtpForm(email: email)
    );
  }
}