import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pouch/data/provider/transaction_provider.dart';
import 'package:pouch/features/transaction/widgets/no_transaction.dart';
import 'package:pouch/features/transaction/widgets/transaction_item.dart';
import '../../../utils/layouts/list_layout.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions = Provider.of<TransactionProvider>(context, listen: false).transactions;

    if (transactions.isEmpty) {
      return const NoTransactionScreen();
    }

    return TListLayout(
      itemCount: transactions.length,
      itemBuilder: (_, index) {
        final item = transactions[index];
        return TransactionItem(item: item);
      },
    );
  }
}
