import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/common/widgets/buttons/elevated_button.dart';
import 'package:pouch/features/home/screens/home.dart';
import 'package:pouch/features/verification/icons/svg.dart';
import 'package:pouch/utils/constants/colors.dart';
import 'package:pouch/utils/constants/sizes.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import 'package:pouch/utils/layouts/navigation_menu.dart';

class VerificationInProgressScreen extends StatelessWidget {
  const VerificationInProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: darkMode ? TColors.black.withOpacity(0.8) : TColors.secondaryBorder,
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace * 2),
        child: Column(
          children: [
            RichText(
                text: TextSpan(
                    style: Theme.of(context).textTheme.headlineLarge,
                    children: const <TextSpan> [
                      TextSpan(
                          text: 'Identity Verification',
                          style: TextStyle(
                              fontSize: 20,
                              // color: TColors.textPrimaryO80
                          )
                      ),
                    ]
                )
            ),
            const SizedBox(height: TSizes.defaultSpace),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: Theme.of(context).textTheme.bodySmall,
                    children: const <TextSpan> [
                      TextSpan(
                          text: 'A 60-second timer has begun. Your photo from the chosen document will be used for comparison.',
                          style: TextStyle(
                              height: 1.5,
                              // color: TColors.textPrimaryO80
                          )
                      ),
                    ]
                )
            ),
            SizedBox(height: THelperFunctions.screenHeight() * 0.1),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace * 2),
              decoration: BoxDecoration(
                  color: darkMode ? TColors.black.withOpacity(0.8) : TColors.secondaryBorder,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: TColors.black.withOpacity(0.3),
                        offset: const Offset(1.72,2.24),
                        blurRadius: 1.94,
                        spreadRadius: 1.94
                    ),
                    BoxShadow(
                        color: TColors.secondaryBorder,
                        offset: const Offset(0.0,0.0),
                        blurRadius: 0,
                        spreadRadius: 0
                    ),
                  ]
              ),
              child: Column(
                children: [
                  RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.headlineLarge,
                          children: const <TextSpan> [
                            TextSpan(
                                text: 'Verification in progress',
                                style: TextStyle(
                                    fontSize: 20,
                                    // color: TColors.textPrimaryO80
                                )
                            ),
                          ]
                      )
                  ),
                  const SizedBox(height: TSizes.defaultSpace),
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          style: Theme.of(context).textTheme.bodySmall,
                          children: const <TextSpan> [
                            TextSpan(
                                text: 'Your account is currently undergoing verification. If you have any questions or need assistance, feel free to contact customer support.',
                                style: TextStyle(
                                  height: 1.5,
                                  fontSize: 9,
                                    // color: TColors.textPrimaryO80
                                )
                            ),
                          ]
                      )
                  ),
                  const SizedBox(height: TSizes.defaultSpace),
                  RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                          style: TextStyle(
                              color: TColors.primary,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Roboto',
                              height: 1.5
                          ),
                          children: <TextSpan> [
                            TextSpan(
                              text: 'Thank you for your patience.',
                            ),
                          ]
                      )
                  ),
                ],
              ),
            ),
            const SizedBox(height: TSizes.defaultSpace * 2),
            SizedBox(
              height: 40,
              child: TElevatedButton(
                  onTap: () {
                    Get.to(() => const NavigationMenu());

                  },
                  buttonText: 'Go To Dashboard'
              ),
            )
          ],
        ),
      ),
    );
  }
}
