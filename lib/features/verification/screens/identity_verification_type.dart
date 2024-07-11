import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pouch/features/verification/screens/identity_verification.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class IdentityVerificationTypeScreen extends StatelessWidget {
  const IdentityVerificationTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: darkMode ? TColors.black.withOpacity(0.8) : TColors.secondaryBorder,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {Get.back();},
            child: const Icon(Icons.arrow_back_ios_outlined)
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace * 2),
          child: Column(
            children: [
              RichText(
                  text: TextSpan(
                      style: Theme.of(context).textTheme.headlineLarge,
                      children: <TextSpan> [
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
                      children: <TextSpan> [
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
              const SizedBox(height: TSizes.defaultSpace * 2),
              GestureDetector(
                onTap: () {
                  Get.to(() => IdentityVerificationScreen(
                    type: 'Passport',
                  ));
                },
                child: Container(
                  padding: const EdgeInsets.only(left: TSizes.defaultSpace / 1.5),
                  height: 52,
                  decoration: BoxDecoration(
                    color: darkMode ? TColors.white.withOpacity(0.5) : TColors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 40,
                          height: 40,
                          child: Image(image: AssetImage('assets/icons/verifyIcons/passport.png'))
                      ),
                      const SizedBox(width: TSizes.lg),
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.titleMedium,
                              children: <TextSpan> [
                                TextSpan(
                                    text: 'Passport',
                                    style: TextStyle(
                                        color: darkMode ? TColors.white : TColors.textPrimaryO80
                                    )
                                ),
                              ]
                          )
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: TSizes.defaultSpace * 1.4),
              GestureDetector(
                onTap: () {
                  Get.to(() => IdentityVerificationScreen(type: 'Driver\'s License',));
                },
                child: Container(
                  padding: const EdgeInsets.only(left: TSizes.defaultSpace / 1.5),
                  height: 52,
                  decoration: BoxDecoration(
                      color: darkMode ? TColors.white.withOpacity(0.5) : TColors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                          width: 40,
                          height: 40,
                          child: Image(image: AssetImage('assets/icons/verifyIcons/license.png'))
                      ),
                      const SizedBox(width: TSizes.lg),
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.titleMedium,
                              children: <TextSpan> [
                                TextSpan(
                                  text: 'Driver\'s License',
                                    style: TextStyle(
                                        color: darkMode ? TColors.white : TColors.textPrimaryO80
                                    )
                                ),
                              ]
                          )
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: TSizes.defaultSpace * 1.4),
              GestureDetector(
                onTap: () {
                  Get.to(() => IdentityVerificationScreen(type: 'National ID Card',));
                },
                child: Container(
                  padding: const EdgeInsets.only(left: TSizes.defaultSpace / 1.5),
                  height: 52,
                  decoration: BoxDecoration(
                      color: darkMode ? TColors.white.withOpacity(0.5) : TColors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                          width: 40,
                          height: 40,
                          child: Image(image: AssetImage('assets/icons/verifyIcons/national_id.png'))
                      ),
                      const SizedBox(width: TSizes.lg),
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.titleMedium,
                              children: <TextSpan> [
                                TextSpan(
                                  text: 'National ID Card',
                                    style: TextStyle(
                                        color: darkMode ? TColors.white : TColors.textPrimaryO80
                                    )
                                ),
                              ]
                          )
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: TSizes.defaultSpace * 1.4),
              GestureDetector(
                onTap: () {
                  Get.to(() => IdentityVerificationScreen(type: 'BVN',));
                },
                child: Container(
                  padding: const EdgeInsets.only(left: TSizes.defaultSpace / 1.5),
                  height: 52,
                  decoration: BoxDecoration(
                      color: darkMode ? TColors.white.withOpacity(0.5) : TColors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                          width: 40,
                          height: 40,
                          child: Image(image: AssetImage('assets/icons/verifyIcons/bvn.png'))
                      ),
                      const SizedBox(width: TSizes.lg),
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.titleMedium,
                              children: <TextSpan> [
                                TextSpan(
                                  text: 'BVN',
                                    style: TextStyle(
                                        color: darkMode ? TColors.white : TColors.textPrimaryO80
                                    )
                                ),
                                const TextSpan(
                                  text: '*',
                                  style: TextStyle(
                                    color: TColors.danger,
                                    fontSize: 7,
                                    fontFeatures: [FontFeature.superscripts()]
                                  )
                                ),
                              ]
                          )
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
