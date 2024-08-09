import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pouch/data/modules/background_task.dart';
import 'package:provider/provider.dart';
import 'package:pouch/data/provider/offer_provider.dart';
import 'package:pouch/features/all_offer/apis/api.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';

import '../../../common/widgets/divider.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../icons/svg.dart';
import '../models/offer.dart';
import '../screens/offer_details.dart';

class OfferItem extends StatelessWidget {
  final OfferEntity item;
  const OfferItem({
    super.key,
    required this.item
    // required this.item
  });

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    var provider = Provider.of<OfferProvider>(context);
    return Column(
      children: [
        ListTile(
          hoverColor: Colors.transparent,
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          onTap: (){
            NoLoaderService.instance.getOfferById(
                offerProvider: provider,
                id: item.id,
                onSuccess: (){
                  Get.to(() => OfferDetailsScreen());
                  },
                onFailure: (){}
            );
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
                                text: THelperFunctions.formatRate(item.rate.toString()),
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
        // const DividerWidget()
      ],
    );
  }
}
