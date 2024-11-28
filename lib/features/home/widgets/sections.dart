import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
import '../../subscription/screens/subscribe.dart';

class LinkSectionWidget extends StatelessWidget {
  final bool darkMode;
  LinkSectionWidget({super.key, required this.darkMode});

  @override
  Widget build(BuildContext context) {
    final NavigationController controller = Get.find();
    final width = MediaQuery.of(context).size.width;
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
                            Get.to(() => PaymentOptionScreen());
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
                          Get.to(() => MyBidAndOfferScreen());
                        },
                        icon: Icon(Icons.credit_card, size: 30, color: TColors.primary,),
                        darkMode: darkMode,
                        title: 'My offers',
                        image: TImages.walletIcon
                    ),
                    const SizedBox(height: TSizes.xl),
                    SectionWidgetContainer(
                        onTap: () {
                          Get.to(() => WithdrawalScreen());
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
                        Get.to(() => SubscribeScreen());
                      },
                      icon: Icon(Icons.unsubscribe_outlined, size: 30, color: TColors.primary,),
                      darkMode: darkMode,
                      title: 'Subscribe',
                      image: TImages.subscribeIcon
                  ),
                  const SizedBox(height: TSizes.xl),
                  SectionWidgetContainer(
                      onTap: () {
                        Get.to(() => NegotiationOfferScreen());
                      },
                      icon: Icon(Iconsax.calculator5, size: 30, color: TColors.primary,),
                      darkMode: darkMode,
                      title: 'Offers In Review',
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
