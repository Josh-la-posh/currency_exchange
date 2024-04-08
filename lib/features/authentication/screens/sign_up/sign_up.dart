import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:swappr/features/authentication/screens/login/login.dart';
import 'package:swappr/features/authentication/screens/sign_up/widgets/sign_up_form.dart';
import 'package:swappr/utils/layouts/auth_layout.dart';

import '../../../../common/styles/spacing_styles.dart';
import '../../../../common/widgets/buttons/app_bar.dart';
import '../../../../utils/constants/sizes.dart';
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(title: 'Welcome to Swappr!', heading: 'Sign Up', child: SignUpForm());
  }
}
