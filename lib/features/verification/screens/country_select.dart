import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:swappr/common/widgets/buttons/elevated_button.dart';
import 'package:swappr/features/verification/screens/identity_verification_type.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class CountrySelectionPage extends StatelessWidget {
  const CountrySelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.secondaryBorder,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {Get.back();},
            child: const Icon(Icons.arrow_back_ios_outlined)
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(
                      style: Theme.of(context).textTheme.headlineLarge,
                      children: const <TextSpan> [
                        TextSpan(
                            text: 'Select Country',
                            style: TextStyle(fontSize: 20)
                        ),
                      ]
                  )
              ),
              const SizedBox(height: TSizes.defaultSpace * 2,),
              TElevatedButton(
                  onTap: (){
                    Get.to(() => const IdentityVerificationTypeScreen());
                  },
                  buttonText: 'Select'
              )
            ],
          ),
        ),
      ),
    );
  }
}
