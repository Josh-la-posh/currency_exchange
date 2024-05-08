import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swappr/features/transaction/screens/history.dart';
import 'package:swappr/features/home/screens/home.dart';
import 'package:swappr/features/profile/screens/profile.dart';
import 'package:swappr/features/subscription/screens/subscribe.dart';
import 'package:swappr/utils/constants/image_strings.dart';
import 'package:swappr/utils/constants/sizes.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: TSizes.bottomNavBar,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          indicatorColor: Colors.transparent,
          destinations: [
            NavigationDestination(icon: Image(image: AssetImage(controller.selectedIndex.value == 0 ? TImages.homeActive : TImages.home)), label: 'Home'),
            NavigationDestination(icon: Image(image: AssetImage(controller.selectedIndex.value == 1 ? TImages.subscribeActive : TImages.subscribe)), label: 'Subscribe'),
            NavigationDestination(icon: Image(image: AssetImage(controller.selectedIndex.value == 2 ? TImages.historyActive : TImages.history)), label: 'History'),
            NavigationDestination(icon: Image(image: AssetImage(controller.selectedIndex.value == 3 ? TImages.profileActive : TImages.profile)), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [const HomeScreen(), const SubscribeScreen(), const TransactionHistoryScreen(), const ProfileScreen()];
}
