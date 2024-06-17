import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:swappr/data/provider/offer_provider.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/texts.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../all_offer/icons/svg.dart';
import '../../all_offer/screens/all_offer.dart';
import '../../all_offer/screens/offer_details.dart';

class TrendingOffer extends StatelessWidget {
  final OfferProvider offerProvider;
  final bool darkMode;
  const TrendingOffer({super.key, required this.offerProvider, required this.darkMode});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace / 1.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: TSizes.lg, vertical: TSizes.xs),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: TColors.primary
                    ),
                  color: darkMode ? TColors.primary : Colors.transparent
                ),
                child: Row(
                  children: [
                    Text('Trending Offer',
                      style: TextStyle(
                        color: darkMode ? TColors.white : TColors.primary,
                        fontSize: 16,
                        fontWeight: TSizes.fontWeightNm,
                        fontFamily: TTexts.fontFamily,
                      ),
                    ),
                    const SizedBox(width: TSizes.md,),
                    Container(
                      width: 23,
                      height: 23,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23)
                      ),
                      child: const Image(image: AssetImage('assets/icons/homeIcons/trading_offer.png')),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => const AllOfferScreen());
                },
                child: Row(
                  children: [
                    Text('View All',
                      style: TextStyle(
                          color: darkMode ? TColors.white.withOpacity(0.5) : TColors.primary,
                          fontSize: 12,
                          fontWeight: TSizes.fontWeightNm,
                          fontFamily: TTexts.fontFamily
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: TSizes.lg,),
        offerProvider.offers.isEmpty
            ? const SizedBox(
          width: double.infinity,
          // color: Colors.white,
        )
            : ListView.builder(
              shrinkWrap: true,
              itemCount: offerProvider.offers.length > 3 ? 3 : offerProvider.offers.length,
              itemBuilder: (_, index) {
                final item = offerProvider.offers[index];
                return Column(
                children: [
                  Container(
                    color: darkMode ? TColors.textBlack.withOpacity(0.5) : Colors.white,
                    child: ListTile(
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: TSizes.md),
                      onTap: (){
                        Get.to(() => OfferDetailsScreen(item: item));
                      },
                      title: Row(
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
                                            text: 'has: ${item.amount} ${item.debitedCurrency}',
                                            style: const TextStyle(fontSize: TSizes.fontSize13)
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
                                            text: 'needs: ${item.creditedCurrency}',
                                            style: const TextStyle(
                                              fontSize: TSizes.fontSize13,
                                            )
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
                                            text: '${item.rate} ${item.debitedCurrency} // ${item.creditedCurrency}',
                                            style: const TextStyle(
                                                fontSize: TSizes.fontSize13,
                                                color: TColors.primary
                                            )
                                        ),
                                      ]
                                  )
                              ),
                              const SizedBox(height: TSizes.md,),
                              Row(
                                children: [
                                  OfferEyeIcon(),
                                  const SizedBox(width: TSizes.md,),
                                  RichText(
                                      text: TextSpan(
                                          style: Theme.of(context).textTheme.labelSmall,
                                          children: <TextSpan> [
                                            TextSpan(
                                                text: '${item.views}',
                                                style: TextStyle(
                                                  color: darkMode ? TColors.white.withOpacity(0.7) : TColors.textPrimaryO80,
                                                )
                                            ),
                                          ]
                                      )
                                  ),
                                  const SizedBox(width: TSizes.lg,),
                                  RichText(
                                      text: TextSpan(
                                          style: Theme.of(context).textTheme.labelSmall,
                                          children: <TextSpan> [
                                            TextSpan(
                                                text: '40 secs ago',
                                                style: TextStyle(
                                                  color: darkMode ? TColors.white.withOpacity(0.7) : TColors.textPrimary.withOpacity(0.5),
                                                )
                                            ),
                                          ]
                                      )
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: TSizes.md,)
                ],
              );
            },
            ),
      ],
    );
  }
}
