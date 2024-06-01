import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swappr/features/verification/screens/country_select.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class VerificationProcess extends StatelessWidget {
  const VerificationProcess({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
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
          padding: const EdgeInsets.all(TSizes.defaultSpace * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                  text: TextSpan(
                      style: Theme.of(context).textTheme.headlineLarge,
                      children: const <TextSpan> [
                        TextSpan(
                          text: 'Verification Process',
                          style: TextStyle(fontSize: 20)
                        ),
                      ]
                  )
              ),
              const SizedBox(height: TSizes.defaultSpace * 2,),
              const SizedBox(
                  height: 100,
                  width: 100,
                  child: Image(image: AssetImage('assets/icons/verifyIcons/verify_process.png'))
              ),
              const SizedBox(height: TSizes.defaultSpace * 2,),
              RichText(
                  text: TextSpan(
                      style: Theme.of(context).textTheme.headlineLarge,
                      children: const <TextSpan> [
                        TextSpan(
                            text: 'Choose Your County',
                            style: TextStyle(fontSize: 18)
                        ),
                      ]
                  )
              ),
              const SizedBox(height: TSizes.defaultSpace * 1.5,),
              RichText(
                textAlign: TextAlign.center,
                  text: TextSpan(
                      style: Theme.of(context).textTheme.headlineLarge,
                      children: const <TextSpan> [
                        TextSpan(
                            text: 'Please Select Your Country for Verification. \n Thank You',
                            style: TextStyle(fontSize: 11, height: 1.4)
                        ),
                      ]
                  )
              ),
              const SizedBox(height: TSizes.defaultSpace * 1.5,),
              ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(TColors.darkPrimaryButton),
                  iconSize: MaterialStatePropertyAll(50)
                ),
                  onPressed: (){
                  Get.to(() => const CountrySelectionPage());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select Country',
                        style: TextStyle(
                          color: darkMode ? TColors.black : TColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      const Icon(Icons.arrow_right_alt_sharp)
                    ],
                  )
              )

            ],
          ),
        ),
      ),
    );
  }
}