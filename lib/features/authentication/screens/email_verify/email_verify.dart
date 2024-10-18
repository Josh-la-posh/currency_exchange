import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/data/modules/storage_session_controller.dart';
import 'package:pouch/features/authentication/screens/email_verify/widgets/email_verify_form.dart';
import 'package:pouch/utils/layouts/auth_layout.dart';

import '../../controllers/email_verification_controller.dart';

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
    UserSessionController userSessionController = Get.find();
    EmailVerificationController controller = Get.put(EmailVerificationController(
      sendEmailOtpOnBuild: false,
      email: email,
      password: password,
    ));
    return AuthLayout(
        title: '', heading: 'Email Verification',
        onTap: () {
          userSessionController.clearRememberMeHandler();
          Get.back();
        },
        child: EmailVerificationForm()
    );
  }
}