import 'package:flutter/material.dart';
import 'package:pouch/features/negotiation_offer/screen/bid_and_offer.dart';
import 'package:pouch/features/negotiation_offer/screen/my_bid_detail.dart';
import 'package:pouch/features/negotiation_offer/screen/my_offer_detail.dart';
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
  MY_OFFER_DETAIL_SCREEN_ROUTE: (context) => AuthGuard(
    widget: MyOfferDetail(),
  ),
  MY_BID_DETAIL_SCREEN_ROUTE: (context) => AuthGuard(
    widget: MyBidDetail(),
  ),
};
