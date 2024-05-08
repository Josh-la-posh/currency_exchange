import 'package:flutter/material.dart';
import 'package:swappr/features/profile/routes/names.dart';
import 'package:swappr/features/profile/screens/wallet/wallet.dart';
import 'package:swappr/features/profile/screens/profile.dart';
import '../../../data/routes/guard_route.dart';


// Map<String, WidgetBuilder> profileRoutes = {
//   PROFILE_SCREEN_ROUTE: (context) => const ProfileScreen(),
//   WALLET_SCREEN_ROUTE: (context) => const WalletScreen(),
// };


Map<String, WidgetBuilder> profileRoutes = {
  PROFILE_SCREEN_ROUTE: (context) => const AuthGuard(widget: ProfileScreen()),
  WALLET_SCREEN_ROUTE: (context) => const AuthGuard(
    widget: WalletScreen(),
  ),
};
