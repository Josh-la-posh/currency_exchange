import 'package:flutter/material.dart';
import 'package:pouch/features/transaction/routes/names.dart';
import 'package:pouch/features/transaction/screens/history.dart';
import 'package:pouch/utils/layouts/navigation_menu.dart';

import '../../../data/routes/guard_route.dart';

Map<String, WidgetBuilder> transactionRoutes = {
  TRANSACTION_HISTORY_SCREEN_ROUTE: (context) => AuthGuard(widget: NavigationMenu()),
};
