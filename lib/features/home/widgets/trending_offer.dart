import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pouch/data/provider/offer_provider.dart';
import 'package:pouch/features/all_offer/apis/api.dart';
import 'package:pouch/features/home/screens/home.dart';
import 'package:pouch/utils/constants/image_strings.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/texts.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../all_offer/icons/svg.dart';
import '../../all_offer/screens/all_offer.dart';

class TrendingOffer extends StatelessWidget {
  final bool displayOffer;
  final OfferProvider offerProvider;
  final bool darkMode;
  const TrendingOffer({super.key, required this.offerProvider, required this.darkMode, required this.displayOffer});

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
                  color: darkMode ? TColors.primary : TColors.secondaryBorder30
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
                      child: Image(image: AssetImage(TImages.trendingOfferIcon)),
                    ),
                  ],
                ),
              ),
              IconButton(
                hoverColor: Colors.transparent,
                onPressed: () {
                  Get.to(() => const AllOfferScreen());
                },
                icon: Row(
                  children: [
                    Text('View All',
                      style: TextStyle(
                          color: darkMode ? TColors.white.withOpacity(0.5) : TColors.primary,
                          fontSize: 12,
                          fontWeight: TSizes.fontWeightNm,
                          fontFamily: TTexts.fontFamily
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_right_outlined,
                      size: 20,
                      color: darkMode ? TColors.white.withOpacity(0.5) : TColors.primary
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: TSizes.lg,),
        displayOffer == false
            ? CircularProgressIndicator()
            : offerProvider.offers.isEmpty
            ? SizedBox(
          height: 80,
              child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.titleMedium,
                        children: <TextSpan> [
                          TextSpan(
                              text: 'No offer available',
                              style: TextStyle(color: TColors.primary)
                          ),
                        ]
                      )
                    ),
                ],
              ),
            )
            : ListView.builder(
              shrinkWrap: true,
              itemCount: offerProvider.offers.length > 3 ? 3 : offerProvider.offers.length,
              itemBuilder: (_, index) {
                final item = offerProvider.offers[index];
                return Column(
                children: [
                  Container(
                    // color: darkMode ? TColors.textBlack.withOpacity(0.5) : Colors.white,
                    child: ListTile(

                      tileColor: darkMode ? Colors.black38 : Color(0xFFFDF9FE),
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: TSizes.md),
                      onTap: (){
                        OfferService.instance.getOfferById(
                            offerProvider: offerProvider,
                            id: item.id,
                            onTap: () {
                              Get.to(() => HomeScreen());
                            });
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
                                            text: 'has: ',
                                            style: TextStyle(fontSize: 13)
                                        ),
                                        TextSpan(
                                            text: '${item.amount} ${item.debitedCurrency}',
                                            style: TextStyle(fontWeight: FontWeight.w500)
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
                                            text: 'needs: ',
                                            style: TextStyle(fontSize: 13)
                                        ),
                                        TextSpan(
                                            text: '${item.creditedCurrency}',
                                            style: TextStyle(fontWeight: FontWeight.w500)
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
                                            text: '${item.rate}',
                                            style: TextStyle(color: TColors.primary, fontWeight: FontWeight.w500)
                                        ),
                                        TextSpan(
                                            text: ' ${item.creditedCurrency} // ${item.debitedCurrency}',
                                            style: TextStyle(fontSize: TSizes.fontSize12, color: TColors.primary, fontWeight: FontWeight.w500)
                                        ),
                                      ]
                                  )
                              ),
                              const SizedBox(height: TSizes.md,),
                              Row(
                                children: [
                                  Icon(
                                    Icons.visibility,
                                    size: 15,
                                  ),
                                  const SizedBox(width: TSizes.md,),
                                  RichText(
                                      text: TextSpan(
                                          style: Theme.of(context).textTheme.labelSmall,
                                          children: <TextSpan> [
                                            TextSpan(
                                                text: '${item.views}',
                                                style: TextStyle(
                                                  color: darkMode ? TColors.white : TColors.textPrimaryO80,
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
                                                text: '${THelperFunctions.getTimeDifference(item.createdDate)} ago',
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
