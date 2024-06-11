import 'package:flutter/material.dart';
import 'package:swappr/utils/constants/image_strings.dart';
import 'package:swappr/utils/constants/sizes.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';
import '../../../utils/constants/colors.dart';

class PaystackPaymentScreen extends StatelessWidget {
  const PaystackPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: darkMode ? TColors.black : const Color(0xFFE9D9FF).withOpacity(0.12),
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(  vertical: TSizes.defaultSpace, horizontal: TSizes.defaultSpace),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Image(image: AssetImage(TImages.PaystackIcon)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RichText(
                          text: TextSpan(
                              style: TextStyle(
                                color: darkMode ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: 'Roboto'
                              ),
                              children: const <TextSpan> [
                                TextSpan(
                                    text: 'Joshua@yahoo.com',
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
                              children: const <TextSpan> [
                                TextSpan(
                                  text: 'Pay NGN 125,250',
                                )
                              ]
                          )
                      ),
                    ],
                  )
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
                          children: const <TextSpan> [
                            TextSpan(
                              text: 'Transfer ',
                            ),
                            TextSpan(
                              text: ' NGN 125,250 ',
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
                          RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      color: darkMode ? Colors.white : Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 22,
                                      fontFamily: 'Roboto'
                                  ),
                                  children: const <TextSpan> [
                                    TextSpan(
                                      text: 'Access Bank',
                                    ),
                                  ]
                              )
                          ),
                          const SizedBox(height: TSizes.defaultSpace,),
                          Row(
                            children: [
                              RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                          color: darkMode ? Colors.white : Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 32,
                                          fontFamily: 'Roboto'
                                      ),
                                      children: const <TextSpan> [
                                        TextSpan(
                                          text: '32455779929',
                                        ),
                                      ]
                                  )
                              ),
                              const SizedBox(width: TSizes.lg),
                              const Image(image: AssetImage(TImages.transferFile))
                            ],
                          ),
                          const SizedBox(height: TSizes.md,),
                          RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      color: darkMode ? Colors.white : Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      fontFamily: 'Roboto'
                                  ),
                                  children: const <TextSpan> [
                                    TextSpan(
                                      text: 'Use this account for this transaction only',
                                    ),
                                  ]
                              )
                          ),
                          const SizedBox(height: TSizes.defaultSpace  / 1.2,),
                          RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      color: darkMode ? Colors.white : Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      fontFamily: 'Roboto'
                                  ),
                                  children: const <TextSpan> [
                                    TextSpan(
                                      text: 'Expire in 30 minutes',
                                    ),
                                  ]
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: TSizes.defaultSpace * 2),
                  Container(
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
                                text: 'I\'ve sent the money',
                              ),
                            ]
                        )
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
