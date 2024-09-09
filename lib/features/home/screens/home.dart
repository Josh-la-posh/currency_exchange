import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pouch/common/widgets/currencyWidget.dart';
import 'package:pouch/features/all_offer/controllers/offer_controller.dart';
import 'package:pouch/features/authentication/controllers/auth_controller.dart';
import 'package:pouch/features/home/widgets/app_drawer.dart';
import 'package:pouch/features/negotiation_offer/screen/bid_and_offer.dart';
import 'package:pouch/features/negotiation_offer/screen/my_bid.dart';
import 'package:pouch/features/negotiation_offer/screen/my_offer.dart';
import 'package:pouch/features/notification/controller/notification_controller.dart';
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
import '../../../utils/layouts/navigation_menu.dart';

class HomeScreen extends StatelessWidget {
  final NotificationController notificationController = Get.put(NotificationController());
  final OfferController offerController = Get.put(OfferController());
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    final controller = Get.put(NavigationController());
    authController.getIsVerified();
    if (offerController.trendingOffers.isEmpty){
      offerController.fetchTrendingOffers();
    }
    if (offerController.myOffers.isEmpty){
      offerController.fetchMyOffers(days: '', currency: '');
    }
    if (offerController.myBids.isEmpty){
      offerController.fetchMyBids(days: '', currency: '');
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: darkMode ? Colors.black.withOpacity(0.5) : Colors.black.withOpacity(0.01),
        appBar: AppBar(
          backgroundColor: darkMode ? TColors.textPrimaryO40 : Colors.white,
          leading: Builder(
              builder: (context) => Container(
                width: 60,
                height: 60,
                margin: const EdgeInsets.only(left: TSizes.defaultSpace / 2),
                child: IconButton(
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    onPressed: () =>
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (_, __, ___) => AppDrawerWidget(darkMode: darkMode),
                                transitionDuration: Duration(milliseconds: 500) ,
                                transitionsBuilder: (_, a, __, c) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  const curve = Curves.ease;

                                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                  return SlideTransition(position: a.drive(tween), child: c,);
                                }
                            )
                        ),
                    icon: Icon(Icons.person_pin, color: TColors.primary, size: 35,)
                ),
              )
          ),
          actions: [
            Builder(
                builder: (context) => Container(
                  margin: EdgeInsets.only(right: TSizes.defaultSpace),
                  child: Stack(
                    children: [
                      IconButton(
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        onPressed: () =>
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                    pageBuilder: (_, __, ___) => NotificationScreen(),
                                    transitionDuration: Duration(milliseconds: 500) ,
                                    transitionsBuilder: (_, a, __, c) {
                                      const begin = Offset(1.0, 0.0);
                                      const end = Offset.zero;
                                      const curve = Curves.ease;
                                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                      return SlideTransition(position: a.drive(tween), child: c,);
                                    }
                                )
                            ),
                        icon: Icon(Iconsax.notification4, color: TColors.primary, size: 30)
                    ),
                      Positioned(
                          right: 4,
                          child: Obx(() {
                            return Container(
                              width: 18,
                              height: 18,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9),
                                  color: notificationController.idsArray.isNotEmpty ? Colors.red : Colors.transparent
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(notificationController.idsArray.isNotEmpty ? notificationController.idsArray.length.toString() : '',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10
                                    ),
                                  ),
                                ],
                              ),
                            );
                          })
                      )
                    ],
                  ),
                )
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: darkMode ? Colors.black.withOpacity(0.5) : Colors.black.withOpacity(0.1),
              )
            )
          ),
          child: CustomRefreshIndicator(
            onRefresh: () => offerController.refreshHomePage(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: darkMode ? TColors.textPrimaryO40 : Colors.white,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Obx(() {
                          if (authController.isVerifiedDisplay.value) {
                            return VerifyYourAccountWidget();
                          }
                          return SizedBox();
                        }),
                        HomeBalanceWidget(),
                        LinkSectionWidget(darkMode: darkMode,),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    color: darkMode ? TColors.textPrimaryO40 : Colors.white,
                    child: CurrencyWidget()
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    color: darkMode ? TColors.textPrimaryO40 : Colors.white,
                    child: TabBar(
                        isScrollable: true,
                        indicatorColor: TColors.primary,
                        labelColor: darkMode ? Colors.white : Colors.black,
                        unselectedLabelColor: Colors.grey,
                        dividerColor: darkMode ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1),
                        overlayColor: MaterialStatePropertyAll(Colors.transparent),
                        tabAlignment: TabAlignment.start,
                        labelStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: TSizes.fontWeightMd,
                            fontFamily: TTexts.fontFamily
                        ),
                        tabs: [
                          Tab(text: 'All Offers',),
                          Tab(text: 'My Offers',),
                          Tab(text: 'My Bids',)
                        ]
                    ),
                  ),
                  Container(
                    color: darkMode ? TColors.textPrimaryO40 : Colors.white,
                    padding: const EdgeInsets.only(bottom: 30.0),
                    height: 390,
                    child: TabBarView(
                        children: [
                          Column(
                            children: [
                              TrendingOffer(),
                              Obx(() {
                                if (offerController.trendingOffers.isNotEmpty) {
                                  return ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    hoverColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onTap: () {
                                      offerController.allOfferIndex.value = 2;
                                      controller.selectedIndex.value = 1;
                                    },
                                    title: Container(
                                      height: 70,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              top: BorderSide(
                                                color: darkMode ? Colors.black.withOpacity(0.5) : Colors.black.withOpacity(0.1),
                                              )
                                          )
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'More',
                                            style: TextStyle(
                                                color: darkMode ? Colors.white : Colors.grey,
                                                fontSize: 14,
                                                fontWeight: TSizes.fontWeightNm
                                            ),),
                                          SizedBox(width: 3),
                                          Icon(
                                            Icons.arrow_forward,
                                            color: darkMode ? Colors.white : Colors.grey,
                                            size: 15,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return SizedBox();
                                }
                              })
                            ],
                          ),
                          Column(
                            children: [
                              MyOfferScreen(darkMode: darkMode, length: '3'),
                              Obx(() {
                                if (offerController.myOffers.isNotEmpty) {
                                  return ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    hoverColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onTap: () {
                                      offerController.myOfferIndex.value = 0;
                                      Get.to(() => MyBidAndOfferScreen());
                                    },
                                    title: Container(
                                      height: 70,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              top: BorderSide(
                                                color: darkMode ? Colors.black.withOpacity(0.5) : Colors.black.withOpacity(0.1),
                                              )
                                          )
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'More',
                                            style: TextStyle(
                                                color: darkMode ? Colors.white : Colors.grey,
                                                fontSize: 14,
                                                fontWeight: TSizes.fontWeightNm
                                            ),),
                                          SizedBox(width: 3),
                                          Icon(
                                            Icons.arrow_forward,
                                            color: darkMode ? Colors.white : Colors.grey,
                                            size: 15,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return SizedBox();
                                }
                              })
                            ],
                          ),
                          Column(
                            children: [
                              MyBidScreen(darkMode: darkMode, length: '3'),
                              Obx(() {
                                if (offerController.myBids.isNotEmpty) {
                                  return ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      hoverColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      // tileColor: darkMode ? TColors.textPrimaryO40 : Colors.white,
                                      onTap: () {
                                        offerController.myOfferIndex.value = 1;
                                        Get.to(() => MyBidAndOfferScreen());
                                      },
                                      title: Container(
                                        height: 70,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                top: BorderSide(
                                                  color: darkMode ? Colors.black.withOpacity(0.5) : Colors.black.withOpacity(0.1),
                                                )
                                            )
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'More',
                                              style: TextStyle(
                                                  color: darkMode ? Colors.white : Colors.grey,
                                                  fontSize: 14,
                                                  fontWeight: TSizes.fontWeightNm
                                              ),),
                                            SizedBox(width: 3),
                                            Icon(
                                              Icons.arrow_forward,
                                              color: darkMode ? Colors.white : Colors.grey,
                                              size: 15,
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                } else {
                                  return SizedBox();
                                }
                              })
                            ],
                          ),
                        ]
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

