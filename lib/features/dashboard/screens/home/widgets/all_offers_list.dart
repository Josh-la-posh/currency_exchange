import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swappr/features/dashboard/screens/home/icons/svg.dart';
import 'package:swappr/features/dashboard/screens/home/offer_details.dart';

import '../../../../../common/widgets/divider.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class AllOffersListScreen extends StatelessWidget {
  const AllOffersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       ListTile(
         dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: TSizes.md),
            onTap: (){
              Get.to(() => const OfferDetailsScreen());
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
                            children: const <TextSpan> [
                              TextSpan(
                                  text: 'has: 20,000 NGN',
                                  style: TextStyle(fontSize: TSizes.fontSize13)
                              ),
                            ]
                        )
                    ),
                    SizedBox(height: TSizes.md,),
                    RichText(
                        text: TextSpan(
                            style: Theme.of(context).textTheme.labelMedium,
                            children: <TextSpan> [
                              TextSpan(
                                  text: 'needs: 95 GBP',
                                  style: TextStyle(
                                    fontSize: TSizes.fontSize13,
                                  )
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
                            children: const <TextSpan> [
                              TextSpan(
                                  text: '600 NGN // GBP',
                                  style: TextStyle(fontSize: TSizes.fontSize13, color: TColors.primary)
                              ),
                            ]
                        )
                    ),
                    SizedBox(height: TSizes.md,),
                    Row(
                      children: [
                        OfferEyeIcon(),
                        SizedBox(width: TSizes.md,),
                        RichText(
                            text: TextSpan(
                                style: Theme.of(context).textTheme.labelSmall,
                                children: <TextSpan> [
                                  TextSpan(
                                      text: '20',
                                      style: TextStyle(
                                        color: TColors.textPrimaryO80,
                                      )
                                  ),
                                ]
                            )
                        ),
                        SizedBox(width: TSizes.lg,),
                        RichText(
                            text: TextSpan(
                                style: Theme.of(context).textTheme.labelSmall,
                                children: <TextSpan> [
                                  TextSpan(
                                      text: '40 secs ago',
                                      style: TextStyle(
                                          color: TColors.textPrimary.withOpacity(0.5),
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
        const DividerWidget()
      ],
    );
  }
}
