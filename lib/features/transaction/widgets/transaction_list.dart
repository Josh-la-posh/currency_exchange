import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pouch/data/provider/transaction_provider.dart';
import 'package:pouch/features/transaction/widgets/no_transaction.dart';
import 'package:pouch/features/transaction/widgets/transaction_item.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import '../../../data/modules/background_task.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/layouts/list_layout.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TransactionProvider>(context);
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          provider.transactions.isEmpty
              ? LayoutBuilder(builder: (context, constraints) {
                return const NoTransactionScreen();
              })
              : Column(
            children: [
              TListLayout(
                  itemCount: provider.transactions.length,
                  itemBuilder: (_, index) {
                    final item = provider.transactions[index];
                    return TransactionItem(item: item);
                  }
              )
            ],
          )
        ],
      ),
    );
  }
}
