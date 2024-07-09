import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:swappr/data/modules/background_task.dart';
import 'package:swappr/data/provider/transaction_provider.dart';
import 'package:swappr/features/transaction/apis/api.dart';

import '../../../data/modules/app_navigator.dart';
import '../../../data/provider/auth_provider.dart';
import '../widgets/layout.dart';
import '../widgets/transaction_list.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  var transactionProvider = Provider.of<TransactionProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext);

  @override
  void initState() {
    if (transactionProvider.transactions.isEmpty) {
      NoLoaderService.instance.getTransactions(transactionProvider: transactionProvider);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const TransactionScreenLayout(
      childWidget:SingleChildScrollView(
        child: Column(
          children: [
            TransactionList(),
          ],
        ),
      ),

    );
  }
}

