import 'package:flutter/material.dart';
import 'package:pouch/features/negotiation_offer/screen/negotiation_offer.dart';
import '../../../data/routes/guard_route.dart';
import 'names.dart';

Map<String, WidgetBuilder> swapRoute = {
  POUCH_SWAP_SCREEN: (context) => AuthGuard(
    widget: NegotiationOfferScreen(),
  ),
};
