import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/verification/screens/verification_in_progress.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class IdentityVerificationScreen extends StatelessWidget {
  String? type;
  IdentityVerificationScreen({
    super.key,
    this.type,
  });

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
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.only(left: TSizes.defaultSpace / 1.5),
                  height: 52,
                  decoration: BoxDecoration(
                      color: darkMode ? TColors.white.withOpacity(0.5) : TColors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    children: [
                      // SizedBox(
                      //     width: 40,
                      //     height: 40,
                      //     child: Image(image: AssetImage(image))
                      // ),
                      // const SizedBox(width: TSizes.lg),
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.titleMedium,
                              children: <TextSpan> [
                                TextSpan(
                                  text: type,
                                  style: TextStyle(
                                    color: darkMode ? TColors.white : TColors.textPrimaryO80,
                                  )
                                ),
                              ]
                          )
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: TSizes.defaultSpace),
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: Theme.of(context).textTheme.bodySmall,
                      children: <TextSpan> [
                        TextSpan(
                            text: 'Please upload Your Valid  Driver’s license for Verification',
                            style: TextStyle(
                                height: 1.5,
                                // color: TColors.textPrimaryO80
                            )
                        ),
                      ]
                  )
              ),
              const SizedBox(height: TSizes.defaultSpace),
              Container(
                width: 180,
                height: 142,
                decoration: BoxDecoration(
                  color: TColors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
              const SizedBox(height: TSizes.defaultSpace * 2),
              Container(
                height: 47,
                width: 205,
                decoration: BoxDecoration(
                  color: TColors.darkSecButton,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: TColors.primary,
                    width: 1
                  )
                ),
                child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(TColors.darkSecButton),
                        iconSize: MaterialStatePropertyAll(47),
                    ),
                    onPressed: (){
                      Get.to(() => const VerificationInProgressScreen());
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          color: darkMode ? TColors.white : TColors.textPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
