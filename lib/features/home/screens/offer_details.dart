import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:swappr/common/styles/spacing_styles.dart';
import 'package:swappr/common/widgets/buttons/elevated_button.dart';
import 'package:swappr/common/widgets/buttons/outlined_button.dart';
import 'package:swappr/common/widgets/currencyWidget.dart';
import 'package:swappr/features/home/screens/accept_review_details.dart';
import 'package:swappr/features/home/widgets/negotiation_screen.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';

import '../../../common/widgets/custom_shapes/currency_widget_with_back.dart';
import '../../../data/provider/offer_provider.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class OfferDetailsScreen extends StatelessWidget {
  const OfferDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final offerProvider = Provider.of<OfferProvider>(context);
    final selectedOffer = offerProvider.selectedOffer;

    // if (selectedOffer == null){
    //   return Scaffold(
    //     appBar: AppBar(
    //       title: Text('Offer Details'),
    //     ),
    //     body: Center(
    //       child: Text('No offer selected'),
    //     ),
    //   );
    // }

    return Scaffold(
      body: Padding(
        padding: TSpacingStyle.homePadding,
        child: Column(
          children: [
            const CurrencyWidgetWithBack(),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(
                                style: Theme.of(context).textTheme.titleMedium,
                                children: const <TextSpan> [
                                  TextSpan(
                                      text: 'Would you like to swap?',
                                      style: TextStyle(fontWeight: TSizes.fontWeightMd)
                                  )
                                ]
                            )
                        ),
                        const SizedBox(height: TSizes.spaceBtwElements * 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                    text: TextSpan(
                                        style: Theme.of(context).textTheme.labelMedium,
                                        children: const <TextSpan> [
                                          TextSpan(
                                              text: 'has: 20,000 NGN',
                                          ),
                                        ]
                                    )
                                ),
                                const SizedBox(height: TSizes.md,),
                                RichText(
                                    text: TextSpan(
                                        style: Theme.of(context).textTheme.labelMedium,
                                        children: const <TextSpan> [
                                          TextSpan(
                                              text: 'needs: 95 GBP',
                                          ),
                                        ]
                                    )
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                RichText(
                                    text: TextSpan(
                                        style: Theme.of(context).textTheme.labelMedium,
                                        children: const <TextSpan> [
                                          TextSpan(
                                              text: '600 NGN // GBP',
                                              style: TextStyle(fontSize: TSizes.fontSize13, color: TColors.primary)
                                          ),
                                        ]
                                    )
                                ),
                                const SizedBox(height: TSizes.md,),
                                RichText(
                                  text: TextSpan(
                                    style: Theme.of(context).textTheme.labelSmall,
                                    children: const <TextSpan> [
                                      TextSpan(
                                          text: 'Created at 40 secs ago',
                                      ),
                                    ]
                                  )
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: TSizes.spaceBtwSections),
                        Container(
                          width: double.infinity,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: TColors.primaryBackground
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: TSizes.lg),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    color: TColors.primary,
                                    borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: const Center(
                                    child: Text('!', style: TextStyle(
                                      color: TColors.white
                                    ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: TSizes.md,),
                                Text(
                                  'This offer expires in 2 hours, 37 minutes',
                                  style: Theme.of(context).textTheme.labelSmall,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
        ),
        child: SizedBox(
          height: 150,
          child: BottomAppBar(
            padding: const EdgeInsets.all(0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
              color: TColors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                  children: [
                  SizedBox(
                    width: double.infinity,
                    height: TSizes.buttonHeight,
                    child: ElevatedButton(
                      onPressed: () {Get.to(() => const AcceptReviewDetailsScreen());},
                      child: const Text("I'm interested"),
                    ),
                  ),
                    const SizedBox(height: TSizes.spaceBtwButtons,),
              SizedBox(
                width: double.infinity,
                height: TSizes.buttonHeight,
                child: OutlinedButton(
                  onPressed: () {
                    showModalBottomSheet(
                        backgroundColor: TColors.white,
                        isDismissible: false,
                        isScrollControlled: true,
                        enableDrag: false,
                        context: context,
                        builder: (ctx) => const NegotiationScreen()
                    );
                  }, // Handle button press
                  child: const Text("I'm interested, but..."),
                  ),
              ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

