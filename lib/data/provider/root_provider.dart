import 'package:flutter/material.dart';
import 'package:pouch/data/provider/notificaton_provider.dart';
import 'package:provider/provider.dart';
import 'package:pouch/data/provider/auth_provider.dart';
import 'package:pouch/data/provider/currency_provider.dart';
import 'package:pouch/data/provider/offer_provider.dart';
import 'package:pouch/data/provider/subscription_provider.dart';
import 'package:pouch/data/provider/transaction_provider.dart';
import 'package:pouch/data/provider/verification_provider.dart';
import 'package:pouch/data/provider/wallet_provider.dart';

class RootProvider extends StatelessWidget {
  final Widget app;
  const RootProvider({super.key, required this.app});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider.instance,
        ),
        ChangeNotifierProvider(
          create: (_) => CurrencyProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OfferProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SubscriptionProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => WalletProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TransactionProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificationProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => VerificationProvider(),
        ),
      ],
      child: app,
    );
  }
}
