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

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  // ignore: unused_field
  late Animation<double> _animation;

  var authProvider = Provider.of<AuthProvider>(
    AppNavigator.instance.navigatorKey.currentContext as BuildContext,
    listen: false,
  );
  var transactionProvider = Provider.of<TransactionProvider>(
    AppNavigator.instance.navigatorKey.currentContext as BuildContext,
    listen: false,
  );

  var offerProvider = Provider.of<OfferProvider>(
    AppNavigator.instance.navigatorKey.currentContext as BuildContext,
    listen: false,
  );
  var subscriptionProvider = Provider.of<SubscriptionProvider>(
    AppNavigator.instance.navigatorKey.currentContext as BuildContext,
    listen: false,
  );

  var walletProvider = Provider.of<WalletProvider>(
    AppNavigator.instance.navigatorKey.currentContext as BuildContext,
    listen: false,
  );

  var notificationProvider = Provider.of<NotificationProvider>(
    AppNavigator.instance.navigatorKey.currentContext as BuildContext,
    listen: false,
  );

  @override
  void initState() {
    super.initState();
    UserSession.instance.routeUserToHomeIfLoggedIn(
      authProvider,
      walletProvider,
      transactionProvider,
      offerProvider,
      subscriptionProvider,
      notificationProvider
    );

    _controller = AnimationController(
      duration: const Duration(seconds: SPLASH_DURATION),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();


    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Future.delayed(Duration(seconds: 1), () {
          UserSession.instance.handleIfUserIsNotLoginAfterSplashScreen();
        // });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: TColors.primary,
        body: Stack(
          children: [
            Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                left: 0,
                child: Image(image: AssetImage(TImages.appLogoPng))
            )
          ],
        ),
      ),
    );
  }
}
