import 'package:flutter/material.dart';
import 'package:swappr/features/negotiation_offer/screen/negotiation_offer.dart';
import '../../../data/routes/guard_route.dart';
import 'names.dart';


Map<String, WidgetBuilder> negotiationRoute = {
  NEGOTIATION_OFFER_SCREEN: (context) => const AuthGuard(
    widget: NegotiationOfferScreen(),
  ),
};
