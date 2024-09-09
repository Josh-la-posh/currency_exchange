import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/common/widgets/buttons/elevated_button.dart';
import 'package:pouch/common/widgets/buttons/outlined_button.dart';
import 'package:pouch/features/verification/screens/verification_process.dart';
import 'package:pouch/utils/constants/colors.dart';
import 'package:pouch/utils/constants/sizes.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
       backgroundColor: darkMode ? TColors.black.withOpacity(0.1) : TColors.secondaryBorder,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 50, bottom: TSizes.spaceBtwSections * 2, left: TSizes.defaultSpace * 1.4, right: TSizes.defaultSpace * 1.4 ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                InkWell(
                    onTap: () {Get.back();},
                    child: const Icon(Icons.arrow_back_ios_outlined)
                ),
              ],
            ),
            SizedBox(height: 20,),
            const SizedBox(
              height: 140,
                width: 180,
                child: Image(image: AssetImage('assets/icons/verifyIcons/verify_icon.png'))
            ),
            const SizedBox(height: TSizes.defaultSpace * 2,),
            RichText(
                text: TextSpan(
                    style: Theme.of(context).textTheme.headlineLarge,
                    children: <TextSpan> [
                      TextSpan(
                          text: 'Verify Your Identity!',
                          // style: TextStyle(color: TColors.textPrimaryO80)
                      ),
                    ]
                )
            ),
            const SizedBox(height: TSizes.defaultSpace * 2,),
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                  text: TextSpan(
                      style: Theme.of(context).textTheme.bodySmall,
                      children: <TextSpan> [
                        TextSpan(
                          text: 'To ensure the security of your account and provide you with the best possible experience, we need to verify your identity. This process helps protect your personal information and allows us to offer personalized services.',
                          style: TextStyle(
                              height: 1.6,
                              // color: TColors.textPrimaryO80
                          )
                        ),
                      ]
                  )
              ),
            ),
            const SizedBox(height: TSizes.defaultSpace * 2,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: TColors.primary,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: TColors.black.withOpacity(0.39),
                      width: 1
                    )
                  ),
                ),
                const SizedBox(width: TSizes.xs,),
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                          color: darkMode ? TColors.primary.withOpacity(0.8) : TColors.black.withOpacity(0.39),
                          width: 1
                      )
                  ),
                ),
                const SizedBox(width: TSizes.xs,),
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                          color: darkMode ? TColors.primary.withOpacity(0.8) : TColors.black.withOpacity(0.39),
                          width: 1
                      )
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.defaultSpace * 2,),
            Container(
              height: 41,
              width: 242,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10)
              ),
              child: darkMode
                  ? TElevatedButton(
                onTap: (){
                    Get.to(() => const VerificationProcess());
                  },
                  buttonText: 'Next',
                // backgroundColor: Colors.transparent,
              )
                  : TOutlinedButton(
                onTap: (){
                  Get.to(() => const VerificationProcess());
                },
                buttonText: 'Next',
                backgroundColor: Colors.transparent,
              ),
            ),
            const SizedBox(height: TSizes.defaultSpace,),
            TextButton(
                onPressed: (){},
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    color: TColors.primary,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    fontSize: 16
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
