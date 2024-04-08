import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swappr/common/styles/spacing_styles.dart';
import 'package:swappr/common/widgets/buttons/elevated_button.dart';
import 'package:swappr/common/widgets/buttons/outlined_button.dart';
import 'package:swappr/common/widgets/currencyWidget.dart';
import 'package:swappr/features/dashboard/screens/home/accept_review_details.dart';
import 'package:swappr/features/dashboard/screens/home/widgets/negotiation_screen.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/custom_shapes/currency_widget_with_back.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class OfferDetailsScreen extends StatelessWidget {
  const OfferDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: TSpacingStyle.homePadding,
        child: Column(
          children: [
            const CurrencyWidgetWithBack(),
            SizedBox(
              height: THelperFunctions.screenHeight() - 146,
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
                    Column(
                      children: [
                        TElevatedButton(
                            onTap: (){Get.to(() => const AcceptReviewDetailsScreen());},
                            buttonText: "I'm interested"
                        ),
                        const SizedBox(height: TSizes.spaceBtwButtons,),
                        TOutlinedButton(
                            onTap: (){
                              showModalBottomSheet(
                                backgroundColor: TColors.white,
                                isDismissible: false,
                                isScrollControlled: true,
                                enableDrag: false,
                                context: context,
                                builder: (ctx) => const NegotiationScreen()
                              );
                            },
                            buttonText: "I'm interested, but..."
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

