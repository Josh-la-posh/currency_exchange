import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/all_offer/controllers/offer_controller.dart';
import 'package:pouch/utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import 'all_market_list.dart';
import 'all_new_market_list.dart';
import 'all_trending_market_list.dart';

class AllMarketScreen extends StatelessWidget {
  final offerController = Get.find<OfferController>();

  Widget _buildTab({
    required String label,
    required int index,
    required bool darkMode,
  }) {
    final isSelected = offerController.allOfferIndex.value == index;
    final backgroundColor = darkMode
        ? isSelected ? TColors.textPrimary : Colors.transparent
        : isSelected ? Color(0xFFEEEEEE) : Colors.transparent;

    return GestureDetector(
      onTap: () => offerController.allOfferIndex.value = index,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: TSizes.fontWeightMd,
            fontFamily: TTexts.fontFamily,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    final double availableHeight =
        THelperFunctions.screenHeight() - kBottomNavigationBarHeight - 70;

    return Container(
      height: availableHeight,
      margin: const EdgeInsets.only(top: 9),
      child: Obx(() => Column(
        children: [
          Row(
            children: [
              _buildTab(label: 'All', index: 0, darkMode: darkMode),
              _buildTab(label: 'New', index: 1, darkMode: darkMode),
              _buildTab(label: 'Trending', index: 2, darkMode: darkMode),
            ],
          ),
          Expanded(
            child: IndexedStack(
              index: offerController.allOfferIndex.value,
              children: [
                AllMarketList(),
                AllNewMarketList(),
                AllTrendingMarketList(),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
