import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:swappr/common/widgets/verify_your_account.dart';
import 'package:swappr/data/modules/app_navigator.dart';
import 'package:swappr/data/provider/auth_provider.dart';
import 'package:swappr/data/provider/verification_provider.dart';
import 'package:swappr/features/home/widgets/my_home_balance.dart';
import 'package:swappr/features/home/widgets/sections.dart';
import 'package:swappr/features/home/widgets/trending_offer.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/constants/sizes.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';
import '../../../data/provider/offer_provider.dart';
import '../../all_offer/apis/api.dart';
import '../widgets/layout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    if (offerProvider.offers.isEmpty) {
      OfferService.instance.getAllOffers(
          offerProvider: offerProvider,
          currency: '',
          date: ''
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
    return DashboardScreenLayout(
      childWidget:SingleChildScrollView(
        child: Column(
            children: [
              // const SizedBox(height: TSizes.defaultSpace / 2,),
              verifyProvider.showVerifyModal == true
                  ? VerifyYourAccountWidget(
                darkMode: darkMode,
                onTap: () {
                  setState(() {
                    verifyProvider.showVerifyModal = !verifyProvider.showVerifyModal;
                  });
                },
              )
                  : SizedBox(height: 10),
              HomeBalanceWidget(darkMode: darkMode),
              const SizedBox(height: TSizes.defaultSpace,),
              Container(
                height: 2,
                padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace / 1.5, vertical: TSizes.lg),
                decoration: BoxDecoration(
                    color: TColors.white.withOpacity(0.32)
                ),
              ),
              LinkSectionWidget(darkMode: darkMode,),
              const SizedBox(height: TSizes.defaultSpace,),
             TrendingOffer(offerProvider: offerProvider, darkMode: darkMode,)
            ],
          ),
      ),
    );
  }
}

