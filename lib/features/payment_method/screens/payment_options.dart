import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swappr/features/payment_method/screens/bank_transfer.dart';
import 'package:swappr/features/payment_method/screens/flutterwave_payment.dart';
import 'package:swappr/features/payment_method/screens/paystack_payment.dart';
import 'package:swappr/utils/constants/image_strings.dart';
import 'package:swappr/utils/constants/sizes.dart';

class PaymentOptionScreen extends StatelessWidget {
  const PaymentOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
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
              SizedBox(height: TSizes.defaultSpace,),
              Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace * 2, vertical: 20),
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          // height: 30,
                          child: Image(image: AssetImage(TImages.bankTransfer)),
                        ),
                        SizedBox(width: 15,),
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
                            child: Icon(Icons.keyboard_arrow_down_outlined)
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace * 2),
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {
                            Get.to(() => const FlutterwavePeymentScreen());
                          },
                          contentPadding: EdgeInsets.only(left: 25),
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                // height: 30,
                                child: Image(image: AssetImage(TImages.flutterwave)),
                              ),
                              SizedBox(width: 15,),
                              RichText(
                                  text: TextSpan(
                                      style: Theme.of(context).textTheme.labelSmall,
                                      children: const <TextSpan> [
                                        TextSpan(
                                            text: 'Flutterwave',
                                            style: TextStyle(fontSize: 8.63)
                                        )
                                      ]
                                  )
                              ),
                              Spacer(),
                              SizedBox(
                                  child: Image(image: AssetImage('assets/icons/wallet_check.png'))
                              )
                            ],
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 25),
                          onTap: () {
                            Get.to(() => const PaystackPaymentScreen());
                          },
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                // height: 30,
                                child: Image(image: AssetImage(TImages.paystack)),
                              ),
                              SizedBox(width: 15,),
                              RichText(
                                  text: TextSpan(
                                      style: Theme.of(context).textTheme.labelSmall,
                                      children: const <TextSpan> [
                                        TextSpan(
                                            text: 'Paystack',
                                            style: TextStyle(fontSize: 8.63)
                                        )
                                      ]
                                  )
                              ),
                              Spacer(),
                              SizedBox(
                                  child: Image(image: AssetImage('assets/icons/wallet_check.png'))
                              )
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
                color: Colors.black.withOpacity(0.08),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace * 2, vertical: 20),
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      // height: 30,
                      child: Image(image: AssetImage(TImages.ussd)),
                    ),
                    SizedBox(width: 15,),
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
                color: Colors.black.withOpacity(0.08),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace * 2, vertical: 20),
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      // height: 30,
                      child: Image(image: AssetImage(TImages.internetBanking)),
                    ),
                    SizedBox(width: 15,),
                    RichText(
                        text: TextSpan(
                            style: Theme.of(context).textTheme.labelSmall,
                            children: const <TextSpan> [
                              TextSpan(
                                  text: 'Internet Banking',
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
                color: Colors.black.withOpacity(0.08),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace * 2, vertical: 20),
                onTap: () {
                  Get.to(() => BankTransferScreen());
                },
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      // height: 30,
                      child: Image(image: AssetImage(TImages.bankAccount)),
                    ),
                    SizedBox(width: 15,),
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
                color: Colors.black.withOpacity(0.08),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
