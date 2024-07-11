import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/common/widgets/buttons/elevated_button.dart';
import 'package:pouch/features/home/screens/home.dart';
import 'package:pouch/features/verification/icons/svg.dart';
import 'package:pouch/utils/constants/colors.dart';
import 'package:pouch/utils/constants/sizes.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';

class VerificationSuccessScreen extends StatelessWidget {
  const VerificationSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.secondaryBorder,
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
                          style: TextStyle(fontSize: 20)
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
                          style: TextStyle(height: 1.5)
                      ),
                    ]
                )
            ),
            SizedBox(height: THelperFunctions.screenHeight() * 0.1),
            Container(
              padding: const EdgeInsets.only(left: TSizes.defaultSpace, right: TSizes.defaultSpace, bottom: TSizes.defaultSpace * 2, top: 10),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF111E32).withOpacity(0.5),
                      offset: const Offset(1.8,3.9),
                      blurRadius: 1.94,
                      spreadRadius: 1.08
                    ),
                    BoxShadow(
                        color: TColors.secondaryBorder,
                        offset: const Offset(1.0,0.0),
                        blurRadius: 0,
                        spreadRadius: 0
                    ),
                  ]
              ),
              child: Column(
                children: [
                  const Image(image: AssetImage('assets/icons/verifyIcons/success.png')),
                  const SizedBox(height: TSizes.defaultSpace),
                  RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                          style: TextStyle(
                              color: TColors.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
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
                ],
              ),
            ),
            const SizedBox(height: TSizes.defaultSpace * 2),
            SizedBox(
              height: 40,
              child: TElevatedButton(
                  onTap: () {
                    Get.to(() => const HomeScreen());
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
