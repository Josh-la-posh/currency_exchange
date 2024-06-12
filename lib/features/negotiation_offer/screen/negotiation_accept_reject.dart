import 'package:flutter/material.dart';

import '../../../common/styles/spacing_styles.dart';
import '../../../common/widgets/buttons/elevated_button.dart';
import '../../../common/widgets/custom_shapes/currency_widget_with_back.dart';
import '../../../common/widgets/divider.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../all_offer/icons/svg.dart';

class NegotiationAcceptRejectScreen extends StatelessWidget {
  const NegotiationAcceptRejectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.defaultSpace),
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
                                    text: 'Offer Details',
                                    style: TextStyle(fontSize: TSizes.fontSize13, fontWeight: TSizes.fontWeightMd)
                                )
                              ]
                          )
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwElements ),
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
                                      children: const <TextSpan> [
                                        TextSpan(
                                            text: '2,000',
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
                                      children: const <TextSpan> [
                                        TextSpan(
                                            text: 'GBP',
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
                                      children: const <TextSpan> [
                                        TextSpan(
                                            text: 'NGN // GBP',
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
                        const SizedBox(height: TSizes.spaceBtwElements * 3),
                        RichText(
                            text: TextSpan(
                                text: 'You are about to swap ',
                                style: Theme.of(context).textTheme.labelMedium,
                                children: const <TextSpan> [
                                  TextSpan(
                                      text: ' 57,000 NGN',
                                      style: TextStyle(
                                          fontWeight: TSizes.fontWeightLg,
                                          color: Color(0xFFEA8484)
                                      )
                                  ),
                                  TextSpan(
                                      text: ' for '
                                  ),
                                  TextSpan(
                                      text: ' 95 GBP',
                                      style: TextStyle(fontWeight: TSizes.fontWeightLg)
                                  ),
                                ]
                            )
                        ),
                        const SizedBox(height: TSizes.spaceBtwSections),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                          child: TElevatedButton(onTap: (){

                          },
                              buttonText: 'Accept'),
                        ),
                        const SizedBox(height: TSizes.spaceBtwSections ),
                        Container(
                          width: double.infinity,
                          height: 48,
                          padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                          child: ElevatedButton(
                            onPressed: () {},
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
        ),
      ),
    );
  }
}
