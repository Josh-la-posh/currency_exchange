import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pouch/common/widgets/buttons/elevated_button.dart';
import 'package:pouch/features/verification/controller/verification_controller.dart';
import 'package:pouch/features/verification/screens/identity_verification_type.dart';
import 'package:country_picker/country_picker.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class CountrySelectionPage extends StatelessWidget {
  final verificationController = Get.find<VerificationController>();

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: darkMode ? TColors.black.withOpacity(0.8) : TColors.secondaryBorder,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: RichText(
            text: TextSpan(
                style: Theme.of(context).textTheme.headlineLarge,
                children: <TextSpan> [
                  TextSpan(
                      text: 'Verification Process',
                      style: TextStyle(
                        fontSize: 20,
                        // color: TColors.textPrimaryO80
                      )
                  ),
                ]
            )
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Row(
              children: [
                SizedBox(
                  width: 110,
                  child: RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.labelSmall,
                          children: <TextSpan> [
                            TextSpan(
                                text: 'ISO Code:',
                                style: TextStyle(
                                  fontSize: 16,
                                  // color: TColors.textPrimaryO80
                                )
                            ),
                          ]
                      )
                  ),
                ),
                SizedBox(width: 20,),
                RichText(
                    text: TextSpan(
                        style: Theme.of(context).textTheme.headlineLarge,
                        children: <TextSpan> [
                          TextSpan(
                              text: verificationController.selectedCountry.value?.countryCode,
                              style: TextStyle(
                                fontSize: 18,
                                // color: TColors.textPrimaryO80
                              )
                          ),
                        ]
                    )
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                SizedBox(
                  width: 110,
                  child: RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.labelSmall,
                          children: <TextSpan> [
                            TextSpan(
                                text: 'Country Code:',
                                style: TextStyle(
                                  fontSize: 16,
                                  // color: TColors.textPrimaryO80
                                )
                            ),
                          ]
                      )
                  ),
                ),
                SizedBox(width: 20,),
                RichText(
                    text: TextSpan(
                        style: Theme.of(context).textTheme.headlineLarge,
                        children: <TextSpan> [
                          TextSpan(
                              text: '+${verificationController.selectedCountry.value?.phoneCode}',
                              style: TextStyle(
                                fontSize: 18,
                                // color: TColors.textPrimaryO80
                              )
                          ),
                        ]
                    )
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                SizedBox(
                  width: 110,
                  child: RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.labelSmall,
                          children: <TextSpan> [
                            TextSpan(
                                text: 'Country Name:',
                                style: TextStyle(
                                  fontSize: 16,
                                  // color: TColors.textPrimaryO80
                                )
                            ),
                          ]
                      )
                  ),
                ),
                SizedBox(width: 20,),
                RichText(
                    text: TextSpan(
                        style: Theme.of(context).textTheme.headlineLarge,
                        children: <TextSpan> [
                          TextSpan(
                              text: verificationController.selectedCountry.value?.name.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                // color: TColors.textPrimaryO80
                              )
                          ),
                        ]
                    )
                ),
              ],
            ),
            const SizedBox(height: TSizes.defaultSpace * 3,),
            TElevatedButton(
                onTap: (){
                  Get.to(() => IdentityVerificationTypeScreen());
                },
                buttonText: 'Proceed'
            ),
            SizedBox(height: 20,),
            TElevatedButton(
                onTap: (){
                  verificationController.selectedCountry.value = null;
                  Get.back();
                },
                buttonText: 'Back'
            )
          ],
        ),
      ),
    );
  }
}
