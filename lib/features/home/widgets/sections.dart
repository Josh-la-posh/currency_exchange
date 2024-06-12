import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:swappr/features/negotiation_offer/screen/negotiation_offer.dart';
import 'package:swappr/features/payment_method/screens/payment_options.dart';
import 'package:swappr/features/withdrawals/screens/withdrawal.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../all_offer/screens/all_offer.dart';
import '../../subscription/screens/subscribe.dart';
import '../../transaction/screens/history.dart';
import '../../wallet/screens/wallet.dart';

class LinkSectionWidget extends StatelessWidget {
  const LinkSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace * 2, vertical: TSizes.xs),
        decoration: BoxDecoration(
            color: TColors.secondaryBorder,
            boxShadow: [
              BoxShadow(
                  color: TColors.black.withOpacity(0.25),
                  offset: const Offset(0,4),
                  blurRadius: 4,
                  spreadRadius: 0
              ),
            ]
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: TSizes.sm),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const AllOfferScreen());
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40)
                        ),
                        child: const Image(image: AssetImage('assets/icons/homeIcons/all_offer.png')),
                      ),
                      const SizedBox(height: 7,),
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.labelSmall,
                              children: <TextSpan> [
                                TextSpan(
                                    text:'All Offer',
                                    style: TextStyle(fontWeight: TSizes.fontWeightMd, color: TColors.textPrimary.withOpacity(0.5))
                                ),
                              ]
                          )
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: TSizes.xl),
                GestureDetector(
                  onTap: () {
                    Get.to(() => PaymentOptionScreen());
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40)
                        ),
                        child: const Image(image: AssetImage('assets/icons/homeIcons/subscribe.png')),
                      ),
                      const SizedBox(height: 7,),
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.labelSmall,
                              children: <TextSpan> [
                                TextSpan(
                                    text:'Deposit',
                                    style: TextStyle(fontWeight: TSizes.fontWeightMd, color: TColors.textPrimary.withOpacity(0.5))
                                ),
                              ]
                          )
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: TSizes.sm),
                GestureDetector(
                  onTap: (){
                    Get.to(() => const WalletDashboardScreen());
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40)
                        ),
                        child: const Image(image: AssetImage('assets/icons/homeIcons/wallet.png')),
                      ),
                      const SizedBox(height: 7,),
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.labelSmall,
                              children: <TextSpan> [
                                TextSpan(
                                    text:'Wallet',
                                    style: TextStyle(fontWeight: TSizes.fontWeightMd, color: TColors.textPrimary.withOpacity(0.5))
                                ),
                              ]
                          )
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: TSizes.xl),
                GestureDetector(
                  onTap: () {
                    Get.to(() => WithdrawalScreen());
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40)
                        ),
                        child: const Image(image: AssetImage('assets/icons/homeIcons/subscribe.png')),
                      ),
                      const SizedBox(height: 7,),
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.labelSmall,
                              children: <TextSpan> [
                                TextSpan(
                                    text:'Withdraw',
                                    style: TextStyle(fontWeight: TSizes.fontWeightMd, color: TColors.textPrimary.withOpacity(0.5))
                                ),
                              ]
                          )
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: TSizes.sm),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const SubscribeScreen());
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40)
                        ),
                        child: const Image(image: AssetImage('assets/icons/homeIcons/subscribe.png')),
                      ),
                      const SizedBox(height: 7,),
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.labelSmall,
                              children: <TextSpan> [
                                TextSpan(
                                    text:'Subscribe',
                                    style: TextStyle(fontWeight: TSizes.fontWeightMd, color: TColors.textPrimary.withOpacity(0.5))
                                ),
                              ]
                          )
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: TSizes.xl),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const NegotiationOfferScreen());
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40)
                        ),
                        child: const Image(image: AssetImage('assets/icons/homeIcons/subscribe.png')),
                      ),
                      const SizedBox(height: 7,),
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              style: Theme.of(context).textTheme.labelSmall,
                              children: <TextSpan> [
                                TextSpan(
                                    text:'Negotiation \n offers',
                                    style: TextStyle(fontWeight: TSizes.fontWeightMd, color: TColors.textPrimary.withOpacity(0.5), height: 1.4)
                                ),
                              ]
                          )
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: TSizes.sm),
              ],
            )
          ],
        ),
      );
  }
}
