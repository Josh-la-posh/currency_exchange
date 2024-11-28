import 'package:flutter/material.dart';
import 'package:pouch/utils/layouts/navigation_menu.dart';
import '../../../data/routes/guard_route.dart';
import '../screens/accept_review_details.dart';
import '../screens/create_offer.dart';
import '../screens/create_offer_success_screen.dart';
import '../screens/create_review_details.dart';
import '../screens/all_offer.dart';
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
  // CREATE_SUCCESS_SCREEN: (context) => AuthGuard(
  //   widget: CreateOfferSuccessPage(),
  // ),
};
