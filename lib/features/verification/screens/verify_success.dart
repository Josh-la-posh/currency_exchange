import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swappr/common/widgets/buttons/elevated_button.dart';
import 'package:swappr/features/home/screens/home.dart';
import 'package:swappr/features/verification/icons/svg.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/constants/sizes.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';

class VerificationSuccessScreen extends StatelessWidget {
  const VerificationSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.secondaryBorder,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace * 3),
        child: Column(
          children: [
            SizedBox(height: THelperFunctions.screenHeight() * 0.2),
            const Image(image: AssetImage('assets/icons/verifyIcons/success.png')),
            const SizedBox(height: TSizes.defaultSpace),
            RichText(
              textAlign: TextAlign.center,
                text: const TextSpan(
                    style: TextStyle(
                      color: TColors.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto',
                      height: 1.5
                    ),
                    children: <TextSpan> [
                      TextSpan(
                          text: 'Your  account has been successfully verified.',
                      ),
                    ]
                )
            ),
            const SizedBox(height: TSizes.defaultSpace * 2),
            TElevatedButton(
                onTap: () {
                  Get.to(() => const HomeScreen());
                },
                buttonText: 'Go To Dashboard'
            )
          ],
        ),
      ),
    );
  }
}
