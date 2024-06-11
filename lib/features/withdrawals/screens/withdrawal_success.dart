import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swappr/features/home/screens/home.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/constants/image_strings.dart';
import 'package:swappr/utils/constants/sizes.dart';
import 'package:swappr/utils/constants/texts.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';

class WithdrawalSuccessScreen extends StatelessWidget {
  const WithdrawalSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      backgroundColor: darkMode ? Colors.black : const Color(0xFFD0CDE1).withOpacity(0.31),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: THelperFunctions.screenHeight() * 0.13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: AssetImage(TImages.withdrawSuccess)),
              const SizedBox(height: TSizes.defaultSpace,),
              RichText(
                  text: const TextSpan(
                      style: TextStyle(
                          color: TColors.primary,
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                          fontFamily: 'Roboto'
                      ),
                      children: <TextSpan> [
                        TextSpan(
                          text: 'Withdrawal Successful!',
                        )
                      ]
                  )
              ),
              const SizedBox(height: TSizes.defaultSpace * 2),
              GestureDetector(
                onTap: () {
                  Get.to(() => const HomeScreen());
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 208,
                  height: 37,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      const BoxShadow(
                          color: TColors.primary,
                          offset: Offset(1.8,4.9),
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
                  child: const Text(
                    'Return to dashboard',
                    style: TextStyle(
                      color: TColors.primary,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      fontFamily: TTexts.fontFamily
                    ),
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
