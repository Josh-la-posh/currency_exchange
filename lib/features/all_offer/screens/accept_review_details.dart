import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:swappr/common/styles/spacing_styles.dart';
import 'package:swappr/common/widgets/buttons/elevated_button.dart';
import 'package:swappr/common/widgets/custom_shapes/currency_widget_with_back.dart';
import 'package:swappr/common/widgets/divider.dart';
import 'package:swappr/data/provider/offer_provider.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/constants/sizes.dart';
import '../apis/api.dart';
import '../icons/svg.dart';
import '../models/offer.dart';

class AcceptReviewDetailsScreen extends StatelessWidget {
  final OfferEntity? item;
  const AcceptReviewDetailsScreen({
    super.key,
    this.item,
  });

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<OfferProvider>(context);
    return Scaffold(
      body: Padding(
        padding: TSpacingStyle.homePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CurrencyWidgetWithBack(),
            const SizedBox(height: TSizes.spaceBtwSections / 2,),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: TSizes.spaceBtwSections / 2,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Review Details', style: Theme.of(context).textTheme.titleMedium,),
                          const SizedBox(height: TSizes.spaceBtwSections,),
                          RichText(
                              text: TextSpan(
                                  text: 'You are about to swap ',
                                  style: Theme.of(context).textTheme.labelMedium,
                                  children: <TextSpan> [
                                    TextSpan(
                                        text: '${item?.amount} ',
                                        style: TextStyle(
                                            fontWeight: TSizes.fontWeightLg,
                                            color: TColors.golden
                                        )
                                    ),
                                    TextSpan(
                                        text: ' ${item?.debitedCurrency} ',
                                        style: TextStyle(fontWeight: TSizes.fontWeightLg)
                                    ),
                                    TextSpan(
                                        text: 'for '
                                    ),
                                    TextSpan(
                                        text: '${item?.creditedCurrency}',
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
                              children: const <TextSpan> [
                                TextSpan(
                                    text: 'Offer Summary',
                                    style: TextStyle(fontSize: TSizes.fontSize13, fontWeight: TSizes.fontWeightMd)
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
                                            style: TextStyle(fontSize: TSizes.fontSize13)
                                        )
                                      ]
                                  )
                              ),
                              RichText(
                                  text: TextSpan(
                                      style: Theme.of(context).textTheme.labelSmall,
                                      children: <TextSpan> [
                                        TextSpan(
                                            text: '${item?.amount} ${item?.debitedCurrency}',
                                            style: TextStyle(fontSize: TSizes.fontSize13, fontWeight: TSizes.fontWeightMd)
                                        )
                                      ]
                                  )
                              ),
                            ],
                          ),
                        ),
                        const DividerWidget(),
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
                                            style: TextStyle(fontSize: TSizes.fontSize13)
                                        )
                                      ]
                                  )
                              ),
                              RichText(
                                  text: TextSpan(
                                      style: Theme.of(context).textTheme.labelSmall,
                                      children: <TextSpan> [
                                        TextSpan(
                                            text: '${item?.creditedCurrency}',
                                            style: TextStyle(fontSize: TSizes.fontSize13, fontWeight: TSizes.fontWeightMd)
                                        )
                                      ]
                                  )
                              ),
                            ],
                          ),
                        ),
                        const DividerWidget(),
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
                                            style: TextStyle(fontSize: TSizes.fontSize13)
                                        )
                                      ]
                                  )
                              ),
                              RichText(
                                  text: TextSpan(
                                      style: Theme.of(context).textTheme.labelSmall,
                                      children: <TextSpan> [
                                        TextSpan(
                                            text: '${item?.rate} ${item?.debitedCurrency} // ${item?.creditedCurrency}',
                                            style: TextStyle(color: TColors.primary)
                                        )
                                      ]
                                  )
                              ),
                            ],
                          ),
                        ),
                        const DividerWidget(),
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
                        const DividerWidget(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace/2),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace / 2, vertical: TSizes.md),
                                height: TSizes.textReviewHeight,
                                decoration: BoxDecoration(
                                  color: TColors.secondaryBorder30,
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
                                    )
                                    // RichText(
                                    //     text: TextSpan(
                                    //         style: Theme.of(context).textTheme.labelSmall,
                                    //         children:  <TextSpan> [
                                    //           TextSpan(
                                    //               text: ,
                                    //               style: TextStyle(fontSize: TSizes.fontSize13)
                                    //           )
                                    //         ]
                                    //     )
                                    // ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: TSizes.lg ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace / 2, vertical: TSizes.md),
                                height: TSizes.textReviewHeight,
                                decoration: BoxDecoration(
                                    color: TColors.secondaryBorder30,
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
                                    ),
                                    RichText(
                                        text: TextSpan(
                                            style: Theme.of(context).textTheme.labelMedium,
                                            children:  <TextSpan> [
                                              TextSpan(
                                                  text: item?.amount,
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
                          child: TElevatedButton(onTap: (){
                            OfferService.instance.swapOffer(id: item!.id, offerProvider: provider);
                            },
                              buttonText: 'Pay ${item?.amount} ${item?.debitedCurrency}'),
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
      ),
    );
  }
}
