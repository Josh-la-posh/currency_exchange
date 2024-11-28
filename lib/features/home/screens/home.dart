import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pouch/common/widgets/currencyWidget.dart';
import 'package:pouch/features/home/widgets/app_drawer.dart';
import 'package:pouch/features/home/widgets/my_bid_offer.dart';
import 'package:pouch/features/home/widgets/my_offer.dart';
import 'package:pouch/features/negotiation_offer/screen/bid_and_offer.dart';
import 'package:pouch/features/notification/screens/notification.dart';
import 'package:pouch/utils/layouts/navigation_menu.dart';
import 'package:pouch/common/widgets/verify_your_account.dart';
import 'package:pouch/features/home/widgets/my_home_balance.dart';
import 'package:pouch/features/home/widgets/sections.dart';
import 'package:pouch/features/home/widgets/trending_offer.dart';
import 'package:pouch/utils/constants/colors.dart';
import 'package:pouch/utils/constants/sizes.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import '../../../utils/constants/texts.dart';
import '../../all_offer/controllers/offer_controller.dart';
import '../../negotiation_offer/controller/negotiation_offer_controller.dart';
import '../../notification/controller/notification_controller.dart';
import '../controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  final NegotiationOfferController negotiationOfferController = Get.put(NegotiationOfferController());
  final NotificationController notificationController = Get.put(NotificationController());
  final OfferController offerController = Get.find();

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
            child: _buildNotificationBadge(),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationBadge() {
    return Obx(() {
      if (notificationController.idsArray.isEmpty) {
        return SizedBox();
      } else {
        return Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              color: Colors.red
          ),
          child: Center(
            child: Text(notificationController.idsArray.length.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          ),
        );
      }
    });
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
    );
  }

  Widget _buildTopSection(bool darkMode) {
    return Container(
      color: darkMode ? TColors.textPrimaryO40 : Colors.white,
      width: double.infinity,
      child: Column(
        children: [
          Obx(() => controller.userSessionController.isVerifiedDisplay.value
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
      child: CurrencyWidget(),
    );
  }

  Widget _buildTabBarSection(bool darkMode) {
    return Obx(() => Column(
      children: [
        _buildTabBar(darkMode),
        _buildTabBarView(darkMode),
      ],
    ));
  }

  Widget _buildTabBar(bool darkMode) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: darkMode ? TColors.textPrimaryO40 : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: CupertinoColors.secondarySystemFill
          )
        )
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () => controller.selectedIndex.value = 0,
            child: Container(
              padding: EdgeInsets.only(bottom: 5),
              margin: EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 3,
                    color: controller.selectedIndex.value == 0
                        ? TColors.primary
                        : Colors.transparent
                  )
                )
              ),
              child: Text(
                'All Offers',
                style: TextStyle(
                  color: controller.selectedIndex.value == 0
                      ? darkMode ? Colors.white : Colors.black
                      : Colors.grey,
                  fontSize: 14,
                  fontWeight: TSizes.fontWeightMd,
                  fontFamily: TTexts.fontFamily,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => controller.selectedIndex.value = 1,
            child: Container(
              padding: EdgeInsets.only(bottom: 5),
              margin: EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 3,
                          color: controller.selectedIndex.value == 1
                              ? TColors.primary
                              : Colors.transparent
                      )
                  )
              ),
              child: Text(
                'My Offers',
                style: TextStyle(
                  color: controller.selectedIndex.value == 1
                      ? darkMode ? Colors.white : Colors.black
                      : Colors.grey,
                  fontSize: 14,
                  fontWeight: TSizes.fontWeightMd,
                  fontFamily: TTexts.fontFamily,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => controller.selectedIndex.value = 2,
            child: Container(
              padding: EdgeInsets.only(bottom: 5),
              margin: EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 3,
                          color: controller.selectedIndex.value == 2
                              ? TColors.primary
                              : Colors.transparent
                      )
                  )
              ),
              child: Text(
                'My Bids',
                style: TextStyle(
                  color: controller.selectedIndex.value == 2
                      ? darkMode ? Colors.white : Colors.black
                      : Colors.grey,
                  fontSize: 14,
                  fontWeight: TSizes.fontWeightMd,
                  fontFamily: TTexts.fontFamily,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBarView(bool darkMode) {
    return Container(
      color: darkMode ? TColors.textPrimaryO40 : Colors.white,
      child: IndexedStack(
        index: controller.selectedIndex.value,
        children: [
          _buildOffersSection(),
          _buildMyOffersSection(darkMode),
          _buildMyBidsSection(darkMode),
        ],
      ),
    );
  }

  Widget _buildOffersSection() {
    NavigationController navigationController = Get.find();
    return Column(
      children: [
        TrendingOffer(),
        Obx(() => offerController.allOffers.isNotEmpty
            ? _buildMoreButton(() {
          offerController.allOfferIndex.value = 0;
          navigationController.selectedIndex.value = 1;
        })
            : const SizedBox.shrink()),
      ],
    );
  }

  Widget _buildMyOffersSection(bool darkMode) {
    return Column(
      children: [
        MyOffer(),
        Obx(() => negotiationOfferController.myOffers.isNotEmpty
            ? _buildMoreButton(() {
          negotiationOfferController.myOfferIndex.value = 0;
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
        Obx(() => negotiationOfferController.myBids.isNotEmpty
            ? _buildMoreButton(() {
          negotiationOfferController.myOfferIndex.value = 1;
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
