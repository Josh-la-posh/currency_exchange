import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swappr/data/provider/auth_provider.dart';
import 'package:swappr/data/provider/wallet_provider.dart';
import 'package:swappr/features/wallet/routes/names.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';

import '../../../data/modules/app_navigator.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';

class FlutterwavePeymentScreen extends StatelessWidget {
  const FlutterwavePeymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(
        AppNavigator.instance.navigatorKey.currentContext as BuildContext);
    var walletProvider = Provider.of<WalletProvider>(
        AppNavigator.instance.navigatorKey.currentContext as BuildContext);

    final darkMode = THelperFunctions.isDarkMode(context);

    final item = walletProvider.flutterwaveModel;
    
    print('items ${item?.transfer_amount}}');
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: TSizes.defaultSpace, horizontal: TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Image(image: AssetImage(TImages.flutterwaveIcon)),
                  const SizedBox(height: 20,),
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
                  const SizedBox(height: TSizes.md,),
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
                              text: 'Pay NGN ${item?.transfer_amount.toString()}',
                            ),
                          ]
                      )
                  ),
                ],
              ),
            ),
            SizedBox(height: THelperFunctions.screenHeight() * 0.07),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace * 1.3),
              child: RichText(
                  text: TextSpan(
                      style: TextStyle(
                          color: darkMode ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          fontFamily: 'Roboto'
                      ),
                      children: <TextSpan> [
                        TextSpan(
                          text: 'Please make a transfer to ',
                        ),
                        TextSpan(
                          text: ' ${item?.transfer_bank}',
                          style: TextStyle(
                            fontWeight: FontWeight.w700
                          )
                        )
                      ]
                  )
              ),
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.black.withOpacity(0.14),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace * 1.3, vertical: TSizes.defaultSpace * 1.3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                              text: 'Amount',
                            )
                          ]
                      )
                  ),
                  SizedBox(
                    width: 120,
                    child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: darkMode ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                fontFamily: 'Roboto'
                            ),
                            children: <TextSpan> [
                              TextSpan(
                                text: 'NGN ${item?.transfer_amount}',
                              )
                            ]
                        )
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.black.withOpacity(0.14),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace * 1.3, vertical: TSizes.defaultSpace * 1.3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                              text: 'Account Number',
                            )
                          ]
                      )
                  ),
                  SizedBox(
                    width: 120,
                    child: Row(
                      children: [
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
                                    text: '${item?.transfer_account}',
                                  )
                                ]
                            )
                        ),
                        SizedBox(width: 10,),
                        SizedBox(
                            width: 18,
                            child: Image(image: AssetImage(TImages.transferFile))
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.black.withOpacity(0.14),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace * 1.3, vertical: TSizes.defaultSpace * 1.3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                              text: 'Bank Name',
                            )
                          ]
                      )
                  ),
                  SizedBox(
                    width: 120,
                    child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: darkMode ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                fontFamily: 'Roboto'
                            ),
                            children: <TextSpan> [
                              TextSpan(
                                text: '${item?.transfer_bank}',
                              )
                            ]
                        )
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.black.withOpacity(0.14),
            ),
            SizedBox(height: TSizes.xl,),
            RichText(
              textAlign: TextAlign.center,
                text: TextSpan(
                    style: TextStyle(
                        color: darkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        fontFamily: 'Roboto'
                    ),
                    children: <TextSpan> [
                      TextSpan(
                        text: 'The Account Expire in ${THelperFunctions.millisecondConversion(item!.account_expiration.toString())}',
                      )
                    ]
                )
            ),
            SizedBox(height: TSizes.defaultSpace * 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
              child: GestureDetector(
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
                            color: Colors.white.withOpacity(0.84),
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
                              text: 'I\'ve sent the money',
                            ),
                          ]
                      )
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
