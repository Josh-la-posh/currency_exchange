import 'package:flutter/material.dart';
import 'package:swappr/features/transaction_history/routes/names.dart';
import 'package:swappr/features/transaction_history/screens/history.dart';

import '../../../data/routes/guard_route.dart';

Map<String, WidgetBuilder> transactionRoutes = {
  TRANSACTION_HISTORY_SCREEN_ROUTE: (context) => const TransactionHistoryScreen()
};



// Map<String, WidgetBuilder> transactionRoutes = {
//   TRANSACTION_HISTORY_SCREEN_ROUTE: (context) => const AuthGuard(widget: TransactionHistoryScreen()),
// };
