import 'package:flutter/material.dart';
import 'package:swappr/utils/constants/image_strings.dart';
import 'package:swappr/utils/constants/sizes.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';

class BankTransferScreen extends StatelessWidget {
  const BankTransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image(image: AssetImage(TImages.bankTransferLogo))),
              SizedBox(height: TSizes.defaultSpace * 1.4,),
              RichText(
                  text: TextSpan(
                      style: TextStyle(
                          color: darkMode ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          fontFamily: 'Roboto'
                      ),
                      children: const <TextSpan> [
                        TextSpan(
                          text: 'Account Details',
                        )
                      ]
                  )
              ),
              SizedBox(height: TSizes.defaultSpace,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Color(0xFFFDF6FF).withOpacity(0.9),
                    width: 4
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      color: darkMode ? Colors.white : Colors.black,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 12,
                                      fontFamily: 'Roboto'
                                  ),
                                  children: const <TextSpan> [
                                    TextSpan(
                                      text: 'Account Name',
                                    )
                                  ]
                              )
                          ),
                          SizedBox(height: TSizes.sm,),
                          RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      color: darkMode ? Colors.white : Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      fontFamily: 'Roboto'
                                  ),
                                  children: const <TextSpan> [
                                    TextSpan(
                                      text: 'Johnson Moore Ken',
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
                      color: Colors.black.withOpacity(0.14),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      color: darkMode ? Colors.white : Colors.black,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 12,
                                      fontFamily: 'Roboto'
                                  ),
                                  children: const <TextSpan> [
                                    TextSpan(
                                      text: 'Account Number',
                                    )
                                  ]
                              )
                          ),
                          SizedBox(height: TSizes.sm,),
                          RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      color: darkMode ? Colors.white : Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      fontFamily: 'Roboto'
                                  ),
                                  children: const <TextSpan> [
                                    TextSpan(
                                      text: '2378903671',
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
                      color: Colors.black.withOpacity(0.14),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      color: darkMode ? Colors.white : Colors.black,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 12,
                                      fontFamily: 'Roboto'
                                  ),
                                  children: const <TextSpan> [
                                    TextSpan(
                                      text: 'Bank Name',
                                    )
                                  ]
                              )
                          ),
                          SizedBox(height: TSizes.sm,),
                          RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      color: darkMode ? Colors.white : Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      fontFamily: 'Roboto'
                                  ),
                                  children: const <TextSpan> [
                                    TextSpan(
                                      text: 'Zenith Bank',
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
                      color: Colors.black.withOpacity(0.14),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      color: darkMode ? Colors.white : Colors.black,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 12,
                                      fontFamily: 'Roboto'
                                  ),
                                  children: const <TextSpan> [
                                    TextSpan(
                                      text: 'Total amount',
                                    )
                                  ]
                              )
                          ),
                          SizedBox(height: TSizes.sm,),
                          RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      color: darkMode ? Colors.white : Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      fontFamily: 'Roboto'
                                  ),
                                  children: const <TextSpan> [
                                    TextSpan(
                                      text: 'NGN 190,000.00',
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
                      color: Colors.black.withOpacity(0.14),
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
