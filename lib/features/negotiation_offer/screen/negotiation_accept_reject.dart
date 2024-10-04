import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/all_offer/controllers/offer_controller.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import '../../../common/widgets/buttons/elevated_button.dart';
import '../../../common/widgets/currencyWidget.dart';
import '../../../common/widgets/custom_time_line.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/layouts/list_layout.dart';
import '../../all_offer/icons/svg.dart';
import '../../all_offer/models/offer.dart';
import '../../all_offer/widgets/success_page.dart';

class NegotiationAcceptRejectScreen extends StatelessWidget {
  final OfferEntity? item;
  NegotiationAcceptRejectScreen({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    OfferController offerController = Get.find();
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          centerTitle: true,
          title: RichText(
              text: TextSpan(
                  style: Theme.of(context).textTheme.labelSmall,
                  children: const <TextSpan> [
                    TextSpan(
                        text: 'Offers Detail',
                        style: TextStyle(fontSize: TSizes.fontSize16, fontWeight: TSizes.fontWeightMd)
                    )
                  ]
              )
          ),
        ),
      body: Obx(() {
        if (offerController.showAcceptOfferMsg.value == false && offerController.showRejectOfferMsg.value == false) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CurrencyWidget(),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace * 0.8, vertical: 10),
                            // margin: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                            decoration: BoxDecoration(
                                color: TColors.secondaryBorder30,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: RichText(
                                text: TextSpan(
                                    style: Theme.of(context).textTheme.labelMedium,
                                    children: <TextSpan> [
                                      TextSpan(
                                          text: 'Offer Created',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: darkMode ? TColors.white : TColors.primary
                                          )
                                      ),
                                    ]
                                )
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                            height: TSizes.textReviewHeight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                    text: TextSpan(
                                        style: Theme.of(context).textTheme.labelMedium,
                                        children: const <TextSpan> [
                                          TextSpan(
                                            text: 'has',
                                          )
                                        ]
                                    )
                                ),
                                RichText(
                                    text: TextSpan(
                                        style: Theme.of(context).textTheme.labelMedium,
                                        children: <TextSpan> [
                                          TextSpan(
                                              text: '${THelperFunctions.moneyFormatter(item!.amount.toString())} ${item!.debitedCurrency}',
                                              style: TextStyle(
                                                  fontWeight: TSizes.fontWeightMd
                                              )
                                          )
                                        ]
                                    )
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                            height: TSizes.textReviewHeight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                    text: TextSpan(
                                        style: Theme.of(context).textTheme.labelMedium,
                                        children: const <TextSpan> [
                                          TextSpan(
                                            text: 'Rate',
                                          )
                                        ]
                                    )
                                ),
                                RichText(
                                    text: TextSpan(
                                        style: Theme.of(context).textTheme.labelMedium,
                                        children: <TextSpan> [
                                          TextSpan(
                                              text: (THelperFunctions.formatRate(item!.rate.toString())),
                                              style: TextStyle(fontWeight: TSizes.fontWeightMd)
                                          ),
                                          TextSpan(
                                              text: ' ${item!.creditedCurrency} // ${item!.debitedCurrency}',
                                              style: TextStyle(fontWeight: TSizes.fontWeightMd)
                                          )
                                        ]
                                    )
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                      SizedBox(height: 30,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace * 0.8, vertical: 10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: TColors.secondaryBorder30,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: RichText(
                                text: TextSpan(
                                    style: Theme.of(context).textTheme.labelMedium,
                                    children: <TextSpan> [
                                      TextSpan(
                                          text: 'Bid received',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: darkMode ? TColors.white : TColors.primary
                                          )
                                      ),
                                    ]
                                )
                            ),
                          ),
                          const SizedBox(height: TSizes.spaceBtwElements ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                            height: TSizes.textReviewHeight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                    text: TextSpan(
                                        style: Theme.of(context).textTheme.labelMedium,
                                        children: const <TextSpan> [
                                          TextSpan(
                                            text: 'need',
                                          )
                                        ]
                                    )
                                ),
                                RichText(
                                    text: TextSpan(
                                        style: Theme.of(context).textTheme.labelMedium,
                                        children: <TextSpan> [
                                          TextSpan(
                                              text: '${THelperFunctions.moneyFormatter(item!.negotiatorAmount.toString())} ${item!.debitedCurrency}',
                                              style: TextStyle(
                                                  fontWeight: TSizes.fontWeightMd
                                              )
                                          )
                                        ]
                                    )
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                            height: TSizes.textReviewHeight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                    text: TextSpan(
                                        style: Theme.of(context).textTheme.labelMedium,
                                        children: const <TextSpan> [
                                          TextSpan(
                                            text: 'Rate',
                                          )
                                        ]
                                    )
                                ),
                                RichText(
                                    text: TextSpan(
                                        style: Theme.of(context).textTheme.labelMedium,
                                        children: <TextSpan> [
                                          TextSpan(
                                              text: (THelperFunctions.formatRate(item!.negotiatorRate.toString())),
                                              style: TextStyle(fontWeight: TSizes.fontWeightMd)
                                          ),
                                          TextSpan(
                                              text: ' ${item!.creditedCurrency} // ${item!.debitedCurrency}',
                                              style: TextStyle(fontWeight: TSizes.fontWeightMd)
                                          )
                                        ]
                                    )
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
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
                          const SizedBox(height: TSizes.spaceBtwElements * 3),
                          RichText(
                              text: TextSpan(
                                  text: 'You are about to swap ',
                                  style: Theme.of(context).textTheme.labelMedium,
                                  children: <TextSpan> [
                                    TextSpan(
                                        text: ' ${THelperFunctions.moneyFormatter(THelperFunctions.getStringMultiplication(item!.negotiatorAmount.toString(), item!.negotiatorRate.toString()))} ${item!.creditedCurrency}',
                                        style: TextStyle(
                                            fontWeight: TSizes.fontWeightLg,
                                            color: Color(0xFFEA8484)
                                        )
                                    ),
                                    TextSpan(
                                        text: ' for '
                                    ),
                                    TextSpan(
                                        text: ' ${THelperFunctions.moneyFormatter(item!.negotiatorAmount.toString())} ${item!.debitedCurrency}',
                                        style: TextStyle(fontWeight: TSizes.fontWeightLg)
                                    ),
                                  ]
                              )
                          ),
                          const SizedBox(height: TSizes.spaceBtwSections * 0.3),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                            child: TElevatedButton(
                                onTap: offerController.isAcceptingRejectingOfferLoading.value ? null : (){
                              offerController.acceptingOrRejectingOffer(
                                  id: item!.id.toString(),
                                  currency: item!.debitedCurrency.toString(),
                                  negotiationAccepted: true,
                                  onSuccess: () => offerController.showAcceptOfferMsg.value = true
                              );
                            },
                                buttonText: 'Accept'),
                          ),
                          const SizedBox(height: TSizes.spaceBtwSections * 0.5 ),
                          Container(
                              width: double.infinity,
                              height: 48,
                              padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                              child: ElevatedButton(
                                onPressed: offerController.isAcceptingRejectingOfferLoading.value ? null : () {
                                  offerController.acceptingOrRejectingOffer(
                                      id: item!.id.toString(),
                                      currency: item!.debitedCurrency.toString(),
                                      negotiationAccepted: false,
                                      onSuccess: () => offerController.showRejectOfferMsg.value = false
                                  );
                                },
                                child: const Text(
                                  'Reject',
                                  style: TextStyle(color: Color(0xFFEA8484)),
                                ),
                              )
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else if (offerController.showAcceptOfferMsg.value) {
          return SuccessScreenWidget(
            onTap: () {Get.back();},
            text: 'You have successfully swapped ${THelperFunctions.moneyFormatter(THelperFunctions.getStringMultiplication(item!.amount.toString(), item!.negotiatorRate.toString()))} ${item!.creditedCurrency} for ${THelperFunctions.moneyFormatter(item!.amount.toString())} ${item!.debitedCurrency}.',
            child: TListLayout(
                itemCount: 3,
                itemBuilder: (_, index) => MyTimeLine(
                  isFirst: index == 0 ? true : false,
                  isLast: index == 2 ? true : false,
                  isDone: index == 2 ? false : true,
                  startChild: Container(
                    padding: const EdgeInsets.only(bottom: 17),
                    child: RichText(
                        text: TextSpan(
                            style: Theme.of(context).textTheme.labelSmall,
                            children: <TextSpan> [
                              TextSpan(
                                  text: THelperFunctions.getFormattedTime(DateTime.now().toString()),
                                  style: TextStyle(
                                    // color: TColors.textPrimary.withOpacity(0.6),
                                      height: 1.5
                                  )
                              ),
                            ]
                        )
                    ),
                  ),
                  endChild: Container(
                      padding: const EdgeInsets.only(bottom: 17),
                      child: Text(
                        index == 0
                            ? 'You accepted this offer'
                            : index == 1
                            ? 'We received your funds'
                            : 'Your ${THelperFunctions.moneyFormatter(item!.amount.toString())} ${item!.creditedCurrency} is on its way to you',
                        style: Theme.of(context).textTheme.labelMedium,)
                  ),
                )
            ),
          );
        } else {
          return SuccessScreenWidget(
            onTap: () {Get.back();},
            text: 'You have successfully rejected this offer.',
            child: SizedBox(height: 0,),
          );
        }
      })
    );
  }
}
