import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/wallet/controller/wallet_controller.dart';
import 'package:pouch/utils/constants/colors.dart';
import 'package:pouch/utils/constants/image_strings.dart';
import 'package:pouch/utils/constants/sizes.dart';
import 'package:pouch/utils/constants/texts.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import 'package:provider/provider.dart';

import '../../../data/modules/app_navigator.dart';
import '../../../data/provider/transaction_provider.dart';
import '../../../data/provider/wallet_provider.dart';
import '../../../utils/layouts/navigation_menu.dart';
import '../../wallet/apis/api.dart';

class WithdrawalSuccessScreen extends StatelessWidget {
  final walletController = Get.find<WalletController>();
  final String title;
  WithdrawalSuccessScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NavigationController>();
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: darkMode ? Colors.black : Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: THelperFunctions.screenHeight() * 0.13,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: AssetImage(TImages.withdrawSuccess)),
              const SizedBox(height: TSizes.defaultSpace,),
              SizedBox(
                width: 310,
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: <TextSpan> [
                          TextSpan(
                            text: title,
                            style: TextStyle(
                                color: TColors.primary,
                              fontWeight: FontWeight.w500
                            ),
                          )
                        ]
                    )
                ),
              ),
              const SizedBox(height: TSizes.defaultSpace * 3),
              GestureDetector(
                onTap: () async {
                  await walletController.fetchWallets(currency: '');
                  controller.selectedIndex.value = 3;
                  Get.offAll(() => NavigationMenu());
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 208,
                  height: 40,
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
                    'Return to wallet',
                    style: TextStyle(
                        color: TColors.primary,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        fontFamily: TTexts.fontFamily
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  await walletController.fetchWallets(currency: '');
                  controller.selectedIndex.value = 0;
                  Get.offAll(() => NavigationMenu());
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 208,
                  height: 40,
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
