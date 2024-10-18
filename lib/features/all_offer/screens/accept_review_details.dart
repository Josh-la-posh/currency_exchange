import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/all_offer/controllers/offer_controller.dart';
import 'package:pouch/common/widgets/buttons/elevated_button.dart';
import 'package:pouch/utils/constants/colors.dart';
import 'package:pouch/utils/constants/sizes.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import '../../../common/widgets/currencyWidget.dart';
import '../icons/svg.dart';
import '../models/offer.dart';

class AcceptReviewDetailsScreen extends StatelessWidget {
  final OfferEntity? item;
  AcceptReviewDetailsScreen({
    super.key,
    this.item,
  });
  @override
  Widget build(BuildContext context) {
    OfferController offerController = Get.find();
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: darkMode ? TColors.textPrimaryO40 : Colors.white,
      appBar: AppBar(
        backgroundColor: darkMode ? TColors.textPrimary.withOpacity(0) : Colors.white,
        surfaceTintColor: darkMode ? TColors.textPrimary.withOpacity(0) : Colors.white,
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
          style: IconButton.styleFrom(
              foregroundColor: Colors.grey,
              iconSize: TSizes.iconBackSize
          ),
          hoverColor: Colors.transparent,
        ),
        title: Text(
            'Review Details',
            style: Theme.of(context).textTheme.titleMedium
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CurrencyWidget(),
          const SizedBox(height: TSizes.spaceBtwSections / 2,),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(
                                text: 'You\'re swapping ',
                                style: Theme.of(context).textTheme.labelMedium,
                                children: <TextSpan> [
                                  TextSpan(
                                      text: '${THelperFunctions.moneyFormatter(THelperFunctions.getStringMultiplication(item!.amount.toString(), item!.rate.toString()))} ${item?.creditedCurrency} ',
                                      style: TextStyle(
                                          fontWeight: TSizes.fontWeightLg,
                                          color: TColors.golden
                                      )
                                  ),
                                  TextSpan(
                                      text: 'for '
                                  ),
                                  TextSpan(
                                      text: '${THelperFunctions.moneyFormatter(item!.amount.toString())} ${item?.debitedCurrency}',
                                      style: TextStyle(fontWeight: TSizes.fontWeightLg)
                                  ),
                                ]
                            )
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwElements * 2,),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    height: 48,
                    color: TColors.primaryBackground,
                    padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                    child: RichText(
                        text: TextSpan(
                            style: Theme.of(context).textTheme.labelSmall,
                            children: <TextSpan> [
                              TextSpan(
                                  text: 'Offer Summary',
                                  style: TextStyle(
                                      fontSize: TSizes.fontSize13,
                                      fontWeight: TSizes.fontWeightMd,
                                      color: TColors.textPrimaryO80
                                  )
                              )
                            ]
                        )
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                        height: TSizes.textReviewHeight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                                text: TextSpan(
                                    style: Theme.of(context).textTheme.labelSmall,
                                    children: const <TextSpan> [
                                      TextSpan(
                                          text: 'has',
                                          style: TextStyle(fontSize: TSizes.fontSize14)
                                      )
                                    ]
                                )
                            ),
                            RichText(
                                text: TextSpan(
                                    style: Theme.of(context).textTheme.labelMedium,
                                    children: <TextSpan> [
                                      TextSpan(
                                          text: '${THelperFunctions.moneyFormatter(item!.amount.toString())} ${item?.debitedCurrency}',
                                          style: TextStyle(fontWeight: TSizes.fontWeightMd)
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
                                    style: Theme.of(context).textTheme.labelSmall,
                                    children: const <TextSpan> [
                                      TextSpan(
                                          text: 'needs',
                                          style: TextStyle(fontSize: TSizes.fontSize14)
                                      )
                                    ]
                                )
                            ),
                            RichText(
                                text: TextSpan(
                                    style: Theme.of(context).textTheme.labelMedium,
                                    children: <TextSpan> [
                                      TextSpan(
                                          text: '${item?.creditedCurrency}',
                                          style: TextStyle(fontWeight: TSizes.fontWeightMd)
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
                                    style: Theme.of(context).textTheme.labelSmall,
                                    children: const <TextSpan> [
                                      TextSpan(
                                          text: 'Rate',
                                          style: TextStyle(fontSize: TSizes.fontSize14)
                                      )
                                    ]
                                )
                            ),
                            RichText(
                                text: TextSpan(
                                    style: Theme.of(context).textTheme.labelMedium,
                                    children: <TextSpan> [
                                      TextSpan(
                                          text: '${THelperFunctions.formatRate(item!.rate.toString())} ${item?.creditedCurrency} // ${item?.debitedCurrency}',
                                          style: TextStyle(fontSize: TSizes.fontSize13, color: TColors.primary)
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
                            Row(
                              children: [
                                RichText(
                                    text: TextSpan(
                                        style: Theme.of(context).textTheme.labelSmall,
                                        children: const <TextSpan> [
                                          TextSpan(
                                              text: 'Fee',
                                              style: TextStyle(fontSize: TSizes.fontSize14)
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
                                    style: Theme.of(context).textTheme.labelMedium,
                                    children: const <TextSpan> [
                                      TextSpan(
                                          text: '5 GBP',
                                          style: TextStyle(fontWeight: TSizes.fontWeightMd)
                                      )
                                    ]
                                )
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace/2),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace / 2, vertical: TSizes.md),
                              height: TSizes.textReviewHeight,
                              decoration: BoxDecoration(
                                color: darkMode ? TColors.grey : TColors.secondaryBorder30,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      RichText(
                                          text: TextSpan(
                                              style: Theme.of(context).textTheme.bodySmall,
                                              children:  <TextSpan> [
                                                TextSpan(
                                                    text: 'You Send',
                                                    style: TextStyle(
                                                      color: TColors.primary,
                                                      fontWeight: TSizes.fontWeightNm
                                                    )
                                                )
                                              ]
                                          )
                                      ),
                                      Row(
                                        children: [
                                          CurrencyIcon(),
                                          SizedBox(width: TSizes.xs,),
                                          RichText(
                                              text: TextSpan(
                                                  style: Theme.of(context).textTheme.labelMedium,
                                                  children:  <TextSpan> [
                                                    TextSpan(
                                                        text: item?.creditedCurrency,
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.w800,
                                                          color: TColors.primary
                                                        )
                                                    )
                                                  ]
                                              )
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: TSizes.lg ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace / 2, vertical: TSizes.md),
                              height: TSizes.textReviewHeight,
                              decoration: BoxDecoration(
                                  color: darkMode ? TColors.grey : TColors.secondaryBorder30,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      RichText(
                                          text: TextSpan(
                                              style: Theme.of(context).textTheme.bodySmall,
                                              children:  <TextSpan> [
                                                TextSpan(
                                                    text: 'You Get',
                                                    style: TextStyle(
                                                        color: TColors.primary,
                                                        fontWeight: TSizes.fontWeightNm
                                                    )
                                                )
                                              ]
                                          )
                                      ),
                                      Row(
                                        children: [
                                          CurrencyIcon(),
                                          SizedBox(width: TSizes.xs,),
                                          RichText(
                                              text: TextSpan(
                                                  style: Theme.of(context).textTheme.labelMedium,
                                                  children:  <TextSpan> [
                                                    TextSpan(
                                                        text: item?.debitedCurrency,
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.w800,
                                                            color: TColors.primary
                                                        )
                                                    )
                                                  ]
                                              )
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  RichText(
                                      text: TextSpan(
                                          style: Theme.of(context).textTheme.labelMedium,
                                          children:  <TextSpan> [
                                            TextSpan(
                                                text: THelperFunctions.moneyFormatter(item!.amount.toString()),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                    color: TColors.primary
                                                )
                                            )
                                          ]
                                      )
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                        child: Obx(() => TElevatedButton(onTap: offerController.isSwappingLoading.value ? null : (){
                          offerController.swappingOffer(
                              id: item!.id.toString(),
                              amount: item!.amount.toString(),
                              creditedCurrency: item!.debitedCurrency.toString());
                        },
                            buttonText: offerController.isSwappingLoading.value
                                ? 'Loading ...'
                                : 'Pay ${THelperFunctions.moneyFormatter(THelperFunctions.getStringMultiplication(item!.amount.toString(), item!.rate.toString()))} ${item?.creditedCurrency}'
                        )),
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
