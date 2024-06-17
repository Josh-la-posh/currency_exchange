import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swappr/features/home/routes/names.dart';
import 'package:swappr/features/transaction/apis/api.dart';
import 'package:swappr/features/wallet/apis/api.dart';
import '../../../data/modules/app_navigator.dart';
import '../../../data/provider/auth_provider.dart';
import '../../../data/provider/transaction_provider.dart';
import '../../../data/provider/wallet_provider.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../wallet/routes/names.dart';

class UssdFundingDetailScreen extends StatelessWidget {
  String? amount;
  UssdFundingDetailScreen({super.key, this.amount});

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(
        AppNavigator.instance.navigatorKey.currentContext as BuildContext);
    var walletProvider = Provider.of<WalletProvider>(
        AppNavigator.instance.navigatorKey.currentContext as BuildContext);
    var transactionProvider = Provider.of<TransactionProvider>(
        AppNavigator.instance.navigatorKey.currentContext as BuildContext);

    final darkMode = THelperFunctions.isDarkMode(context);

    final item = walletProvider.ussdModel;

    return Scaffold(
      backgroundColor: darkMode ? TColors.black : const Color(0xFFE9D9FF).withOpacity(0.12),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(  vertical: TSizes.defaultSpace * 3, horizontal: TSizes.defaultSpace * 2),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: darkMode ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  fontFamily: 'Roboto'
                              ),
                              children: <TextSpan> [
                                TextSpan(
                                  text: 'Reference No:',
                                )
                              ]
                          )
                      ),
                      const SizedBox(height: TSizes.sm,),
                      RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: darkMode ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  fontFamily: 'Roboto'
                              ),
                              children: <TextSpan> [
                                TextSpan(
                                  text: '${item?.reference}',
                                )
                              ]
                          )
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: darkMode ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  fontFamily: 'Roboto'
                              ),
                              children: <TextSpan> [
                                TextSpan(
                                  text: '${authProvider.user?.email}',
                                )
                              ]
                          )
                      ),
                      const SizedBox(height: TSizes.sm,),
                      RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: darkMode ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  fontFamily: 'Roboto'
                              ),
                              children: <TextSpan> [
                                TextSpan(
                                  text: 'Pay NGN ${amount}',
                                )
                              ]
                          )
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: THelperFunctions.screenHeight() * 0.1),
              Column(
                children: [
                  RichText(
                      text: TextSpan(
                          style: TextStyle(
                              color: darkMode ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              fontFamily: 'Roboto'
                          ),
                          children: <TextSpan> [
                            TextSpan(
                              text: 'Transfer ',
                            ),
                            TextSpan(
                                text: 'NGN ${amount} ',
                                style: TextStyle(color: Color(0xFFA17DD0))
                            ),
                            TextSpan(
                              text: ' to',
                            ),
                          ]
                      )
                  ),
                  const SizedBox(height: 20,),
                  RichText(
                      text: TextSpan(
                          style: TextStyle(
                              color: darkMode ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              fontFamily: 'Roboto'
                          ),
                          children: const <TextSpan> [
                            TextSpan(
                              text: 'Paystack Checkout',
                            ),
                          ]
                      )
                  ),
                  const SizedBox(height: TSizes.defaultSpace,),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: TColors.black.withOpacity(0.3),
                            offset: const Offset(2.3,3.87),
                            // blurRadius: 1.94,
                            // spreadRadius: 1.94
                          ),
                          BoxShadow(
                              color: const Color(0xFFA58DC4).withOpacity(0.3),
                              offset: const Offset(0.0,0.0),
                              blurRadius: 0,
                              spreadRadius: 0
                          ),
                          BoxShadow(
                              color: Colors.white.withOpacity(0.8),
                              offset: const Offset(0.0,0.0),
                              blurRadius: 0,
                              spreadRadius: 0
                          ),
                        ]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: TSizes.lg, right: TSizes.lg, top: TSizes.md, bottom: TSizes.xl),
                      child: Column(
                        children: [
                          // RichText(
                          //     text: TextSpan(
                          //         style: TextStyle(
                          //             color: darkMode ? Colors.white : Colors.black,
                          //             fontWeight: FontWeight.w500,
                          //             fontSize: 22,
                          //             fontFamily: 'Roboto'
                          //         ),
                          //         children: <TextSpan> [
                          //           TextSpan(
                          //             text: 'Please dial',
                          //           ),
                          //         ]
                          //     )
                          // ),
                          const SizedBox(height: TSizes.defaultSpace,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                          color: darkMode ? Colors.white : Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 32,
                                          fontFamily: 'Roboto'
                                      ),
                                      children: <TextSpan> [
                                        TextSpan(
                                          text: '${item?.ussd_code}',
                                        ),
                                      ]
                                  )
                              ),
                            ],
                          ),
                          const SizedBox(height: TSizes.defaultSpace  / 1.2,),
                          RichText(
                            textAlign: TextAlign.center,
                              text: TextSpan(
                                  style: TextStyle(
                                      color: darkMode ? Colors.white : Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      fontFamily: 'Roboto'
                                  ),
                                  children: <TextSpan> [
                                    TextSpan(
                                      text: '${item?.display_text}',
                                    ),
                                  ]
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: TSizes.defaultSpace * 4),
                  GestureDetector(
                    onTap: () {
                      AppNavigator.instance.removeAllNavigateToNavHandler(WALLET_SCREEN_ROUTE);
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: TColors.black.withOpacity(0.3),
                              offset: const Offset(2.3,3.87),
                              // blurRadius: 1.94,
                              // spreadRadius: 1.94
                            ),
                            BoxShadow(
                                color: const Color(0xFFA58DC4).withOpacity(0.3),
                                offset: const Offset(0.0,0.0),
                                blurRadius: 0,
                                spreadRadius: 0
                            ),
                            BoxShadow(
                                color: Colors.white.withOpacity(0.8),
                                offset: const Offset(0.0,0.0),
                                blurRadius: 0,
                                spreadRadius: 0
                            ),
                          ]
                      ),
                      child:
                      RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: darkMode ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  fontFamily: 'Roboto'
                              ),
                              children: const <TextSpan> [
                                TextSpan(
                                  text: 'Proceed to Wallet',
                                ),
                              ]
                          )
                      ),
                    ),
                  ),
                  const SizedBox(height: TSizes.defaultSpace),
                  GestureDetector(
                    onTap: () async {
                      await WalletServices.instance.getWallets(walletProvider: walletProvider, currency: '');
                      await TransactionService.instance.getTransactions(transactionProvider: transactionProvider);
                      AppNavigator.instance.removeAllNavigateToNavHandler(DASHBOARD_SCREEN_ROUTE);
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: TColors.black.withOpacity(0.3),
                              offset: const Offset(2.3,3.87),
                              // blurRadius: 1.94,
                              // spreadRadius: 1.94
                            ),
                            BoxShadow(
                                color: const Color(0xFFA58DC4).withOpacity(0.3),
                                offset: const Offset(0.0,0.0),
                                blurRadius: 0,
                                spreadRadius: 0
                            ),
                            BoxShadow(
                                color: Colors.white.withOpacity(0.8),
                                offset: const Offset(0.0,0.0),
                                blurRadius: 0,
                                spreadRadius: 0
                            ),
                          ]
                      ),
                      child:
                      RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: darkMode ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  fontFamily: 'Roboto'
                              ),
                              children: const <TextSpan> [
                                TextSpan(
                                  text: 'Proceed to Dashboard',
                                ),
                              ]
                          )
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
