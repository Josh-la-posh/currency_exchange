import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:swappr/common/styles/spacing_styles.dart';
import 'package:swappr/common/widgets/buttons/elevated_button.dart';
import 'package:swappr/common/widgets/currencyWidget.dart';
import 'package:swappr/common/widgets/custom_shapes/currency_widget_with_back.dart';
import 'package:swappr/common/widgets/divider.dart';
import 'package:swappr/features/dashboard/screens/home/icons/svg.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/constants/sizes.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';

class CreateReviewDetailsScreen extends StatelessWidget {
  const CreateReviewDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                                  children: const <TextSpan> [
                                    TextSpan(
                                        text: '100  ',
                                        style: TextStyle(fontWeight: TSizes.fontWeightLg)
                                    ),
                                    TextSpan(
                                        text: 'for '
                                    ),
                                    TextSpan(
                                        text: '40,000 NGN.',
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
                                        children: const <TextSpan> [
                                          TextSpan(
                                              text: '100 GBP',
                                              style: TextStyle(fontSize: TSizes.fontSize13, fontWeight: TSizes.fontWeightMd)
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
                                        children: const <TextSpan> [
                                          TextSpan(
                                              text: '45,000 NGN',
                                              style: TextStyle(fontSize: TSizes.fontSize13, fontWeight: TSizes.fontWeightMd)
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
                                              text: 'Preferred Rate',
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
                                            children: const <TextSpan> [
                                              TextSpan(
                                                  text: '400 GBP',
                                                  style: TextStyle(fontSize: TSizes.fontSize13, fontWeight: TSizes.fontWeightMd)
                                              )
                                            ]
                                        )
                                    ),
                                    SizedBox(width: TSizes.sm,),
                                    AppoxIcon(),
                                    SizedBox(width: TSizes.sm,),
                                    RichText(
                                        text: TextSpan(
                                            style: Theme.of(context).textTheme.labelSmall,
                                            children: const <TextSpan> [
                                              TextSpan(
                                                  text: '40,000 NGN',
                                                  style: TextStyle(fontSize: TSizes.fontSize13, fontWeight: TSizes.fontWeightMd)
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
                          SizedBox(
                            height: TSizes.textReviewHeight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                    text: TextSpan(
                                        style: Theme.of(context).textTheme.labelMedium,
                                        children: const <TextSpan> [
                                          TextSpan(
                                              text: 'Minimum Rate',
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
                                            children: const <TextSpan> [
                                              TextSpan(
                                                  text: '300 GBP',
                                                  style: TextStyle(fontSize: TSizes.fontSize13, fontWeight: TSizes.fontWeightMd)
                                              )
                                            ]
                                        )
                                    ),
                                    SizedBox(width: TSizes.sm,),
                                    AppoxIcon(),
                                    SizedBox(width: TSizes.sm,),
                                    RichText(
                                        text: TextSpan(
                                            style: Theme.of(context).textTheme.labelSmall,
                                            children: const <TextSpan> [
                                              TextSpan(
                                                  text: '30,000 NGN',
                                                  style: TextStyle(fontSize: TSizes.fontSize13, fontWeight: TSizes.fontWeightMd)
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
                                        children: const <TextSpan> [
                                          TextSpan(
                                              text: '1 hour',
                                              style: TextStyle(fontSize: TSizes.fontSize13, fontWeight: TSizes.fontWeightMd)
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
                                              text: 'You will be debited from',
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
                                        children: const <TextSpan> [
                                          TextSpan(
                                              text: 'You will be credited to',
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
                          const SizedBox(height: TSizes.spaceBtwSections),
                          TElevatedButton(onTap: (){}, buttonText: 'Pay 100 GBP'),
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
