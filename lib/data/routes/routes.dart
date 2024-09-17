import 'package:flutter/material.dart';
import 'package:pouch/features/all_offer/routes/routes.dart';
import 'package:pouch/features/home/routes/routes.dart';
import 'package:pouch/features/negotiation_offer/routes/routes.dart';
import 'package:pouch/features/payment_method/routes/routes.dart';
import 'package:pouch/features/profile/routes/routes.dart';
import 'package:pouch/features/subscription/routes/routes.dart';
import 'package:pouch/features/transaction/routes/routes.dart';
import 'package:pouch/features/verification/routes/routes.dart';
import 'package:pouch/features/wallet/routes/routes.dart';
import 'package:pouch/features/withdrawals/routes/routes.dart';

import '../../features/authentication/routes/routes.dart';
import '../../features/splash/routes/routes.dart';

Map<String, WidgetBuilder> routes = {
  ...splashRoutes,
  ...authRoutes,
  ...subscriptionRoutes,
  ...transactionRoutes,
  ...profileRoutes,
  ...homeRoute,
  ...offerRoute,
  ...verifyRoute,
  ...walletRoute,
  ...depositRoute,
  ...withdrawRoute,
  ...negotiationRoute
};


