import 'package:flutter/material.dart';
import 'package:pouch/features/instant_swap/screen/instant_swap_screen.dart';
import 'package:pouch/features/instant_swap/screen/pouch_exchange_rate_screen.dart';
import 'package:pouch/features/instant_swap/screen/pouch_swap_success_screen.dart';
import 'package:pouch/features/negotiation_offer/screen/negotiation_offer.dart';
import '../../../data/routes/guard_route.dart';
import '../screen/add_new_autoswap.dart';
import 'names.dart';

Map<String, WidgetBuilder> swapRoute = {
  POUCH_SWAP_SCREEN: (context) => AuthGuard(
    widget: NegotiationOfferScreen(),
  ),
  POUCH_EXCHANGE_RATE_SCREEN: (context) => AuthGuard(
    widget: PouchExchangeRateScreen(),
  ),
  POUCH_SWAP_SUCCESS_SCREEN: (context) => AuthGuard(
    widget: PouchSwapSuccessScreen(),
  ),
  INSTANT_SWAP_SCREEN: (context) => AuthGuard(
    widget: InstantSwapScreen(),
  ),
  INSTANT_SWAP_DETAIL_SCREEN: (context) => AuthGuard(
    widget: InstantSwapScreen(),
  ),
  ADD_NEW_AUTO_SWAP_SCREEN: (context) => AuthGuard(
    widget: AddNewAutoSwap(),
  ),
};
