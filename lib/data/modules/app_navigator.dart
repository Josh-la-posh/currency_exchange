import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';
import '../provider/currency_provider.dart';
import '../provider/offer_provider.dart';
import '../provider/subscription_provider.dart';
import '../provider/transaction_provider.dart';
import '../provider/wallet_provider.dart';

class AppNavigator {
  static final AppNavigator _instance = AppNavigator._();

  AppNavigator._();

  static AppNavigator get instance => _instance;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic>? navigateToHandler(String routeName,
      {dynamic arguments = null}) =>
      navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);

  void goBackNavHandler() => navigatorKey.currentState!.pop();

  void removeUntilNavHandler(String routeName) =>
      navigatorKey.currentState!.popUntil(ModalRoute.withName(routeName));

  void removeAndPushNavHandler(String routeName) =>
      navigatorKey.currentState!.popAndPushNamed(routeName);

  void replaceWithNavHandler(String routeName) =>
      navigatorKey.currentState!.pushReplacementNamed(routeName);

  void removeAllNavigateToNavHandler(String routeName) =>
      navigatorKey.currentState!
          .pushNamedAndRemoveUntil(routeName, (route) => false);

  void popContext(BuildContext context) =>
      navigatorKey.currentState!.pop(context);

  void resetProviders() {
    var authProvider = Provider.of<AuthProvider>(
      navigatorKey.currentState!.context,
      listen: false,
    );
    var currencyProvider = Provider.of<CurrencyProvider>(
      navigatorKey.currentState!.context,
      listen: false,
    );
    var offerProvider = Provider.of<OfferProvider>(
      navigatorKey.currentState!.context,
      listen: false,
    );
    var subscriptionProvider = Provider.of<SubscriptionProvider>(
      navigatorKey.currentState!.context,
      listen: false,
    );
    var transactionProvider = Provider.of<TransactionProvider>(
      navigatorKey.currentState!.context,
      listen: false,
    );
    var walletProvider = Provider.of<WalletProvider>(
      navigatorKey.currentState!.context,
      listen: false,
    );

    authProvider.removeUser();
    currencyProvider.resetState();
    offerProvider.resetState();
    subscriptionProvider.resetState();
    transactionProvider.resetState();
    walletProvider.resetState();
  }
}
