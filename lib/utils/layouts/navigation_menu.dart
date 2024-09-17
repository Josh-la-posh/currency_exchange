import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/all_offer/screens/all_offer.dart';
import 'package:pouch/features/transaction/screens/history.dart';
import 'package:pouch/features/home/screens/home.dart';
import 'package:pouch/features/wallet/screens/wallet.dart';
import '../constants/colors.dart';
import '../helpers/helper_functions.dart';

class NavigationMenu extends StatelessWidget {
  final NavigationController controller = Get.find<NavigationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(),
      body: Obx(() => IndexedStack(
        index: controller.selectedIndex.value,
        children: controller.screens,
      )),
    );
  }
}

// class NavigationMenu extends GetView<NavigationController> {
//
//   @override
//   Widget build(BuildContext context) {
//     final darkMode = THelperFunctions.isDarkMode(context);
//     return Scaffold(
//       bottomNavigationBar: Obx(
//             () => BottomNavigationBar(
//           backgroundColor: darkMode ? TColors.textPrimaryO40 : Colors.white.withOpacity(0.9),
//           elevation: 0,
//           currentIndex: controller.selectedIndex.value,
//           onTap: (index) => controller.selectedIndex.value = index,
//           selectedItemColor: TColors.primary,
//           unselectedItemColor: Colors.grey,
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home, size: 25),
//               label: 'Home',
//               tooltip: '',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.bar_chart, size: 25),
//               label: 'Markets',
//               tooltip: '',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.access_time_filled_outlined, size: 22),
//               label: 'History',
//               tooltip: '',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.account_balance_wallet, size: 21),
//               label: 'Wallet',
//               tooltip: '',
//             ),
//           ],
//           type: BottomNavigationBarType.fixed,
//           showSelectedLabels: true,
//           showUnselectedLabels: true,
//           selectedLabelStyle: TextStyle(
//             fontSize: 11,
//           ),
//           unselectedLabelStyle: TextStyle(
//             fontSize: 9,
//           ),
//           selectedIconTheme: const IconThemeData(size: 25),
//           unselectedIconTheme: const IconThemeData(size: 23),
//         ),
//       ),
//       // Using IndexedStack to maintain the state of each screen
//       body: Obx(() => IndexedStack(
//         index: controller.selectedIndex.value,
//         children: controller.screens,
//       )),
//     );
//   }
// }

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final List<Widget> screens = [
    HomeScreen(),
    AllOfferScreen(),
    const TransactionHistoryScreen(),
    WalletDashboardScreen(),
  ];
  void navigateToIndex(int index) {
    selectedIndex.value = index;
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final NavigationController controller = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return BottomAppBar(
      color: darkMode ? TColors.textPrimaryO40 : Colors.white.withOpacity(0.9),
      child: Obx(() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, 0, 'Home'),
          _buildNavItem(Icons.bar_chart, 1, 'Markets'),
          _buildNavItem(Icons.access_time_filled_outlined, 2, 'History'),
          _buildNavItem(Icons.account_balance_wallet, 3, 'Wallet'),
        ],
      )),
    );
  }

  Widget _buildNavItem(IconData icon, int index, String label) {
    return GestureDetector(
      onTap: () => controller.navigateToIndex(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 25,
            color: controller.selectedIndex.value == index ? TColors.primary : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: controller.selectedIndex.value == index ? TColors.primary : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}