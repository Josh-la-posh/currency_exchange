import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:swappr/common/styles/spacing_styles.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';
import '../../../common/widgets/custom_shapes/currency_widget_with_back.dart';
import '../../../data/provider/offer_provider.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../models/offer.dart';
import '../widgets/negotiation_screen.dart';
import 'accept_review_details.dart';

class OfferDetailsScreen extends StatelessWidget {
  VoidCallback? onTap;
  OfferDetailsScreen({
    super.key,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    var provider = Provider.of<OfferProvider>(context);
    final item = provider.offerDetail;
    return Scaffold(
      backgroundColor: darkMode ? TColors.black.withOpacity(0.8) : TColors.white,
      body: Padding(
        padding: TSpacingStyle.homePadding,
        child: Column(
          children: [
            CurrencyWidgetWithBack(onTap: onTap,),
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
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
                                  children: <TextSpan> [
                                    TextSpan(
                                        text: 'has: ${item?.amount} ${item?.debitedCurrency}',
                                    ),
                                  ]
                              )
                          ),
                          const SizedBox(height: TSizes.md,),
                          RichText(
                              text: TextSpan(
                                  style: Theme.of(context).textTheme.labelMedium,
                                  children: <TextSpan> [
                                    TextSpan(
                                        text: 'needs: ${item?.creditedCurrency}',
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
                                  children: <TextSpan> [
                                    TextSpan(
                                        text: '${item?.rate} ${item?.debitedCurrency} // ${item?.creditedCurrency}',
                                        style: const TextStyle(fontSize: TSizes.fontSize13, color: TColors.primary)
                                    ),
                                  ]
                              )
                          ),
                          const SizedBox(height: TSizes.md,),
                          RichText(
                            text: TextSpan(
                              style: Theme.of(context).textTheme.labelSmall,
                              children: <TextSpan> [
                                TextSpan(
                                    text: 'Created ${THelperFunctions.getTimeDifference(item!.createdDate)} ago',
                                ),
                              ]
                            )
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: 10),
              decoration: const BoxDecoration(
                  color: TColors.primaryBackground
              ),
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
                  Expanded(
                    child: RichText(
                        // textAlign: TextAlign.center,
                        text: TextSpan(
                            style: Theme.of(context).textTheme.labelSmall,
                            children: <TextSpan> [
                              TextSpan(
                                  text: 'This offer expires in ${item?.expireCountDown == null ? '' : THelperFunctions.millisecondConversion(item!.expireCountDown) ?? ''}',
                                  style: TextStyle(
                                      color: TColors.textPrimaryO80
                                  )
                              ),

                            ]
                        )
                    ),
                  ),
                ],
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
              color: darkMode ? TColors.black.withOpacity(0.8) : TColors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                    width: double.infinity,
                    height: TSizes.buttonHeight,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => AcceptReviewDetailsScreen(item: item));
                        },
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
                        // isDismissible: false,
                        isScrollControlled: true,
                        // enableDrag: false,
                        context: context,
                        builder: (ctx) => NegotiationScreen(id: item!.id)
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

