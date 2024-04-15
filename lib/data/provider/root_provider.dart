import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swappr/data/provider/currency_provider.dart';
import 'package:swappr/data/provider/offer_provider.dart';

class RootProvider extends StatelessWidget {
  final Widget app;
  const RootProvider({super.key, required this.app});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CurrencyProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OfferProvider(['GBP', 'NGN']),
        ),
      ],
      child: app,
    );
  }
}
