import 'package:flutter/material.dart';
import 'package:pouch/features/all_offer/screens/exchange_rate_page.dart';
import 'package:pouch/utils/layouts/navigation_menu.dart';
import '../../../data/routes/guard_route.dart';
import '../screens/accept_review_details.dart';
import '../screens/create_offer.dart';
import '../screens/create_review_details.dart';
import '../screens/offer_details.dart';
import 'names.dart';


Map<String, WidgetBuilder> offerRoute = {
  ALL_OFFER_SCREEN_ROUTE: (context) => AuthGuard(
    widget: NavigationMenu(),
  ),
  OFFER_DETAILS_SCREEN: (context) => AuthGuard(
    widget: OfferDetailsScreen(),
  ),
  ACCEPT_REVIEW_DETAILS_SCREEN: (context) => AuthGuard(
    widget: AcceptReviewDetailsScreen(),
  ),
  ACCEPT_SUCCESS_SCREEN: (context) => AuthGuard(
    widget: AcceptReviewDetailsScreen(),
  ),
  CREATE_OFFER_SCREEN: (context) => AuthGuard(
    widget: CreateOfferScreen(),
  ),
  CREATE_REVIEW_DETAILS_SCREEN: (context) => AuthGuard(
    widget: CreateReviewDetailsScreen(),
  ),
  EXCHANGE_RATE_SCREEN_ROUTE: (context) => AuthGuard(
    widget: ExchangeRatePage(),
  ),
};
