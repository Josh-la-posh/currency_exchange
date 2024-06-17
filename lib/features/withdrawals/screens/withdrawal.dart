import 'package:flutter/material.dart';
import 'package:swappr/common/widgets/buttons/elevated_button.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/constants/image_strings.dart';
import 'package:swappr/utils/constants/sizes.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';

import '../widgets/withdrawal_sheet.dart';

class WithdrawalScreen extends StatelessWidget {
  const WithdrawalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton()
      ),
      backgroundColor: darkMode ? Colors.black : const Color(0xFFD0CDE1).withOpacity(0.31),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                  text: TextSpan(
                      style: TextStyle(
                          color: darkMode ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                          fontFamily: 'Roboto'
                      ),
                      children: const <TextSpan> [
                        TextSpan(
                          text: 'Withdraw Money',
                        )
                      ]
                  )
              ),
              SizedBox(height: THelperFunctions.screenHeight() * 0.08,),
              Container(
                padding: const EdgeInsets.symmetric(vertical: TSizes.defaultSpace),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.09),
                  )
                ),
                child: Column(
                  children: [
                    RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: darkMode ? Colors.white : Colors.black.withOpacity(0.55),
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                                fontFamily: 'Roboto'
                            ),
                            children: const <TextSpan> [
                              TextSpan(
                                text: 'Amount',
                              )
                            ]
                        )
                    ),
                    const SizedBox(height: 15,),
                    RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: darkMode ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 36,
                                fontFamily: 'Roboto'
                            ),
                            children: const <TextSpan> [
                              TextSpan(
                                text: 'N125,000.00',
                              )
                            ]
                        )
                    ),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.defaultSpace * 1.5,),
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
                          text: 'N340,000.00',
                        )
                      ]
                  )
              ),
              const SizedBox(height: TSizes.md,),
              RichText(
                  text: TextSpan(
                      style: TextStyle(
                          color: darkMode ? Colors.white : Colors.black.withOpacity(0.35),
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          fontFamily: 'Roboto'
                      ),
                      children: const <TextSpan> [
                        TextSpan(
                          text: 'Available Balance',
                        )
                      ]
                  )
              ),
              const SizedBox(height: TSizes.defaultSpace * 2,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Image(image: AssetImage(TImages.withdrawIcon)),
                      const SizedBox(width: 5,),
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
                                  text: 'Withdraw Money To',
                                )
                              ]
                          )
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Row(
                      children: [
                        const SizedBox(
                            width: 20,
                            child: Icon(Icons.add, size: 20,)
                        ),
                        RichText(
                            text: const TextSpan(
                                style: TextStyle(
                                    color: TColors.primary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    fontFamily: 'Roboto'
                                ),
                                children: <TextSpan> [
                                  TextSpan(
                                    text: 'Add Bank Account',
                                  )
                                ]
                            )
                        ),
                      ],
                    ),
                  ),],
              ),
              const SizedBox(height: TSizes.defaultSpace * 3,),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 12, bottom: 12, right: 20, left: TSizes.defaultSpace * 1.5),
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
                          color: Colors.white.withOpacity(0.85),
                          offset: const Offset(0.0,0.0),
                          blurRadius: 0,
                          spreadRadius: 0
                      ),
                      BoxShadow(
                          color: const Color(0xFFD0CDE1).withOpacity(0.31),
                          offset: const Offset(0.0,0.0),
                          blurRadius: 0,
                          spreadRadius: 0
                      ),
                    ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Image(image: AssetImage(TImages.withdrawIcon)),
                        const SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        color: darkMode ? Colors.white : Colors.black.withOpacity(0.43),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        fontFamily: 'Roboto'
                                    ),
                                    children: const <TextSpan> [
                                      TextSpan(
                                        text: 'Zenith Bank Account',
                                      ),
                                    ]
                                )
                            ),
                            const SizedBox(height: TSizes.md,),
                            RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        color: darkMode ? Colors.white : Colors.black.withOpacity(0.43),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        fontFamily: 'Roboto'
                                    ),
                                    children: const <TextSpan> [
                                      TextSpan(
                                        text: '*** **** *****4543',
                                      ),
                                    ]
                                )
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      height: 19,
                      width: 19,
                      decoration: BoxDecoration(
                        color: Color(0xFFD9D9D9),
                        border: Border.all(
                          color: TColors.primary,
                        )
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: TSizes.defaultSpace * 2,),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 20, right: TSizes.defaultSpace, left: TSizes.defaultSpace),
        child: TElevatedButton(
            onTap: () {
              showModalBottomSheet(
                  backgroundColor: Color(0xFF4C3668),
                  // isScrollControlled: true,
                  context: context,
                  builder: (ctx) => WithdrawalConfirmSheet()
              );
            },
            buttonText: 'Continue'
        ),
      ),
    );
  }
}
