import 'package:flutter/material.dart';
import 'package:pouch/utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import 'eur_market_list.dart';
import 'eur_new_market_list.dart';
import 'eur_trending_market_list.dart';

class EurMarketScreen extends StatefulWidget {
  const EurMarketScreen({super.key});

  @override
  State<EurMarketScreen> createState() => _EurMarketScreenState();
}

class _EurMarketScreenState extends State<EurMarketScreen> {
  int selectedIndex = 1;

  void handleSelectedIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget _buildTab({
    required String title,
    required int index,
    required bool darkMode,
  }) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => handleSelectedIndex(index),
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
    final darkMode = THelperFunctions.isDarkMode(context);
    final screenHeight = THelperFunctions.screenHeight();

    return Container(
      height: screenHeight - kBottomNavigationBarHeight - 70,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 9),
            child: Row(
              children: [
                _buildTab(title: 'All', index: 1, darkMode: darkMode),
                _buildTab(title: 'New', index: 2, darkMode: darkMode),
                _buildTab(title: 'Trending', index: 3, darkMode: darkMode),
              ],
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: selectedIndex - 1,
              children: const [
                EurMarketList(),
                EurNewMarketList(),
                EurTrendingMarketList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
