import 'package:flutter/material.dart';
import 'package:pouch/features/negotiation_offer/screen/bid_and_offer.dart';
import 'package:pouch/features/negotiation_offer/screen/negotiation_offer.dart';
import '../../../data/routes/guard_route.dart';
import 'names.dart';

Map<String, WidgetBuilder> negotiationRoute = {
  NEGOTIATION_OFFER_SCREEN: (context) => const AuthGuard(
    widget: NegotiationOfferScreen(),
  ),
  MY_OFFER_AND_BID_SCREEN_ROUTE: (context) => const AuthGuard(
    widget: MyBidAndOfferScreen(),
  ),
};
