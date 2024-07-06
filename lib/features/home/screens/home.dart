import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:swappr/common/widgets/verify_your_account.dart';
import 'package:swappr/data/modules/app_navigator.dart';
import 'package:swappr/data/provider/auth_provider.dart';
import 'package:swappr/data/provider/transaction_provider.dart';
import 'package:swappr/data/provider/verification_provider.dart';
import 'package:swappr/features/all_offer/models/offer.dart';
import 'package:swappr/features/home/widgets/my_home_balance.dart';
import 'package:swappr/features/home/widgets/sections.dart';
import 'package:swappr/features/home/widgets/trending_offer.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/constants/sizes.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';
import '../../../data/provider/offer_provider.dart';
import '../../../data/provider/wallet_provider.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/texts.dart';
import '../../all_offer/apis/api.dart';
import '../../all_offer/screens/all_offer.dart';
import '../../wallet/apis/api.dart';
import '../../wallet/models/default_wallet_model.dart';
import '../widgets/layout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WalletProvider walletProvider = Provider.of<WalletProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext,
      listen: false
  );
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
  TransactionProvider transactionProvider = Provider.of<TransactionProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext,
      listen: false
  );

  bool displayBalance = false;
  bool displayOffer = false;

  @override
  void initState() {
    if (walletProvider.defaultWallet == null) {
      WalletServices.instance.getDefaultWallet(
          walletProvider: walletProvider,
          transactionProvider: transactionProvider
      );
      Future.delayed(
          Duration(seconds: 5),
              () => handleShowBalance()
      );
      Future.delayed(
          Duration(seconds: 3),
              () => fetchDefaultWallet
      );
    } else {
      setState(() {
        displayBalance = true;
      });
    }


    if (offerProvider.offers.isEmpty) {
      OfferService.instance.getAllOffers(
          offerProvider: offerProvider,
          currency: '',
          date: ''
      );
      Future.delayed(
          Duration(seconds: 5),
              () => handleShowOffer()
      );
      Future.delayed(
          Duration(seconds: 3),
              () => fetchDefaultWallet
      );
    } else {
      setState(() {
        displayOffer = true;
      });
    }

    if (authProvider.user?.isVerified == false) {
      setState(() {
        verifyProvider.showVerifyModal = true;
      });
    }
    super.initState();
  }


  Future<void> fetchDefaultWallet()  async {
    try {
      if (walletProvider.defaultWallet == null) {
        DefaultWalletModel? defaultWalletDetail = await walletProvider.defaultWallet;
        setState(() {
          walletProvider.defaultWalletDetail = defaultWalletDetail;
          displayBalance = true;
        });
      } else {
        DefaultWalletModel? defaultWalletDetail = await walletProvider.defaultWallet;
        setState(() {
          walletProvider.defaultWalletDetail = defaultWalletDetail;
          displayBalance = true;
        });
      }
    } catch (e) {
      print('Error fetching wallet: $e');
    }
  }

  Future<void> fetchAllOffers()  async {
    try {
      if (offerProvider.offers.isEmpty) {
        List<OfferEntity>? offers = await offerProvider.offers;
        setState(() {
          offerProvider.tOffers = offers;
          displayOffer = true;
        });
      } else {
        List<OfferEntity>? offers = await offerProvider.offers;
        setState(() {
          offerProvider.tOffers = offers;
          displayOffer = true;
        });
      }
    } catch (e) {
      print('Error fetching offers: $e');
    }
  }

  void handleShowBalance() {
    setState(() {
      displayBalance = true;
    });
  }

  void handleShowOffer() {
    setState(() {
      displayOffer = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return DashboardScreenLayout(
      childWidget:SingleChildScrollView(
        child: Column(
            children: [
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
              HomeBalanceWidget(darkMode: darkMode, displayBalance: displayBalance,),
              const SizedBox(height: TSizes.defaultSpace,),
              LinkSectionWidget(darkMode: darkMode,),
              const SizedBox(height: TSizes.defaultSpace,),
              Container(
                height: 2,
                padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace / 1.5, vertical: TSizes.lg),
                decoration: BoxDecoration(
                    color: darkMode ? Colors.white.withOpacity(0.3) : Color(0xFFC88888).withOpacity(0.45)
                ),
              ),
              const SizedBox(height: TSizes.defaultSpace,),
              TrendingOffer(
                offerProvider: offerProvider,
                darkMode: darkMode,
                displayOffer: displayOffer,
              )
            ],
          ),
      ),
    );
  }
}

