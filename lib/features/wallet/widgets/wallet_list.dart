import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swappr/utils/constants/enums.dart';
import 'package:swappr/utils/constants/texts.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            print(walletProvider.walletCurrencies.last);
            walletProvider.setShowWalletList();
          },
          child: Container(
            width: 120,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFFD4C6E8)
            ),
            child:
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Add Wallet',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Roboto',
                      color: TColors.black
                  ),
                ),
                SizedBox(width: 5,),
                SizedBox(
                    width: 5,
                    child: Icon(Icons.keyboard_arrow_right_rounded, size: 20, color: TColors.black,)
                )
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: walletProvider.showWalletLists == true ? 30 : 0, bottom: 25),
          child: walletProvider.showWalletLists == true
              ? ListView(
            shrinkWrap: true,
            children: walletProvider.walletCurrencies.map((currency) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      walletProvider.setSelectedWalletCurrency(currency);
                      WalletServices.instance.createWallet(
                          walletProvider: walletProvider,
                          currency: getWalletCurrencyName(walletProvider.selectedWalletCurrency)
                      );
                    },
                    child: ListTile(
                      // padding: const EdgeInsets.only(left: 70, right: 30, top: 20, bottom: 20),
                      contentPadding: EdgeInsets.only(left: 70, right: 30),
                      title: Row(
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
                  Container(
                    height: 1,
                    width: double.infinity,
                    decoration:BoxDecoration(
                      color: darkMode ? TColors.white.withOpacity(0.2) : Colors.black.withOpacity(0.05),
                    ),
                  )
                ],
              );
            }).toList(),
          )
              : Text('')
        ),
      ],
    );
  }
}


