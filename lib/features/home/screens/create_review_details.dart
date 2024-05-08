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

class CreateReviewDetailsScreen extends StatelessWidget {
  const CreateReviewDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final offerDetail = Provider.of<OfferProvider>(context);
    final data = offerDetail.createOfferEntity;
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
                      width: double.infinity,
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
                    const SizedBox(height: TSizes.md),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                      child: Column(
                        children: [
                          SizedBox(
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
                          SizedBox(
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
                          SizedBox(
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
                                                  text: '${data.rate + data.amount} ${getCurrencyName(data.creditedCurrency)}',
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
                          // SizedBox(
                          //   height: TSizes.textReviewHeight,
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       RichText(
                          //           text: TextSpan(
                          //               style: Theme.of(context).textTheme.labelMedium,
                          //               children: const <TextSpan> [
                          //                 TextSpan(
                          //                     text: 'Minimum Rate',
                          //                     style: TextStyle(fontSize: TSizes.fontSize13)
                          //                 )
                          //               ]
                          //           )
                          //       ),
                          //       Row(
                          //         children: [
                          //           RichText(
                          //               text: TextSpan(
                          //                   style: Theme.of(context).textTheme.labelSmall,
                          //                   children: <TextSpan> [
                          //                     TextSpan(
                          //                         text: '${data.minimumRate} ${data.selectedCurrency}',
                          //                         style: const TextStyle(fontSize: TSizes.fontSize13, fontWeight: TSizes.fontWeightMd)
                          //                     )
                          //                   ]
                          //               )
                          //           ),
                          //           const SizedBox(width: TSizes.sm,),
                          //           AppoxIcon(),
                          //           const SizedBox(width: TSizes.sm,),
                          //           RichText(
                          //               text: TextSpan(
                          //                   style: Theme.of(context).textTheme.labelSmall,
                          //                   children: <TextSpan> [
                          //                     TextSpan(
                          //                         text: '${THelperFunctions.getStringMultiplication(data.minimumRate, data.hasAmount)} ${data.neededCurrency}',
                          //                         style: const TextStyle(fontSize: TSizes.fontSize13, fontWeight: TSizes.fontWeightMd)
                          //                     )
                          //                   ]
                          //               )
                          //           ),
                          //         ],
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // const DividerWidget(),
                          SizedBox(
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
                          SizedBox(
                            height: TSizes.textReviewHeight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                    text: TextSpan(
                                        style: Theme.of(context).textTheme.labelSmall,
                                        children: <TextSpan> [
                                          TextSpan(
                                              text: 'You will be debited from ${getCurrencyName(data.debitedCurrency)} wallet',
                                              style: TextStyle(fontSize: TSizes.fontSize13)
                                          )
                                        ]
                                    )
                                ),
                              ],
                            ),
                          ),
                          const DividerWidget(),
                          SizedBox(
                            height: TSizes.textReviewHeight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                    text: TextSpan(
                                        style: Theme.of(context).textTheme.labelSmall,
                                        children: <TextSpan> [
                                          TextSpan(
                                              text: 'You will be credited to ${getCurrencyName(data.creditedCurrency)} wallet',
                                              style: TextStyle(fontSize: TSizes.fontSize13)
                                          )
                                        ]
                                    )
                                ),
                              ],
                            ),
                          ),
                          const DividerWidget(),
                          SizedBox(
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
                          TElevatedButton(
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
                              buttonText: 'Pay ${TPriceCalculator.calculateTotalPrice('${data.amount}', getCurrencyName(data.debitedCurrency))} ${getCurrencyName(data.debitedCurrency)}'),
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
