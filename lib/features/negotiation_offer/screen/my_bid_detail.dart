import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../all_offer/models/negotiate_offer_model.dart';

class MyBidDetail extends StatelessWidget {
  final NegotiateOfferModel? item;
  MyBidDetail({super.key, this.item});

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
            'Bid Details',
            style: Theme.of(context).textTheme.titleMedium
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace * 1.5, vertical: 10),
                  // margin: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                  decoration: BoxDecoration(
                      color: TColors.secondaryBorder30,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.labelMedium,
                          children: <TextSpan> [
                            TextSpan(
                                text: 'Offer',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: darkMode ? TColors.white : TColors.primary
                                )
                            ),
                          ]
                      )
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
                                  text: 'has',
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
                                  text: 'rate',
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
              ],
            ),
            SizedBox(height: 50,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace * 1.5, vertical: 10),
                  // margin: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: TColors.secondaryBorder30,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.labelMedium,
                          children: <TextSpan> [
                            TextSpan(
                                text: 'My Bid',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: darkMode ? TColors.white : TColors.primary
                                )
                            ),
                          ]
                      )
                  ),
                ),
                SizedBox(height: 20,),
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
                                    text: '${THelperFunctions.moneyFormatter(item!.negotiatorAmount.toString())} ${item!.debitedCurrency}',
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
                                        text: '${(THelperFunctions.formatRate(item!.negotiatorRate.toString()))} ${item!.creditedCurrency} // ${item!.debitedCurrency}',
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
