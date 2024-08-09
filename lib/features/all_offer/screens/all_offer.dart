import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pouch/features/all_offer/screens/market/all_market/all_market.dart';
import 'package:provider/provider.dart';
import 'package:pouch/data/modules/app_navigator.dart';
import 'package:pouch/data/modules/background_task.dart';
import 'package:pouch/utils/constants/enums.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import 'package:pouch/utils/shared/notification/snackbar.dart';
import '../../../common/widgets/buttons/floating_button.dart';
import '../../../data/provider/auth_provider.dart';
import '../../../data/provider/offer_provider.dart';
import '../../../data/provider/verification_provider.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/texts.dart';
import 'create_offer.dart';
import 'market/cad_market/cad_market.dart';
import 'market/eur_market/eur_market.dart';
import 'market/gbp_market/gbp_market.dart';
import 'market/ngn_market/ngn_market.dart';
import 'market/usd_market/usd_market.dart';

class AllOfferScreen extends StatefulWidget {
  const AllOfferScreen({super.key});

  @override
  State<AllOfferScreen> createState() => _AllOfferScreenState();
}

class _AllOfferScreenState extends State<AllOfferScreen> {
  OfferProvider offerProvider = Provider.of<OfferProvider>(
    AppNavigator.instance.navigatorKey.currentContext as BuildContext,
    listen: false
  );
  AuthProvider authProvider = Provider.of<AuthProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext,
      listen: false
  );
  VerificationProvider verifyProvider = Provider.of<VerificationProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext,
      listen: false
  );


  @override
  void initState() {
    NoLoaderService.instance.getAllOffers(
        offerProvider: offerProvider,
        onFailure: (){},
        onSuccess: (){}
    );
    if (offerProvider.offers.isEmpty) {
      NoLoaderService.instance.getAllOffers(
          offerProvider: offerProvider,
          onFailure: (){},
          onSuccess: (){}
      );
    }
    if (authProvider.user?.isVerified == false) {
      setState(() {
        verifyProvider.showVerifyModal = true;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor: darkMode ? TColors.textPrimaryO40 : Colors.white,
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: TSizes.defaultSpace * 0.8),
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
                  padding: const EdgeInsets.only(bottom: 30.0),
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
                // child: SingleChildScrollView(
                //   child: Column(
                //       children: [
                //         Column(
                //           children: [
                //             OfferList(),
                //           ],
                //         ),
                //       ],
                //     ),
                // ),
              ),
            ],
          ),
        ),
        floatingActionButton: TFloatingButton(
          onPressed: (){
            if (authProvider.user?.isVerified == true) {
              handleShowCustomToast(message: "Please verify your account");
            } else {
              offerProvider.updateDebitedCurrency(Currency.NGN);
              offerProvider.updateCreditedCurrency(Currency.NGN);
              offerProvider.updateAmount('0');
              offerProvider.updateRate('0');
              Get.to(() => const CreateOfferScreen());
            }
            },
        ),

      ),
    );
  }
}

