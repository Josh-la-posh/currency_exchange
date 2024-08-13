import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/all_offer/screens/all_offer.dart';
import 'package:pouch/features/transaction/screens/history.dart';
import 'package:pouch/features/home/screens/home.dart';
import 'package:pouch/features/wallet/screens/wallet.dart';
import '../constants/colors.dart';
import '../helpers/helper_functions.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
            () => BottomNavigationBar(
          backgroundColor: darkMode ? TColors.textPrimaryO40 : Colors.white.withOpacity(0.9),
          elevation: 0,
          currentIndex: controller.selectedIndex.value,
          onTap: (index) => controller.selectedIndex.value = index,
          selectedItemColor: TColors.primary,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 25),
              label: 'Home',
              tooltip: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart, size: 25),
              label: 'Markets',
              tooltip: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.access_time_filled_outlined, size: 22),
              label: 'History',
              tooltip: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet, size: 21),
              label: 'Wallet',
              tooltip: '',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: TextStyle(
            fontSize: 14, // Adjust the font size for the selected label
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 12, // Adjust the font size for the unselected label
          ),
          selectedIconTheme: IconThemeData(size: 25),
          unselectedIconTheme: IconThemeData(size: 23),
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    const HomeScreen(),
    const AllOfferScreen(),
    const TransactionHistoryScreen(),
    const WalletDashboardScreen(),
  ];
}
