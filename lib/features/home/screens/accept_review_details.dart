import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:swappr/common/styles/spacing_styles.dart';
import 'package:swappr/common/widgets/buttons/elevated_button.dart';
import 'package:swappr/common/widgets/currencyWidget.dart';
import 'package:swappr/common/widgets/custom_shapes/currency_widget_with_back.dart';
import 'package:swappr/common/widgets/divider.dart';
import 'package:swappr/features/home/models/offer.dart';
import 'package:swappr/features/home/screens/accept_offer_success_page.dart';
import 'package:swappr/features/home/screens/create_offer_success_screen.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/constants/sizes.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';

import '../../../data/provider/subscription_provider.dart';
import '../icons/svg.dart';

class AcceptReviewDetailsScreen extends StatelessWidget {
  final OfferEntity? item;
  const AcceptReviewDetailsScreen({
    super.key,
    this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: TSpacingStyle.homePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CurrencyWidgetWithBack(),
            const SizedBox(height: TSizes.spaceBtwSections / 2,),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: TSizes.spaceBtwSections / 2,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Review Details', style: Theme.of(context).textTheme.titleMedium,),
                          const SizedBox(height: TSizes.spaceBtwSections,),
                          RichText(
                              text: TextSpan(
                                  text: 'You are about to swap ',
                                  style: Theme.of(context).textTheme.labelMedium,
                                  children: <TextSpan> [
                                    TextSpan(
                                        text: '${item?.amount} ${item?.debitedCurrency} ',
                                        style: TextStyle(fontWeight: TSizes.fontWeightLg)
                                    ),
                                    TextSpan(
                                        text: 'for '
                                    ),
                                    TextSpan(
                                        text: '${item?.creditedCurrency}',
                                        style: TextStyle(fontWeight: TSizes.fontWeightLg)
                                    ),
                                  ]
                              )
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwElements * 2,),
                    Container(
                      width: double.infinity,
                      color: TColors.primaryBackground,
                      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                      child: RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.labelSmall,
                              children: const <TextSpan> [
                                TextSpan(
                                    text: 'Offer Summary',
                                    style: TextStyle(fontSize: TSizes.fontSize13, fontWeight: TSizes.fontWeightMd)
                                )
                              ]
                          )
                      ),
                    ),
                    const SizedBox(height: TSizes.md),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                      child: Column(
                        children: [
                          SizedBox(
                            height: TSizes.textReviewHeight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                    text: TextSpan(
                                        style: Theme.of(context).textTheme.labelSmall,
                                        children: const <TextSpan> [
                                          TextSpan(
                                              text: 'has',
                                              style: TextStyle(fontSize: TSizes.fontSize13)
                                          )
                                        ]
                                    )
                                ),
                                RichText(
                                    text: TextSpan(
                                        style: Theme.of(context).textTheme.labelSmall,
                                        children: <TextSpan> [
                                          TextSpan(
                                              text: '${item?.amount} ${item?.debitedCurrency}',
                                              style: TextStyle(fontSize: TSizes.fontSize13, fontWeight: TSizes.fontWeightMd)
                                          )
                                        ]
                                    )
                                ),
                              ],
                            ),
                          ),
                          const DividerWidget(),
                          SizedBox(
                            height: TSizes.textReviewHeight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                    text: TextSpan(
                                        style: Theme.of(context).textTheme.labelSmall,
                                        children: const <TextSpan> [
                                          TextSpan(
                                              text: 'needs',
                                              style: TextStyle(fontSize: TSizes.fontSize13)
                                          )
                                        ]
                                    )
                                ),
                                RichText(
                                    text: TextSpan(
                                        style: Theme.of(context).textTheme.labelSmall,
                                        children: <TextSpan> [
                                          TextSpan(
                                              text: '${item?.creditedCurrency}',
                                              style: TextStyle(fontSize: TSizes.fontSize13, fontWeight: TSizes.fontWeightMd)
                                          )
                                        ]
                                    )
                                ),
                              ],
                            ),
                          ),
                          const DividerWidget(),
                          SizedBox(
                            height: TSizes.textReviewHeight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                    text: TextSpan(
                                        style: Theme.of(context).textTheme.labelSmall,
                                        children: const <TextSpan> [
                                          TextSpan(
                                              text: 'Rate',
                                              style: TextStyle(fontSize: TSizes.fontSize13)
                                          )
                                        ]
                                    )
                                ),
                                RichText(
                                    text: TextSpan(
                                        style: Theme.of(context).textTheme.labelSmall,
                                        children: <TextSpan> [
                                          TextSpan(
                                              text: '${item?.rate} ${item?.debitedCurrency} // ${item?.creditedCurrency}',
                                              style: TextStyle(color: TColors.primary)
                                          )
                                        ]
                                    )
                                ),
                              ],
                            ),
                          ),
                          const DividerWidget(),
                          SizedBox(
                            height: TSizes.textReviewHeight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    RichText(
                                        text: TextSpan(
                                            style: Theme.of(context).textTheme.labelSmall,
                                            children: const <TextSpan> [
                                              TextSpan(
                                                  text: 'Fee',
                                                  style: TextStyle(fontSize: TSizes.fontSize13)
                                              )
                                            ]
                                        )
                                    ),
                                    const SizedBox(width: TSizes.md),
                                    NotiIcon(),
                                  ],
                                ),
                                RichText(
                                    text: TextSpan(
                                        style: Theme.of(context).textTheme.labelSmall,
                                        children: const <TextSpan> [
                                          TextSpan(
                                              text: '5 GBP',
                                              style: TextStyle(fontSize: TSizes.fontSize13, fontWeight: TSizes.fontWeightMd)
                                          )
                                        ]
                                    )
                                ),
                              ],
                            ),
                          ),
                          const DividerWidget(),
                          SizedBox(
                            height: TSizes.textReviewHeight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                    text: TextSpan(
                                        style: Theme.of(context).textTheme.labelSmall,
                                        children: const <TextSpan> [
                                          TextSpan(
                                              text: 'You will be debited from',
                                              style: TextStyle(fontSize: TSizes.fontSize13)
                                          )
                                        ]
                                    )
                                ),
                              ],
                            ),
                          ),
                          const DividerWidget(),
                          SizedBox(
                            height: TSizes.textReviewHeight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                    text: TextSpan(
                                        style: Theme.of(context).textTheme.labelSmall,
                                        children: const <TextSpan> [
                                          TextSpan(
                                              text: 'You will be credited to',
                                              style: TextStyle(fontSize: TSizes.fontSize13)
                                          )
                                        ]
                                    )
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: TSizes.spaceBtwSections),
                          TElevatedButton(onTap: (){
                            Get.to(() => const AcceptOfferSuccessPage());},
                              buttonText: 'Pay 100 GBP'),
                          const SizedBox(height: TSizes.spaceBtwSections ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
