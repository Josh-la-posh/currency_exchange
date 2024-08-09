import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pouch/data/provider/transaction_provider.dart';
import 'package:pouch/utils/constants/enums.dart';
import 'package:pouch/utils/constants/texts.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import '../../../data/provider/wallet_provider.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../apis/api.dart';

class WalletList extends StatelessWidget {
  const WalletList({
    super.key,
    required this.darkMode,
  });
  final bool darkMode;

  @override
  Widget build(BuildContext context) {
    var walletProvider = Provider.of<WalletProvider>(context);
    var transactionProvider = Provider.of<TransactionProvider>(context);
    final darkMode = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // GestureDetector(
        //   onTap: () {
        //     walletProvider.setShowWalletList();
        //   },
        //   child: Container(
        //     width: double.infinity,
        //     height: 62,
        //     margin: const EdgeInsets.only(bottom: 5),
        //     padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 40),
        //     decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(12),
        //         border: Border.all(color: Colors.black),
        //         color: darkMode ? Colors.black : Color(0xFFE6E5E5).withOpacity(0.13)
        //     ),
        //     child:
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Text(
        //           'Add Wallet',
        //           style: TextStyle(
        //               fontSize: 16,
        //               fontWeight: FontWeight.w500,
        //               fontFamily: 'Roboto',
        //               color: TColors.black
        //           ),
        //         ),
        //         SizedBox(width: 5,),
        //         SizedBox(
        //             width: 5,
        //             child: Icon(
        //               walletProvider.showWalletLists == true
        //                   ? Icons.arrow_drop_up
        //                   : Icons.arrow_drop_down,
        //               size: 25,
        //               color: TColors.black,)
        //         )
        //       ],
        //     ),
        //   ),
        // ),
        walletProvider.showWalletLists == true
        ? Container(
          margin: EdgeInsets.only(
              bottom: walletProvider.showWalletLists == true ? 7 : 0,
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: walletProvider.walletCurrencies.map((currency) {
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    child: GestureDetector(
                      onTap: (){
                        walletProvider.setSelectedWalletCurrency(currency);
                        walletProvider.setShowWalletList();
                        WalletServices.instance.createWallet(
                            transactionProvider: transactionProvider,
                            walletProvider: walletProvider,
                            currency: getWalletCurrencyName(walletProvider.selectedWalletCurrency)
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
                            if (currency == walletProvider.selectedWalletCurrency)
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
        ) : SizedBox(),
      ],
    );
  }
}


