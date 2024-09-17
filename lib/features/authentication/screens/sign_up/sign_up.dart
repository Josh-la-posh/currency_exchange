import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/authentication/screens/sign_up/widgets/sign_up_form.dart';
import 'package:pouch/utils/layouts/auth_layout.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/auth_form_controller.dart';

class CreateAccountScreen extends StatelessWidget {
  final authFormController = Get.put(AuthFormController());
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return AuthLayout(title: '', heading: 'Sign Up', child: SignUpForm());
  }
}
