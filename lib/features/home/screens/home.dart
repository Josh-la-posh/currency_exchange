import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pouch/common/widgets/currencyWidget.dart';
import 'package:pouch/features/all_offer/screens/all_offer.dart';
import 'package:pouch/features/home/widgets/app_drawer.dart';
import 'package:pouch/features/home/widgets/my_bid_offer.dart';
import 'package:pouch/features/home/widgets/my_offer.dart';
import 'package:pouch/features/negotiation_offer/screen/bid_and_offer.dart';
import 'package:pouch/features/notification/screens/notification.dart';
import 'package:pouch/utils/shared/refresh_indicator/refresh_indicator.dart';
import 'package:pouch/common/widgets/verify_your_account.dart';
import 'package:pouch/features/home/widgets/my_home_balance.dart';
import 'package:pouch/features/home/widgets/sections.dart';
import 'package:pouch/features/home/widgets/trending_offer.dart';
import 'package:pouch/utils/constants/colors.dart';
import 'package:pouch/utils/constants/sizes.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import '../../../utils/constants/texts.dart';
import '../controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: darkMode ? Colors.black.withOpacity(0.5) : Colors.black.withOpacity(0.01),
        appBar: _buildAppBar(context, darkMode),
        body: _buildBody(context, darkMode),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, bool darkMode) {
    return AppBar(
      backgroundColor: darkMode ? TColors.textPrimaryO40 : Colors.white,
      leading: _buildDrawerButton(darkMode),
      actions: [_buildNotificationIcon()],
    );
  }

  Widget _buildDrawerButton(bool darkMode) {
    return Container(
      width: 60,
      height: 60,
      margin: const EdgeInsets.only(left: TSizes.defaultSpace / 2),
      child: IconButton(
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        padding: EdgeInsets.zero,
        onPressed: () {
          Get.to(() => AppDrawerWidget(darkMode: darkMode),
            transition: Transition.leftToRight,
            duration: const Duration(milliseconds: 500),
          );
        },
        icon: const Icon(Icons.person_pin, color: TColors.primary, size: 35),
      ),
    );
  }

  Widget _buildNotificationIcon() {
    return Container(
      margin: EdgeInsets.only(right: TSizes.defaultSpace),
      child: Stack(
        children: [
          IconButton(
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            padding: EdgeInsets.zero,
            onPressed: () {
              Get.to(() => NotificationScreen(),
                transition: Transition.rightToLeft,
                duration: const Duration(milliseconds: 500),
              );
            },
            icon: const Icon(Iconsax.notification4, color: TColors.primary, size: 30),
          ),
          Positioned(
            right: 4,
            child: Obx(() {
              return _buildNotificationBadge();
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationBadge() {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: controller.notificationController.idsArray.isNotEmpty
            ? Colors.red
            : Colors.transparent,
      ),
      child: Center(
        child: Text(
          controller.notificationController.idsArray.isNotEmpty
              ? controller.notificationController.idsArray.length.toString()
              : '',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, bool darkMode) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: darkMode
                ? Colors.black.withOpacity(0.5)
                : Colors.black.withOpacity(0.1),
          ),
        ),
      ),
      child: CustomRefreshIndicator(
        onRefresh: () => controller.offerController.refreshHomePage(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTopSection(darkMode),
              const SizedBox(height: 8),
              _buildCurrencySection(darkMode),
              const SizedBox(height: 8),
              _buildTabBarSection(darkMode),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopSection(bool darkMode) {
    return Container(
      color: darkMode ? TColors.textPrimaryO40 : Colors.white,
      width: double.infinity,
      child: Column(
        children: [
          Obx(() => controller.authController.isVerifiedDisplay.value
              ? VerifyYourAccountWidget()
              : const SizedBox.shrink()),
          HomeBalanceWidget(),
          LinkSectionWidget(darkMode: darkMode),
        ],
      ),
    );
  }

  Widget _buildCurrencySection(bool darkMode) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      color: darkMode ? TColors.textPrimaryO40 : Colors.white,
      child: const CurrencyWidget(),
    );
  }

  Widget _buildTabBarSection(bool darkMode) {
    return Column(
      children: [
        _buildTabBar(darkMode),
        _buildTabBarView(darkMode),
      ],
    );
  }

  TabBar _buildTabBar(bool darkMode) {
    return TabBar(
      isScrollable: true,
      indicatorColor: TColors.primary,
      labelColor: darkMode ? Colors.white : Colors.black,
      unselectedLabelColor: Colors.grey,
      overlayColor: const MaterialStatePropertyAll(Colors.transparent),
      labelStyle: TextStyle(
        fontSize: 16,
        fontWeight: TSizes.fontWeightMd,
        fontFamily: TTexts.fontFamily,
      ),
      tabs: const [
        Tab(text: 'All Offers'),
        Tab(text: 'My Offers'),
        Tab(text: 'My Bids'),
      ],
    );
  }

  Widget _buildTabBarView(bool darkMode) {
    return Container(
      color: darkMode ? TColors.textPrimaryO40 : Colors.white,
      padding: const EdgeInsets.only(bottom: 30.0),
      height: 390,
      child: TabBarView(
        children: [
          _buildOffersSection(),
          _buildMyOffersSection(darkMode),
          _buildMyBidsSection(darkMode),
        ],
      ),
    );
  }

  Widget _buildOffersSection() {
    return Column(
      children: [
        TrendingOffer(),
        Obx(() => controller.offerController.allOffers.isNotEmpty
            ? _buildMoreButton(() {
          controller.offerController.allOfferIndex.value = 0;
          Get.to(() => AllOfferScreen());
        })
            : const SizedBox.shrink()),
      ],
    );
  }

  Widget _buildMyOffersSection(bool darkMode) {
    return Column(
      children: [
        MyOffer(),
        Obx(() => controller.offerController.myOffers.isNotEmpty
            ? _buildMoreButton(() {
          controller.offerController.myOfferIndex.value = 0;
          Get.to(() => MyBidAndOfferScreen());
        })
            : const SizedBox.shrink()),
      ],
    );
  }

  Widget _buildMyBidsSection(bool darkMode) {
    return Column(
      children: [
        MyBidOffer(),
        Obx(() => controller.offerController.myBids.isNotEmpty
            ? _buildMoreButton(() {
          controller.offerController.myOfferIndex.value = 1;
          Get.to(() => MyBidAndOfferScreen());
        })
            : const SizedBox.shrink()),
      ],
    );
  }

  Widget _buildMoreButton(VoidCallback onTap) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      title: Container(
        height: 70,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.black.withOpacity(0.1),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'More',
              style: TextStyle(fontSize: 14, fontWeight: TSizes.fontWeightNm),
            ),
            const SizedBox(width: 3),
            const Icon(Icons.arrow_forward, size: 15),
          ],
        ),
      ),
    );
  }
}
