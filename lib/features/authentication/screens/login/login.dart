import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:swappr/common/styles/spacing_styles.dart';
import 'package:swappr/features/authentication/screens/login/widgets/login_form.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/constants/sizes.dart';

import '../../../../common/widgets/buttons/app_bar.dart';
import '../sign_up/sign_up.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Log In',),
      body: SingleChildScrollView(
        child: Padding(
            padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back!',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              /// Form
              LoginForm(),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              Center(
                  child: TextButton(
                      onPressed: (){Get.offAll(SignUpScreen());},
                      child: Text('No account yet? Sign Up', style: Theme.of(context).textTheme.labelMedium,)
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

