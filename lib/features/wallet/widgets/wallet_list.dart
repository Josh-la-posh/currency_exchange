import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/wallet/controller/wallet_controller.dart';
import 'package:pouch/utils/constants/enums.dart';
import 'package:pouch/utils/constants/texts.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import '../../../utils/constants/sizes.dart';

class WalletList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  final WalletController walletController = Get.find();
    final darkMode = THelperFunctions.isDarkMode(context);
    return Obx(() {
      if (walletController.showWalletLists.value) {
        return Container(
            margin: EdgeInsets.only(
              bottom: walletController.showWalletLists == true ? 7 : 0,
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: walletController.walletCurrencies.map((currency) {
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      child: GestureDetector(
                        onTap: (){
                          walletController.updateSelectedCurrency(currency);
                          walletController.creatingWallet(
                              currency: getWalletCurrencyName(walletController.selectedWalletCurrency.value),
                              onSuccess: () {
                                walletController.updateShowWalletList();
                              }
                          );
                        },
                        child: Container(
                          height: 48,
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          decoration: BoxDecoration(
                            color: darkMode ? Color(0xFF3E3E3E) : Color(0xFFF6F6F6),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              RichText(
                                  text: TextSpan(
                                      style: Theme.of(context).textTheme.bodySmall,
                                      children: <TextSpan> [
                                        TextSpan(
                                            text: getWalletCurrencyName(currency),
                                            style:  TextStyle(
                                                fontSize: 10,
                                                fontFamily: TTexts.fontFamily,
                                                fontWeight: TSizes.fontWeightNm,
                                                color: darkMode ? Colors.white : Colors.black
                                            )
                                        ),
                                      ]
                                  )
                              ),
                              const Spacer(),
                              if (currency == walletController.selectedWalletCurrency.value)
                                SizedBox(
                                    width: 20,
                                    child: const Image(image: AssetImage('assets/icons/wallet_check.png'))
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            )
        );
      } else {
        return SizedBox();
      }
    });
  }
}


