import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/layouts/navigation_menu.dart';
import '../../wallet/controller/wallet_controller.dart';

class FlutterwavePaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WalletController walletController = Get.find();
    NavigationController controller = Get.find();
    final darkMode = THelperFunctions.isDarkMode(context);
    final item = walletController.flutterwaveDetails.value;
    print('The result is: ${item.account_expiration}');
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(bottom: 100),
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
                              text: '${walletController.authController.user.value.email}',
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
                              text: 'Pay NGN ${item.transfer_amount.toString()}',
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
                          text: ' ${item.transfer_bank}',
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
                                text: 'NGN ${item.transfer_amount}',
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
              padding: const EdgeInsets.only(left: TSizes.defaultSpace * 1.3, top: TSizes.defaultSpace * 1.3, bottom: TSizes.defaultSpace * 1.3),
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
                              text: 'Account No',
                            )
                          ]
                      )
                  ),
                  SizedBox(
                    // width: 150,
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
                                    text: '${item.transfer_account}',
                                  )
                                ]
                            )
                        ),
                        SizedBox(width: 10,),
                        IconButton(
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: item.transfer_account.toString()));
                              Get.snackbar('Success', 'Text copied to clipboard');
                            },
                            icon: Image(image: AssetImage(TImages.transferFile))
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
                                text: '${item.transfer_bank}',
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
                              text: 'Expires at',
                            )
                          ]
                      )
                  ),
                  SizedBox(
                    // width: 120,
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
                                text: '${THelperFunctions.getFormattedDate(THelperFunctions.milliSecondToDate(item.account_expiration.toString()).toString())} ${THelperFunctions.getFormattedTime(THelperFunctions.milliSecondToDate(item.account_expiration.toString()).toString())}',
                              )
                            ]
                        )
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: TSizes.defaultSpace * 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
              child: GestureDetector(
                onTap: () async {
                  // controller.selectedIndex.value = 3;
                  controller.navigateToIndex(3);
                  Get.to(() => NavigationMenu());
                  // Get.offAll(() => NavigationMenu());
                  await walletController.fetchWallets(currency: '');
                  // AppNavigator.instance.removeAllNavigateToNavHandler(DASHBOARD_SCREEN_ROUTE);
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: darkMode ? TColors.primary : Colors.transparent,
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
                      ],
                  ),
                  child:
                  RichText(
                      text: TextSpan(
                          style: TextStyle(
                              color: darkMode ? TColors.white : Colors.black,
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
            ),
          ],
        ),
      ),
    );
  }
}
