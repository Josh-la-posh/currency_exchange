import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/all_offer/controllers/offer_controller.dart';
import 'package:pouch/features/all_offer/screens/market/all_market/all_market.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import '../../../common/widgets/buttons/floating_button.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/texts.dart';
import 'create_offer.dart';
import 'market/cad_market/cad_market.dart';
import 'market/eur_market/eur_market.dart';
import 'market/gbp_market/gbp_market.dart';
import 'market/ngn_market/ngn_market.dart';
import 'market/usd_market/usd_market.dart';

class AllOfferScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    OfferController controller = Get.find();
    controller.fetchAllOffers();
    final darkMode = THelperFunctions.isDarkMode(context);
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor: darkMode ? TColors.textPrimaryO40 : Colors.white,
        body: Container(
          padding: EdgeInsets.only(top: 30, left: TSizes.defaultSpace * 0.8, right: TSizes.defaultSpace * 0.8),
          height: THelperFunctions.screenHeight() - kBottomNavigationBarHeight,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10),
                child: TabBar(
                    isScrollable: true,
                    physics: AlwaysScrollableScrollPhysics(),
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
                      Tab(text: 'All',),
                      Tab(text: 'USD',),
                      Tab(text: 'NGN',),
                      Tab(text: 'GBP',),
                      Tab(text: 'CAD',),
                      Tab(text: 'EUR',)
                    ]
                ),
              ),
              Expanded(
                child: Container(
                  height: THelperFunctions.screenHeight() - kBottomNavigationBarHeight - 40,
                  child: TabBarView(
                      children: [
                        AllMarketScreen(),
                        UsdMarketScreen(),
                        NgnMarketScreen(),
                        GbpMarketScreen(),
                        CadMarketScreen(),
                        EurMarketScreen(),
                      ]
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: TFloatingButton(
          onPressed: (){
            if (controller.authController.user.value.isVerified == true) {
              Get.snackbar('Verification', 'Please verify your account');
            } else {
              Get.to(() => CreateOfferScreen());
            }
            },
        ),

      ),
    );
  }
}

