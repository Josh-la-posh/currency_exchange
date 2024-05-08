import 'package:flutter/material.dart';
import 'package:swappr/features/home/routes/names.dart';
import 'package:swappr/features/home/screens/accept_review_details.dart';
import 'package:swappr/features/home/screens/create_offer.dart';
import 'package:swappr/features/home/screens/create_offer_success_screen.dart';
import 'package:swappr/features/home/screens/create_review_details.dart';
import 'package:swappr/features/home/screens/home.dart';
import 'package:swappr/features/home/screens/offer_details.dart';
import 'package:swappr/features/profile/routes/names.dart';
import 'package:swappr/features/profile/screens/wallet/wallet.dart';
import '../../../data/routes/guard_route.dart';

// Map<String, WidgetBuilder> homeRoute = {
//   // DASHBOARD_SCREEN_ROUTE: (context) => const AuthGuard(widget: HomeScreen()),
//   DASHBOARD_SCREEN_ROUTE: (context) => const HomeScreen(),
//   OFFER_DETAILS_SCREEN: (context) => const OfferDetailsScreen(),
//   ACCEPT_REVIEW_DETAILS_SCREEN: (context) => const AcceptReviewDetailsScreen(),
//   CREATE_OFFER_SCREEN: (context) => const CreateOfferScreen(),
//   CREATE_REVIEW_DETAILS_SCREEN: (context) => const CreateReviewDetailsScreen(),
//   CREATE_SUCCESS_SCREEN: (context) => const CreateOfferSuccessPage(),
// };


Map<String, WidgetBuilder> homeRoute = {
  DASHBOARD_SCREEN_ROUTE: (context) => const AuthGuard(widget: HomeScreen()),
  OFFER_DETAILS_SCREEN: (context) => const AuthGuard(
    widget: OfferDetailsScreen(),
  ),
  ACCEPT_REVIEW_DETAILS_SCREEN: (context) => const AuthGuard(
    widget: AcceptReviewDetailsScreen(),
  ),
  // ACCEPT_SUCCESS_SCREEN: (context) => const AuthGuard(
  //   widget: AcceptReviewDetailsScreen(),
  // ),
  CREATE_OFFER_SCREEN: (context) => const AuthGuard(
    widget: CreateOfferScreen(),
  ),
  CREATE_REVIEW_DETAILS_SCREEN: (context) => const AuthGuard(
    widget: CreateReviewDetailsScreen(),
  ),
  CREATE_SUCCESS_SCREEN: (context) => const AuthGuard(
    widget: CreateOfferSuccessPage(),
  ),
};
