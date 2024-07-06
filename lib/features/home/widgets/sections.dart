import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:swappr/features/home/widgets/section_widget.dart';
import 'package:swappr/features/negotiation_offer/screen/negotiation_offer.dart';
import 'package:swappr/features/payment_method/screens/payment_options.dart';
import 'package:swappr/features/withdrawals/screens/withdrawal.dart';
import 'package:swappr/utils/constants/image_strings.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../all_offer/screens/all_offer.dart';
import '../../subscription/screens/subscribe.dart';
import '../../transaction/screens/history.dart';
import '../../wallet/screens/wallet.dart';

class LinkSectionWidget extends StatelessWidget {
  final bool darkMode;
  const LinkSectionWidget({super.key, required this.darkMode});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace * 2, vertical: TSizes.xs),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: TSizes.sm),
                SectionWidgetContainer(
                    onTap: () {
                      Get.to(() => const AllOfferScreen());
                    },
                    darkMode: darkMode,
                    title: 'All Offer',
                    image: TImages.allOfferIcon
                ),
                const SizedBox(height: TSizes.xl),
                SectionWidgetContainer(
                    onTap: () {
                      Get.to(() => const PaymentOptionScreen());
                    },
                    darkMode: darkMode,
                    title: 'Deposit',
                    image: TImages.depositIcon
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: TSizes.sm),
                SectionWidgetContainer(
                    onTap: () {
                      Get.to(() => const WalletDashboardScreen());
                    },
                    darkMode: darkMode,
                    title: 'Wallet',
                    image: TImages.walletIcon
                ),
                const SizedBox(height: TSizes.xl),
                SectionWidgetContainer(
                    onTap: () {
                      Get.to(() => const WithdrawalScreen());
                    },
                    darkMode: darkMode,
                    title: 'Withdraw',
                    image: TImages.withdrawHomeIcon
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: TSizes.sm),
                SectionWidgetContainer(
                    onTap: () {
                      Get.to(() => const SubscribeScreen());
                    },
                    darkMode: darkMode,
                    title: 'Subscribe',
                    image: TImages.subscribeIcon
                ),
                const SizedBox(height: TSizes.xl),
                SectionWidgetContainer(
                    onTap: () {
                      Get.to(() => const NegotiationOfferScreen());
                    },
                    darkMode: darkMode,
                    title: 'Negotiation \n Offers',
                    image: TImages.negotiationOfferIcon
                ),
              ],
            ),
          ],
        ),
      );
  }
}
