
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/all_offer/models/offer.dart';
import 'package:pouch/features/negotiation_offer/screen/negotiation_accept_reject.dart';
import 'package:pouch/features/negotiation_offer/widget/negotiation_list.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import '../../../common/widgets/divider.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../all_offer/models/negotiate_offer_model.dart';
import '../../transaction/icons/svg.dart';

class NegotiationItem extends StatelessWidget {
  final NegotiateOfferModel item;
  const NegotiationItem({
    super.key,
    required this.item
  });

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        ListTile(
          onTap: (){
            Get.to(() => NegotiationAcceptRejectScreen(item: item));
          },
          contentPadding: EdgeInsets.symmetric(vertical: TSizes.md, horizontal: TSizes.defaultSpace),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  TransactionIcon(),
                  const SizedBox(width: TSizes.lg,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.labelMedium,
                              children: <TextSpan> [
                                TextSpan(
                                  text: '${THelperFunctions.moneyFormatter(item.negotiatorAmount.toString())}',
                                    style: TextStyle(
                                        fontWeight: TSizes.fontWeightLg
                                    )
                                ),
                                TextSpan(
                                    text: ' ${item.debitedCurrency}',
                                    style: TextStyle(
                                        fontWeight: TSizes.fontWeightLg,
                                        fontSize: 13
                                    )
                                ),
                              ]
                          )
                      ),
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.labelMedium,
                              children: const <TextSpan> [
                                TextSpan(
                                    text: 'Offer',
                                    style: TextStyle(
                                      fontWeight: TSizes.fontWeightLg,
                                      fontSize: TSizes.fontSize10,
                                      color: TColors.golden,

                                    )
                                ),
                              ]
                          )
                      ),
                    ],
                  )
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
                              text: (THelperFunctions.formatRate(item.negotiatorRate.toString())),
                                style: TextStyle(
                                    color: TColors.primary,
                                    fontWeight: FontWeight.w500
                                )
                            ),
                            TextSpan(
                                text: ' ${item.creditedCurrency} // ${item.debitedCurrency}',
                                style: TextStyle(
                                    color: TColors.primary,
                                    fontSize: TSizes.fontSize12,
                                    fontWeight: FontWeight.w500
                                )
                            ),
                          ]
                      )
                  ),
                  RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.labelSmall,
                          children: <TextSpan> [
                            TextSpan(
                                text: '${THelperFunctions.getFormattedDate(item.createdDate)}  ${THelperFunctions.getFormattedTime(item.createdDate)}',
                                style: TextStyle(
                                    color: darkMode ? TColors.white.withOpacity(0.5) : TColors.textPrimary.withOpacity(0.5),
                                    fontSize: TSizes.fontSize11,
                                    fontWeight: FontWeight.w500
                                )
                            ),
                          ]
                      )
                  ),
                ],
              )
            ],
          ),
        ),
        const DividerWidget()
      ],
    );
  }
}
