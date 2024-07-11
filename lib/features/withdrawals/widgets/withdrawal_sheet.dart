import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pouch/common/widgets/buttons/elevated_button.dart';
import 'package:pouch/data/provider/transaction_provider.dart';
import 'package:pouch/features/wallet/apis/api.dart';
import 'package:pouch/features/withdrawals/apis/api.dart';
import 'package:pouch/features/withdrawals/screens/withdrawal_success.dart';
import 'package:pouch/utils/constants/sizes.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';

import '../../../data/provider/wallet_provider.dart';

class WithdrawalConfirmSheet extends StatelessWidget {
  final String amount;
  const WithdrawalConfirmSheet({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    final provider = Provider.of<WalletProvider>(context);
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final item = provider.selectedWithdrawalAccount;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.defaultSpace * 1.5),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: TSizes.defaultSpace * 1.5, right: TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: darkMode ? Colors.black : Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  fontFamily: 'Roboto'
                              ),
                              children: const <TextSpan> [
                                TextSpan(
                                  text: 'Confirm Details',
                                )
                              ]
                          )
                      ),
                      IconButton(
                          onPressed: () {Get.back();},
                          icon: Icon(Icons.cancel, color: Colors.white, size: 30,)
                      )
                    ],
                  ),
                  SizedBox(height: TSizes.defaultSpace,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: darkMode ? Colors.black : Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  fontFamily: 'Roboto'
                              ),
                              children: const <TextSpan> [
                                TextSpan(
                                  text: 'Withdraw',
                                )
                              ]
                          )
                      ),
                      SizedBox(
                        width: 120,
                        child: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    color: darkMode ? Colors.black : Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    fontFamily: 'Roboto'
                                ),
                                children: const <TextSpan> [
                                  TextSpan(
                                    text: 'From',
                                  )
                                ]
                            )
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: TSizes.md,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: darkMode ? Colors.black : Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  fontFamily: 'Roboto'
                              ),
                              children: <TextSpan> [
                                TextSpan(
                                  text: THelperFunctions.moneyFormatter(amount),
                                )
                              ]
                          )
                      ),
                      SizedBox(
                        width: 120,
                        child: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    color: darkMode ? Colors.black : Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    fontFamily: 'Roboto'
                                ),
                                children: <TextSpan> [
                                  TextSpan(
                                    text: '${provider.defaultWallet!.currency}',
                                  ),
                                  TextSpan(
                                    text: ' Wallet',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400
                                    )
                                  )
                                ]
                            )
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: TSizes.xl,),
                  RichText(
                      text: TextSpan(
                          style: TextStyle(
                              color: darkMode ? Colors.black : Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              fontFamily: 'Roboto'
                          ),
                          children: const <TextSpan> [
                            TextSpan(
                              text: 'To',
                            )
                          ]
                      )
                  ),
                  SizedBox(height: TSizes.xl,),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace * 0.5),
              padding: EdgeInsets.all(TSizes.defaultSpace),
              decoration: BoxDecoration(
                color: Color(0xFFE6E1E1).withOpacity(0.38),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black.withOpacity(0.09))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(
                          style: TextStyle(
                              color: darkMode ? Colors.black : Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              fontFamily: 'Roboto'
                          ),
                          children: <TextSpan> [
                            TextSpan(
                              text: item?.accountName,
                            )
                          ]
                      )
                  ),
                  SizedBox(
                    height: TSizes.defaultSpace,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: darkMode ? Colors.black : Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  fontFamily: 'Roboto'
                              ),
                              children: <TextSpan> [
                                TextSpan(
                                  text: item?.bankName,
                                )
                              ]
                          )
                      ),
                      RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: darkMode ? Colors.black : Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  fontFamily: 'Roboto'
                              ),
                              children: <TextSpan> [
                                TextSpan(
                                  text: item?.accountNumber,
                                )
                              ]
                          )
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: TSizes.defaultSpace,),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(right: TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 120,
                    child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: darkMode ? Colors.black : Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: 'Roboto'
                            ),
                            children: const <TextSpan> [
                              TextSpan(
                                text: 'Transaction fee',
                              )
                            ]
                        )
                    ),
                  ),
                  SizedBox(height: TSizes.sm,),
                  SizedBox(
                    width: 120,
                    child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: darkMode ? Colors.black : Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: 'Roboto'
                            ),
                            children: const <TextSpan> [
                              TextSpan(
                                text: 'N10.00',
                              )
                            ]
                        )
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: TSizes.defaultSpace,),
            Container(
              padding: EdgeInsets.all(TSizes.defaultSpace * 0.5),
                child: TElevatedButton(
                    onTap: (){
                      WalletServices.instance.transferLocalBank(
                          amount: int.parse(amount),
                          currency: provider.selectedWithdrawalAccount!.currency,
                          bankId: provider.selectedWithdrawalAccount!.id,
                          transactionProvider: transactionProvider,
                          walletProvider: provider,
                      );
                    },
                    buttonText: 'Confirm'
                )
            )
          ],
        ),
      ),
    );
  }
}

