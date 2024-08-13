import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pouch/features/home/widgets/section_widget.dart';
import 'package:pouch/features/negotiation_offer/screen/bid_and_offer.dart';
import 'package:pouch/features/negotiation_offer/screen/negotiation_offer.dart';
import 'package:pouch/features/payment_method/screens/payment_options.dart';
import 'package:pouch/features/withdrawals/screens/withdrawal.dart';
import 'package:pouch/utils/constants/image_strings.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/layouts/navigation_menu.dart';
import '../../all_offer/screens/all_offer.dart';
import '../../subscription/screens/subscribe.dart';
import '../../transaction/screens/history.dart';
import '../../wallet/screens/wallet.dart';

class LinkSectionWidget extends StatelessWidget {
  final bool darkMode;
  const LinkSectionWidget({super.key, required this.darkMode});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final controller = Get.put(NavigationController());
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: TSizes.sm),
                      SectionWidgetContainer(
                          onTap: () {
                            controller.selectedIndex.value = 1;
                          },
                          icon: Icon(Icons.card_giftcard, size: 30, color: TColors.primary,),
                          darkMode: darkMode,
                          title: 'All Offers',
                          image: TImages.allOfferIcon
                      ),
                      const SizedBox(height: TSizes.xl),
                      SectionWidgetContainer(
                          onTap: () {
                            Get.to(() => const PaymentOptionScreen());
                          },
                          icon: Icon(Icons.payments_outlined, size: 30, color: TColors.primary,),
                          darkMode: darkMode,
                          title: 'Deposit',
                          image: TImages.depositIcon
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                width: (width - TSizes.defaultSpace * 2) / 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: TSizes.sm),
                    SectionWidgetContainer(
                        onTap: () {
                          Get.to(() => const MyBidAndOfferScreen());
                        },
                        icon: Icon(Icons.credit_card, size: 30, color: TColors.primary,),
                        darkMode: darkMode,
                        title: 'My offers',
                        image: TImages.walletIcon
                    ),
                    const SizedBox(height: TSizes.xl),
                    SectionWidgetContainer(
                        onTap: () {
                          Get.to(() => const WithdrawalScreen());
                        },
                        icon: Icon(Icons.credit_score_outlined, size: 30, color: TColors.primary,),
                        darkMode: darkMode,
                        title: 'Withdraw',
                        image: TImages.withdrawHomeIcon
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: TSizes.sm),
                  SectionWidgetContainer(
                      onTap: () {
                        Get.to(() => const SubscribeScreen());
                      },
                      icon: Icon(Icons.unsubscribe_outlined, size: 30, color: TColors.primary,),
                      darkMode: darkMode,
                      title: 'Subscribe',
                      image: TImages.subscribeIcon
                  ),
                  const SizedBox(height: TSizes.xl),
                  SectionWidgetContainer(
                      onTap: () {
                        Get.to(() => const NegotiationOfferScreen());
                      },
                      icon: Icon(Iconsax.calculator5, size: 30, color: TColors.primary,),
                      darkMode: darkMode,
                      title: 'Offers Review',
                      image: TImages.negotiationOfferIcon
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  }
}
