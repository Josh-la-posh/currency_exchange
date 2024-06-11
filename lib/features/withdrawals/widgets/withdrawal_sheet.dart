import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swappr/utils/constants/sizes.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';

class WithdrawalConfirmSheet extends StatelessWidget {
  const WithdrawalConfirmSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: TSizes.defaultSpace * 1.5),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace * 2),
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
                                fontSize: 18,
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
                                  fontSize: 18,
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
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                                fontFamily: 'Roboto'
                            ),
                            children: const <TextSpan> [
                              TextSpan(
                                text: '1,250,000',
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
                                  fontSize: 18,
                                  fontFamily: 'Roboto'
                              ),
                              children: const <TextSpan> [
                                TextSpan(
                                  text: 'NGN Account',
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
            margin: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
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
                        children: const <TextSpan> [
                          TextSpan(
                            text: 'Josh Moore Kind',
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
                            children: const <TextSpan> [
                              TextSpan(
                                text: 'Access Bank',
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
                            children: const <TextSpan> [
                              TextSpan(
                                text: '2561782904',
                              )
                            ]
                        )
                    ),
                  ],
                )
              ],
            ),
          ),
          Column(
            // crossAxisAlignment: CrossAxisAlignment.end,
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
          )
        ],
      ),
    );
  }
}
