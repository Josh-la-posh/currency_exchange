import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pouch/data/provider/offer_provider.dart';
import 'package:pouch/data/provider/subscription_provider.dart';
import 'package:pouch/data/provider/transaction_provider.dart';
import 'package:pouch/data/provider/wallet_provider.dart';
import '../../../data/modules/app_navigator.dart';
import '../../../data/modules/session_manager.dart';
import '../../../data/provider/auth_provider.dart';
import '../../../data/provider/notificaton_provider.dart';
import '../../../utils/configs/app_config.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: SPLASH_DURATION),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        UserSession.instance.handleIfUserIsNotLoginAfterSplashScreen();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    final transactionProvider = context.read<TransactionProvider>();
    final offerProvider = context.read<OfferProvider>();
    final subscriptionProvider = context.read<SubscriptionProvider>();
    final walletProvider = context.read<WalletProvider>();
    final notificationProvider = context.read<NotificationProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      UserSession.instance.routeUserToHomeIfLoggedIn(
        authProvider,
        walletProvider,
        transactionProvider,
        offerProvider,
        subscriptionProvider,
        notificationProvider,
      );
    });

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: TColors.primary,
        body: Center(
          child: Image.asset(
            'assets/logos/swappr-splash-logo.png',
            fit: BoxFit.contain,
            width: 90,
            height: 90,
          ),
        ),
      ),
    );
  }
}
