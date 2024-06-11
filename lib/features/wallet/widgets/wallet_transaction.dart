import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swappr/features/transaction/screens/history.dart';
import 'package:swappr/features/wallet/widgets/transaction_list.dart';
import '../../../utils/constants/sizes.dart';

class WalletTransactionHistory extends StatelessWidget {
  const WalletTransactionHistory({
    super.key,
    required this.darkMode,
  });

  final bool darkMode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                  text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: <TextSpan> [
                        TextSpan(
                            text:'Transaction history',
                            style:  TextStyle(
                                fontWeight: TSizes.fontWeightMd,
                                color: darkMode ? Colors.white : Colors.black
                            )
                        ),
                      ]
                  )
              ),
              GestureDetector(
                onTap: (){
                  Get.to(() => const TransactionHistoryScreen());
                },
                child: Row(
                  children: [
                    RichText(
                        text: TextSpan(
                            style: Theme.of(context).textTheme.bodySmall,
                            children: <TextSpan> [
                              TextSpan(
                                  text:'View more',
                                  style:  TextStyle(
                                      fontWeight: TSizes.fontWeightMd,
                                      color: darkMode ? Colors.white : Colors.black
                                  )
                              ),
                            ]
                        )
                    ),
                    SizedBox(
                      // width: 5,
                        child: Icon(
                          Icons.keyboard_arrow_right_rounded,
                          color: darkMode ? Colors.white : Colors.black,
                          size: 20,
                        )
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 25,),
          WalletTransactionList(darkMode: darkMode),
        ],
      ),
    );
  }
}