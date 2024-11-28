import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../controllers/tradingOfferController.dart';
import '../models/offer.dart';

class OfferItem extends StatelessWidget {
  final OfferEntity item;
  OfferItem({
    super.key,
    required this.item
  });

  @override
  Widget build(BuildContext context) {
  final TradingOfferController tradingOfferController = Get.put(TradingOfferController());
    final darkMode = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        ListTile(
          hoverColor: Colors.transparent,
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: TSizes.lg),
          onTap: (){
            tradingOfferController.fetchOfferById(id: item.id.toString(), currency: item.debitedCurrency.toString(), onSuccess: () {});
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
                                text: '${THelperFunctions.moneyFormatter(item.amount.toString())} ${item.debitedCurrency}',
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
                                    text: '${THelperFunctions.getTimeDifference(item.createdDate.toString())}',
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
