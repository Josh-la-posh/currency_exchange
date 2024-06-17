import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:swappr/features/payment_method/screens/bank_transfer.dart';
import 'package:swappr/features/payment_method/screens/flutterwave_payment.dart';
import 'package:swappr/features/payment_method/screens/paystack_payment.dart';
import 'package:swappr/features/payment_method/screens/ussd_funding.dart';
import 'package:swappr/utils/constants/image_strings.dart';
import 'package:swappr/utils/constants/sizes.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';

import '../../../common/widgets/buttons/elevated_button.dart';
import '../../../data/modules/app_navigator.dart';
import '../../../data/provider/wallet_provider.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/validators/validation.dart';
import '../../wallet/apis/api.dart';

class PaymentOptionScreen extends StatefulWidget {
  const PaymentOptionScreen({super.key});

  @override
  State<PaymentOptionScreen> createState() => _PaymentOptionScreenState();
}

class _PaymentOptionScreenState extends State<PaymentOptionScreen> {

  var walletProvider = Provider.of<WalletProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext);

  @override
  void initState() {
    if (walletProvider.bankList.isEmpty) {
      WalletServices.instance.getBankList(
          walletProvider: walletProvider);
    }
    super.initState();
  }

  String _amount = '';

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    var walletProvider = Provider.of<WalletProvider>(
        AppNavigator.instance.navigatorKey.currentContext as BuildContext);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                child: RichText(
                    text: TextSpan(
                        style: Theme.of(context).textTheme.titleLarge,
                        children: const <TextSpan> [
                          TextSpan(
                              text: 'Funding method',
                              style: TextStyle(fontSize: TSizes.fontSize20)
                          )
                        ]
                    )
                ),
              ),
              const SizedBox(height: TSizes.defaultSpace,),
              Column(
                children: [
                  ListTile(
                    onTap: () {
                      setState(() {
                        walletProvider.setShowBankTransferOption(!walletProvider.showBankTransferOption);
                      });
                    },
                    contentPadding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace * 2, vertical: 10),
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: darkMode ? TColors.white.withOpacity(0.3) : Colors.transparent
                          ),
                          child: Image(image: AssetImage(TImages.bankTransfer)),
                        ),
                        const SizedBox(width: 15,),
                        RichText(
                            text: TextSpan(
                                style: Theme.of(context).textTheme.labelSmall,
                                children: const <TextSpan> [
                                  TextSpan(
                                      text: 'Bank transfer',
                                      style: TextStyle(fontWeight: TSizes.fontWeightLg)
                                  )
                                ]
                            )
                        ),
                        SizedBox(
                            child: walletProvider.showBankTransferOption == true
                                ? const Icon(Icons.keyboard_arrow_up_outlined)
                                : const Icon(Icons.keyboard_arrow_down_outlined)
                        )
                      ],
                    ),
                  ),
                  if (walletProvider.showBankTransferOption == true)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace * 2),
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    content: Container(
                                    height: 240,
                                      width: 200,
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        children: [
                                          RichText(
                                              textAlign: TextAlign.center,
                                              text: TextSpan(
                                                  style: Theme.of(context).textTheme.titleLarge,
                                                  children:  const <TextSpan> [
                                                    TextSpan(
                                                        text: 'Enter Amount',
                                                        style: TextStyle(fontSize: 16)
                                                    )
                                                  ]
                                              )
                                          ),
                                          const SizedBox(height: TSizes.defaultSpace * 1.4,),
                                          TextFormField(
                                            textAlign: TextAlign.center,
                                            validator: TValidator.numValidator,
                                            style: Theme.of(context).textTheme.titleLarge,
                                            onChanged: (val) => _amount = val,
                                            onSaved: (val) {
                                              setState(() {
                                                _amount = val as String;
                                              });
                                            },
                                          ),
                                          const SizedBox(height: TSizes.sm,),
                                          Visibility(
                                            visible: walletProvider.showErrorText,
                                            child: RichText(
                                                textAlign: TextAlign.center,
                                                text: TextSpan(
                                                  style: Theme.of(context).textTheme.labelSmall,
                                                    children:  const <TextSpan> [
                                                      TextSpan(
                                                        text: 'Please, enter an amount',
                                                        style: TextStyle(fontSize: 10, color: TColors.danger)
                                                    )
                                                  ]
                                              )
                                          ),
                                          ),
                                          const SizedBox(height: TSizes.defaultSpace * 1.4,),
                                          SizedBox(
                                            height: 40,
                                            width: 140,
                                            child: TElevatedButton(
                                              onTap: () {
                                                if (_amount == '') {
                                                  walletProvider.showErrorMessage();
                                                } else {
                                                  WalletServices.instance.fundWalletNairaTransfer(
                                                    amount: int.parse(_amount),
                                                    walletProvider: walletProvider
                                                  );
                                                }
                                              },
                                              buttonText: 'Continue',
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }
                            );
                            // showModalBottomSheet(
                            //     backgroundColor: TColors.white,
                            //     context: context,
                            //     builder: (cdx) => Container(
                            //       width: double.infinity,
                            //       padding: EdgeInsets.all(TSizes.defaultSpace),
                            //       child: Column(
                            //         children: [
                            //           RichText(
                            //               textAlign: TextAlign.center,
                            //               text: TextSpan(
                            //                   style: Theme.of(context).textTheme.titleLarge,
                            //                   children:  <TextSpan> [
                            //                     const TextSpan(
                            //                         text: 'Enter Amount',
                            //                         style: TextStyle(fontSize: 16)
                            //                     )
                            //                   ]
                            //               )
                            //           ),
                            //           const SizedBox(height: TSizes.defaultSpace,),
                            //           SizedBox(
                            //             width: 200,
                            //             child: TextFormField(
                            //               textAlign: TextAlign.center,
                            //               validator: TValidator.numValidator,
                            //               style: Theme.of(context).textTheme.bodyMedium,
                            //               onChanged: (val) => _amount = val,
                            //               onSaved: (val) {
                            //                 setState(() {
                            //                   _amount = val as String;
                            //                 });
                            //               },
                            //
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     )
                            // );


                          },
                          contentPadding: const EdgeInsets.only(left: 25),
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                // height: 30,
                                child: Image(image: AssetImage(TImages.flutterwave)),
                              ),
                              const SizedBox(width: 15,),
                              RichText(
                                  text: TextSpan(
                                      style: Theme.of(context).textTheme.labelSmall,
                                      children: const <TextSpan> [
                                        TextSpan(
                                            text: 'Flutterwave',
                                            style: TextStyle(fontSize: 11)
                                        )
                                      ]
                                  )
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    content: Container(
                                      height: 240,
                                      width: 200,
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        children: [
                                          RichText(
                                              textAlign: TextAlign.center,
                                              text: TextSpan(
                                                  style: Theme.of(context).textTheme.titleLarge,
                                                  children:  const <TextSpan> [
                                                    TextSpan(
                                                        text: 'Enter Amount',
                                                        style: TextStyle(fontSize: 16)
                                                    )
                                                  ]
                                              )
                                          ),
                                          const SizedBox(height: TSizes.defaultSpace * 1.4,),
                                          TextFormField(
                                            textAlign: TextAlign.center,
                                            validator: TValidator.numValidator,
                                            style: Theme.of(context).textTheme.titleLarge,
                                            onChanged: (val) => _amount = val,
                                            onSaved: (val) {
                                              setState(() {
                                                _amount = val as String;
                                              });
                                            },
                                          ),
                                          const SizedBox(height: TSizes.sm,),
                                          Visibility(
                                            visible: walletProvider.showErrorText,
                                            child: RichText(
                                                textAlign: TextAlign.center,
                                                text: TextSpan(
                                                    style: Theme.of(context).textTheme.labelSmall,
                                                    children:  const <TextSpan> [
                                                      TextSpan(
                                                          text: 'Please, enter an amount',
                                                          style: TextStyle(fontSize: 10, color: TColors.danger)
                                                      )
                                                    ]
                                                )
                                            ),
                                          ),
                                          const SizedBox(height: TSizes.defaultSpace * 1.4,),
                                          SizedBox(
                                            height: 40,
                                            width: 140,
                                            child: TElevatedButton(
                                              onTap: () {
                                                if (_amount == '') {
                                                  walletProvider.showErrorMessage();
                                                } else {
                                                  WalletServices.instance.fundWalletNairaPaystack(
                                                      amount: int.parse(_amount),
                                                      walletProvider: walletProvider
                                                  );
                                                }
                                              },
                                              buttonText: 'Continue',
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }
                            );
                            // showModalBottomSheet(
                            //     backgroundColor: TColors.white,
                            //     context: context,
                            //     builder: (cdx) => Container(
                            //       width: double.infinity,
                            //       padding: EdgeInsets.all(TSizes.defaultSpace),
                            //       child: Column(
                            //         children: [
                            //           RichText(
                            //               textAlign: TextAlign.center,
                            //               text: TextSpan(
                            //                   style: Theme.of(context).textTheme.titleLarge,
                            //                   children:  <TextSpan> [
                            //                     const TextSpan(
                            //                         text: 'Enter Amount',
                            //                         style: TextStyle(fontSize: 16)
                            //                     )
                            //                   ]
                            //               )
                            //           ),
                            //           const SizedBox(height: TSizes.defaultSpace,),
                            //           SizedBox(
                            //             width: 200,
                            //             child: TextFormField(
                            //               textAlign: TextAlign.center,
                            //               validator: TValidator.numValidator,
                            //               style: Theme.of(context).textTheme.bodyMedium,
                            //               onChanged: (val) => _amount = val,
                            //               onSaved: (val) {
                            //                 setState(() {
                            //                   _amount = val as String;
                            //                 });
                            //               },
                            //
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     )
                            // );


                          },
                          contentPadding: const EdgeInsets.only(left: 25),
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                // height: 30,
                                child: Image(image: AssetImage(TImages.paystack)),
                              ),
                              const SizedBox(width: 15,),
                              RichText(
                                  text: TextSpan(
                                      style: Theme.of(context).textTheme.labelSmall,
                                      children: const <TextSpan> [
                                        TextSpan(
                                            text: 'Paystack',
                                            style: TextStyle(fontSize: 11)
                                        )
                                      ]
                                  )
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: darkMode ? TColors.white.withOpacity(0.3) : Colors.black.withOpacity(0.08),
              ),
              ListTile(
                onTap: () {
                  Get.to(() => const UssdFundingScreen());
                },
                contentPadding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace * 2, vertical: 20),
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: darkMode ? TColors.white.withOpacity(0.3) : Colors.transparent
                      ),
                      child: Image(image: AssetImage(TImages.ussd)),
                    ),
                    const SizedBox(width: 15,),
                    RichText(
                        text: TextSpan(
                            style: Theme.of(context).textTheme.labelSmall,
                            children: const <TextSpan> [
                              TextSpan(
                                  text: 'USSD',
                                  style: TextStyle(fontWeight: TSizes.fontWeightLg)
                              )
                            ]
                        )
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: darkMode ? TColors.white.withOpacity(0.3) : Colors.black.withOpacity(0.08),
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace * 2, vertical: 20),
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: darkMode ? TColors.white.withOpacity(0.3) : Colors.transparent
                      ),
                      child: Image(image: AssetImage(TImages.internetBanking)),
                    ),
                    const SizedBox(width: 15,),
                    RichText(
                        text: TextSpan(
                            style: Theme.of(context).textTheme.labelSmall,
                            children: const <TextSpan> [
                              TextSpan(
                                  text: 'Direct Deposit',
                                  style: TextStyle(fontWeight: TSizes.fontWeightLg)
                              )
                            ]
                        )
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: darkMode ? TColors.white.withOpacity(0.3) : Colors.black.withOpacity(0.08),
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace * 2, vertical: 20),
                onTap: () {
                  Get.to(() => const BankTransferScreen());
                },
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: darkMode ? TColors.white.withOpacity(0.3) : Colors.transparent
                      ),
                      child: Image(image: AssetImage(TImages.bankAccount)),
                    ),
                    const SizedBox(width: 15,),
                    RichText(
                        text: TextSpan(
                            style: Theme.of(context).textTheme.labelSmall,
                            children: const <TextSpan> [
                              TextSpan(
                                  text: 'Bank Account',
                                  style: TextStyle(fontWeight: TSizes.fontWeightLg)
                              )
                            ]
                        )
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: darkMode ? TColors.white.withOpacity(0.3) : Colors.black.withOpacity(0.08),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
