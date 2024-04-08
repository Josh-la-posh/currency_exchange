import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swappr/common/widgets/buttons/outlined_button.dart';
import 'package:swappr/features/authentication/screens/login/login.dart';
import 'package:swappr/features/authentication/screens/sign_up/sign_up.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/common/widgets/buttons/elevated_button.dart';
import 'package:swappr/utils/constants/sizes.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: THelperFunctions.screenHeight(),
        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace * 3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Swap NGN for GBP',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: TSizes.md),
            Text(
              'Cheap, Fast and Safe',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: TSizes.defaultSpace * 2),
            TElevatedButton(
              onTap: (){Get.to(() => const SignUpScreen());},
              buttonText: 'Sign Up',
            ),
            const SizedBox(height: TSizes.spaceBtwButtons,),
            TOutlinedButton(
              onTap: (){Get.to(() => const LoginScreen());},
              buttonText: 'Log In',
            ),
          ],
        ),
      ),
    );
  }
}
