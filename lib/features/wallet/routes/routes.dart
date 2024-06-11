import 'package:flutter/material.dart';
import 'package:swappr/features/profile/routes/names.dart';
import '../../../data/routes/guard_route.dart';
import '../screens/wallet.dart';


Map<String, WidgetBuilder> walletRoute = {
  WALLET_SCREEN_ROUTE: (context) => const AuthGuard(
    widget: WalletDashboardScreen(),
  ),
};
