import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pouch/utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/offer_controller.dart';
import 'cad_market_list.dart';
import 'cad_new_market_list.dart';
import 'cad_trending_market_list.dart';

class CadMarketScreen extends StatelessWidget {
  final OfferController offerController = Get.put(OfferController());

  Widget _buildTab({
    required String title,
    required int index,
    required bool darkMode,
  }) {
    final isSelected = offerController.cadOfferIndex.value == index;
    return GestureDetector(
      onTap: () => offerController.cadOfferIndex.value = index,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        decoration: BoxDecoration(
          color: darkMode
              ? isSelected
              ? TColors.textPrimary
              : TColors.textPrimary.withOpacity(0)
              : isSelected
              ? const Color(0xFFEEEEEE)
              : Colors.white.withOpacity(0),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          title,
          style: const TextStyle(
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
    if (offerController.allCadOffers.isEmpty) {
      offerController.fetchOffersByCurrency(currency: 'CAD');
    }
    final darkMode = THelperFunctions.isDarkMode(context);
    final screenHeight = THelperFunctions.screenHeight();

    return Container(
      height: screenHeight - kBottomNavigationBarHeight - 70,
      child: Obx(() => Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 9),
            child: Row(
              children: [
                _buildTab(title: 'All', index: 0, darkMode: darkMode),
                _buildTab(title: 'New', index: 1, darkMode: darkMode),
                _buildTab(title: 'Trending', index: 2, darkMode: darkMode),
              ],
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: offerController.cadOfferIndex.value,
              children: [
                CadMarketList(),
                CadNewMarketList(),
                CadTrendingMarketList(),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
