import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:pouch/features/negotiation_offer/screen/my_offer_detail.dart';
import 'package:provider/provider.dart';
import 'package:pouch/data/modules/background_task.dart';
import 'package:pouch/data/provider/offer_provider.dart';
import 'package:pouch/features/all_offer/models/offer.dart';
import 'package:pouch/features/negotiation_offer/screen/negotiation_accept_reject.dart';
import 'package:pouch/features/negotiation_offer/widget/negotiation_list.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import '../../../common/widgets/divider.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/texts.dart';
import '../../all_offer/models/negotiate_offer_model.dart';
import '../../transaction/icons/svg.dart';

class MyOfferItem extends StatelessWidget {
  final NegotiateOfferModel item;
  const MyOfferItem({
    super.key,
    required this.item
  });

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    final provider = Provider.of<OfferProvider>(context);
    return Container(
      height: TSizes.textReviewHeight * 1.4,
      child: Slidable(
        key: ValueKey(item.id),
        endActionPane: ActionPane(
            extentRatio: 0.2,
            motion: const ScrollMotion(),
            children: [
              Builder(
                  builder: (cont) {
                    return SizedBox(
                      height: 68,
                      width: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          NoLoaderService.instance.deleteOffer(id: item.id.toString(), offerProvider: provider, days: '', currency: '');
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            backgroundColor: TColors.danger,
                            padding: EdgeInsets.all(0)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 24,
                                width: 24,
                                child: Image(image: AssetImage(TImages.trashIcon))
                            ),
                            Text(
                              'Delete',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: TTexts.fontFamily,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
              ),
            ]
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: TSizes.lg, horizontal: TSizes.defaultSpace),
          onTap: (){
            Get.to(() => MyOfferDetail(item: item));
          },
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.only(top: 5),
                      child: TransactionIcon(height: 14)
                  ),
                  const SizedBox(width: TSizes.lg,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.labelMedium,
                              children: <TextSpan> [
                                TextSpan(
                                    text: '${item.amount}',
                                    style: TextStyle(
                                        fontWeight: TSizes.fontWeightLg,
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
                                    text: 'My Offer',
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
                                text: THelperFunctions.formatRate(item.rate),
                                style: TextStyle(
                                    color: TColors.primary,
                                    fontWeight: FontWeight.w500
                                )
                            ),
                            TextSpan(
                                text: ' ${item.creditedCurrency} // ${item.debitedCurrency} ',
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
                                  color: darkMode ? TColors.white.withOpacity(0.8) : TColors.textPrimary.withOpacity(0.5),
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
      ),
    );
  }
}
