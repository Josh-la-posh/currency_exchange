import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:swappr/common/styles/spacing_styles.dart';
import 'package:swappr/common/widgets/buttons/elevated_button.dart';
import 'package:swappr/common/widgets/custom_shapes/currency_widget_with_back.dart';
import 'package:swappr/common/widgets/divider.dart';
import 'package:swappr/data/provider/offer_provider.dart';
import 'package:swappr/features/home/apis/api.dart';
import 'package:swappr/features/home/icons/svg.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/constants/enums.dart';
import 'package:swappr/utils/constants/sizes.dart';
import 'package:swappr/utils/helpers/pricing_calculator.dart';

import '../../../utils/helpers/helper_functions.dart';
import '../apis/api.dart';

class CreateReviewDetailsScreen extends StatelessWidget {
  const CreateReviewDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    final offerDetail = Provider.of<OfferProvider>(context);
    final data = offerDetail.createOfferEntity;
    return Scaffold(
      body: Padding(
        padding: TSpacingStyle.homePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CurrencyWidgetWithBack(),
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
                                        text: '${data.amount} ${getCurrencyName(data.debitedCurrency)}',
                                        style: const TextStyle(fontWeight: TSizes.fontWeightLg)
                                    ),
                                    const TextSpan(
                                        text: ' for '
                                    ),
                                    TextSpan(
                                        text: '${(data.amount * data.rate)} ${getCurrencyName(data.creditedCurrency)}',
                                        style: const TextStyle(fontWeight: TSizes.fontWeightLg)
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
                    const SizedBox(height: TSizes.md),
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
                                            text: 'I have',
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
                                            text: '${data.amount} ${getCurrencyName(data.debitedCurrency)}',
                                            style: const TextStyle(fontSize: TSizes.fontSize13, fontWeight: TSizes.fontWeightMd)
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
                                            text: 'I need',
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
                                            text: getCurrencyName(data.creditedCurrency),
                                            style: const TextStyle(fontSize: TSizes.fontSize13, fontWeight: TSizes.fontWeightMd)
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
                              Row(
                                children: [
                                  RichText(
                                      text: TextSpan(
                                          style: Theme.of(context).textTheme.labelSmall,
                                          children: <TextSpan> [
                                            TextSpan(
                                                text: '${data.rate} ${getCurrencyName(data.debitedCurrency)}',
                                                style: const TextStyle(fontSize: TSizes.fontSize13, fontWeight: TSizes.fontWeightMd)
                                            )
                                          ]
                                      )
                                  ),
                                  const SizedBox(width: TSizes.sm,),
                                  AppoxIcon(),
                                  const SizedBox(width: TSizes.sm,),
                                  RichText(
                                      text: TextSpan(
                                          style: Theme.of(context).textTheme.labelSmall,
                                          children: <TextSpan> [
                                            TextSpan(
                                                text: '${data.rate * data.amount} ${getCurrencyName(data.creditedCurrency)}',
                                                style: const TextStyle(fontSize: TSizes.fontSize13, fontWeight: TSizes.fontWeightMd)
                                            )
                                          ]
                                      )
                                  ),
                                ],
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
                                            text: 'Expires in',
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
                                            text: '${data.expireIn} hour',
                                            // text: '${difference.inHours}h ${difference.inMinutes % 60}m hour',
                                            style: const TextStyle(fontSize: TSizes.fontSize13, fontWeight: TSizes.fontWeightMd)
                                        )
                                      ]
                                  )
                              ),
                            ],
                          ),
                        ),
                        const DividerWidget(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace / 2),
                          child: Column(
                            children: [
                              const SizedBox(height: TSizes.xs),
                              Container(
                                padding: const EdgeInsets.only(left: TSizes.defaultSpace / 2),
                                height: TSizes.textReviewHeight,
                                decoration: BoxDecoration(
                                    color: TColors.secondaryBorder30,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                        text: TextSpan(
                                            style: Theme.of(context).textTheme.labelMedium,
                                            children: <TextSpan> [
                                              TextSpan(
                                                  text: 'You will be debited from ',
                                                  style: TextStyle(
                                                    fontSize: TSizes.fontSize13,
                                                    color: darkMode ? TColors.white : TColors.primary
                                                  )
                                              ),
                                              TextSpan(
                                                  text: ' ${getCurrencyName(data.debitedCurrency)} ',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w700,
                                                      color: darkMode ? TColors.white : TColors.primary
                                                  )
                                              ),
                                              TextSpan(
                                                  text: ' wallet',
                                                  style: TextStyle(
                                                      fontSize: TSizes.fontSize13,
                                                      color: darkMode ? TColors.white : TColors.primary
                                                  )
                                              )
                                            ]
                                        )
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: TSizes.defaultSpace,),
                              Container(
                                padding: const EdgeInsets.only(left: TSizes.defaultSpace / 2),
                                height: TSizes.textReviewHeight,
                                decoration: BoxDecoration(
                                    color: TColors.secondaryBorder30,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                        text: TextSpan(
                                            style: Theme.of(context).textTheme.labelMedium,
                                            children: <TextSpan> [
                                              TextSpan(
                                                  text: 'You will be credited to ',
                                                  style: TextStyle(
                                                      fontSize: TSizes.fontSize13,
                                                      color: darkMode ? TColors.white : TColors.primary
                                                  )
                                              ),
                                              TextSpan(
                                                  text: ' ${getCurrencyName(data.creditedCurrency)} ',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w700,
                                                      color: darkMode ? TColors.white : TColors.primary
                                                  )
                                              ),
                                              TextSpan(
                                                  text: ' wallet',
                                                  style: TextStyle(
                                                      fontSize: TSizes.fontSize13,
                                                      color: darkMode ? TColors.white : TColors.primary
                                                  )
                                              )
                                            ]
                                        )
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: TSizes.xs),
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
                                      children: <TextSpan> [
                                        TextSpan(
                                            text: '${TPriceCalculator.calculateFee(getCurrencyName(data.debitedCurrency))} ${getCurrencyName(data.debitedCurrency)}',
                                            style: const TextStyle(fontSize: TSizes.fontSize13, fontWeight: TSizes.fontWeightMd)
                                        )
                                      ]
                                  )
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: TSizes.spaceBtwSections),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                          child: TElevatedButton(
                              onTap: (){
                                OfferService.instance
                                    .createOffer(
                                    offerProvider: offerDetail,
                                    debitedCurrency: getCurrencyName(data.debitedCurrency),
                                    creditedCurrency: getCurrencyName(data.creditedCurrency),
                                    amount: data.amount,
                                    rate: data.rate,
                                    expireIn: data.expireIn
                                );
                              },
                              buttonText: 'Pay ${TPriceCalculator.calculateTotalPrice('${data.amount * data.rate}', getCurrencyName(data.debitedCurrency))} ${getCurrencyName(data.debitedCurrency)}'),
                        ),
                        const SizedBox(height: TSizes.spaceBtwElements),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            NotiIcon(height: 15),
                            const SizedBox(width: TSizes.sm),
                            RichText(
                                text: TextSpan(
                                    style: Theme.of(context).textTheme.labelSmall,
                                    children: const <TextSpan> [
                                      TextSpan(
                                          text: 'You will be fully refunded if your offer is not matched in 1hour',
                                          style: TextStyle(fontSize: TSizes.fontSize11)
                                      )
                                    ]
                                )
                            ),
                          ],
                        ),
                        const SizedBox(width: TSizes.defaultSpace),
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
