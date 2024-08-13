import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../all_offer/models/negotiate_offer_model.dart';

class MyOfferDetail extends StatelessWidget {
  final NegotiateOfferModel? item;
  MyOfferDetail({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    final height = THelperFunctions.screenHeight();
    final width = THelperFunctions.screenWidth();
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: darkMode ? TColors.textPrimaryO40 : Colors.white,
      appBar: AppBar(
        backgroundColor: darkMode ? TColors.textPrimary.withOpacity(0) : Colors.white,
        surfaceTintColor: darkMode ? TColors.textPrimary.withOpacity(0) : Colors.white,
        leading: IconButton(
          onPressed: (){Get.back();},
          icon: const Icon(Icons.arrow_back),
          style: IconButton.styleFrom(
              foregroundColor: Colors.grey,
              iconSize: TSizes.iconBackSize
          ),
          hoverColor: Colors.transparent,
        ),
        title: Text(
            'Offer Details',
            style: Theme.of(context).textTheme.titleMedium
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       RichText(
            //           text: TextSpan(
            //               style: Theme.of(context).textTheme.labelMedium,
            //               children: <TextSpan> [
            //                 TextSpan(
            //                     text: 'You are about to swap ',
            //                     style: const TextStyle(
            //                       // fontSize: 16
            //                     )
            //                 ),
            //               ]
            //           )
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(height: TSizes.spaceBtwElements),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                  height: TSizes.textReviewHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.labelMedium,
                              children: const <TextSpan> [
                                TextSpan(
                                  text: 'I have',
                                  // style: TextStyle(fontSize: TSizes.fontSize13)
                                )
                              ]
                          )
                      ),
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.labelMedium,
                              children: <TextSpan> [
                                TextSpan(
                                    text: '${item!.amount} ${item!.debitedCurrency}',
                                    style: const TextStyle(
                                        fontWeight: TSizes.fontWeightLg
                                    )
                                )
                              ]
                          )
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                  height: TSizes.textReviewHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.labelMedium,
                              children: const <TextSpan> [
                                TextSpan(
                                  text: 'I need',
                                  // style: TextStyle(fontSize: TSizes.fontSize13)
                                )
                              ]
                          )
                      ),
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.labelMedium,
                              children: <TextSpan> [
                                TextSpan(
                                    text: item!.creditedCurrency,
                                    style: const TextStyle(
                                      // fontSize: TSizes.fontSize13,
                                        fontWeight: TSizes.fontWeightLg
                                    )
                                )
                              ]
                          )
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                  height: TSizes.textReviewHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.labelMedium,
                              children: const <TextSpan> [
                                TextSpan(
                                  text: 'Preferred Rate',
                                  // style: TextStyle(fontSize: TSizes.fontSize13)
                                )
                              ]
                          )
                      ),
                      Row(
                        children: [
                          RichText(
                              text: TextSpan(
                                  style: Theme.of(context).textTheme.labelMedium,
                                  children: <TextSpan> [
                                    TextSpan(
                                        text: '${(THelperFunctions.formatRate(item!.rate))} ${item!.creditedCurrency} // ${item!.debitedCurrency}',
                                        style: const TextStyle(
                                          // fontSize: TSizes.fontSize13,
                                            fontWeight: TSizes.fontWeightLg
                                        )
                                    )
                                  ]
                              )
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                  height: TSizes.textReviewHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.labelMedium,
                              children: const <TextSpan> [
                                TextSpan(
                                  text: 'Status',
                                  // style: TextStyle(fontSize: TSizes.fontSize13)
                                )
                              ]
                          )
                      ),
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.labelMedium,
                              children: <TextSpan> [
                                TextSpan(
                                    text: '${item!.status}',
                                    style: const TextStyle(
                                        fontWeight: TSizes.fontWeightLg
                                    )
                                )
                              ]
                          )
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace / 2),
                  child: Column(
                    children: [
                      const SizedBox(height: TSizes.xs),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace / 2),
                        height: TSizes.textReviewHeight,
                        decoration: BoxDecoration(
                            color: TColors.secondaryBorder30,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 25.0),
                              child: RichText(
                                  text: TextSpan(
                                      style: Theme.of(context).textTheme.labelSmall,
                                      children: <TextSpan> [
                                        TextSpan(
                                            text: 'I have',
                                            style: TextStyle(
                                              fontSize: 10,
                                                color: darkMode ? TColors.white : TColors.primary
                                            )
                                        ),
                                      ]
                                  )
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.settings, size: 18, color: TColors.grey,),
                                SizedBox(width: 5,),
                                RichText(
                                    text: TextSpan(
                                        style: Theme.of(context).textTheme.labelMedium,
                                        children: <TextSpan> [
                                          TextSpan(
                                              text: item!.debitedCurrency,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: darkMode ? TColors.white : TColors.primary
                                              )
                                          ),
                                        ]
                                    )
                                ),
                                Spacer(),
                                RichText(
                                    text: TextSpan(
                                        style: Theme.of(context).textTheme.labelMedium,
                                        children: <TextSpan> [
                                          TextSpan(
                                              text: THelperFunctions.moneyFormatter(item!.amount),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: darkMode ? TColors.white : TColors.primary
                                              )
                                          ),
                                        ]
                                    )
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: TSizes.defaultSpace,),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace / 2),
                        height: TSizes.textReviewHeight,
                        decoration: BoxDecoration(
                            color: TColors.secondaryBorder30,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 25.0),
                              child: RichText(
                                  text: TextSpan(
                                      style: Theme.of(context).textTheme.labelSmall,
                                      children: <TextSpan> [
                                        TextSpan(
                                            text: 'I get',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: darkMode ? TColors.white : TColors.primary
                                            )
                                        ),
                                      ]
                                  )
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.settings, size: 18, color: TColors.grey,),
                                SizedBox(width: 5,),
                                RichText(
                                    text: TextSpan(
                                        style: Theme.of(context).textTheme.labelMedium,
                                        children: <TextSpan> [
                                          TextSpan(
                                              text: item!.creditedCurrency,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: darkMode ? TColors.white : TColors.primary
                                              )
                                          ),
                                        ]
                                    )
                                ),
                                Spacer(),
                                RichText(
                                    text: TextSpan(
                                        style: Theme.of(context).textTheme.labelMedium,
                                        children: <TextSpan> [
                                          TextSpan(
                                              text: THelperFunctions.moneyFormatter(THelperFunctions.getStringMultiplication(item!.amount, item!.rate)),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: darkMode ? TColors.white : TColors.primary
                                              )
                                          ),
                                        ]
                                    )
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
