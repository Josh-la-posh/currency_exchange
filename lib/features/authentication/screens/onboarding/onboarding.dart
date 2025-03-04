import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swappr/common/widgets/buttons/outlined_button.dart';
import 'package:swappr/features/authentication/screens/login/login.dart';
import 'package:swappr/features/authentication/screens/sign_up/sign_up.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/common/widgets/buttons/elevated_button.dart';
import 'package:swappr/utils/constants/image_strings.dart';
import 'package:swappr/utils/constants/sizes.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: THelperFunctions.screenHeight(),
        padding: const EdgeInsets.only(left: TSizes.defaultSpace, right: TSizes.defaultSpace, top: TSizes.defaultSpace, bottom: TSizes.defaultSpace * 3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                    child: Image(image: AssetImage(TImages.appLogoPng))
                ),
                const SizedBox(height: TSizes.md),
                RichText(
                    text: TextSpan(
                        style: Theme.of(context).textTheme.headlineMedium,
                        children: const <TextSpan> [
                          TextSpan(
                            text: 'Welcome to Pouch!',
                            style: TextStyle(
                              fontWeight: TSizes.fontWeightMd
                            )
                          )
                        ]
                    )
                ),
              ],
            ),
            Column(
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
                  onTap: (){Get.to(() => const CreateAccountScreen());},
                  buttonText: 'Sign Up',
                ),
                const SizedBox(height: TSizes.spaceBtwButtons,),
                TOutlinedButton(
                  onTap: (){Get.to(() => const LoginScreen());},
                  buttonText: 'Log In',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
