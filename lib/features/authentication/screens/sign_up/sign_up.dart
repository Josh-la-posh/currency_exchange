import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:swappr/features/authentication/screens/login/login.dart';
import 'package:swappr/features/authentication/screens/sign_up/widgets/sign_up_form.dart';

import '../../../../common/styles/spacing_styles.dart';
import '../../../../common/widgets/buttons/app_bar.dart';
import '../../../../utils/constants/sizes.dart';
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Sign Up',),
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to Swappr!',
                style: Theme.of(context).textTheme.headlineLarge,
              ),

              /// Form
              SignUpForm(),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              Center(
                child: TextButton(
                    onPressed: (){Get.offAll(const LoginScreen());},
                    child: Text('Already signed up? Log In', style: Theme.of(context).textTheme.labelMedium,)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
