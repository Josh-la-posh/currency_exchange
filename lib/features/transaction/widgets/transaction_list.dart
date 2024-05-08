import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swappr/data/provider/transaction_provider.dart';
import 'package:swappr/features/transaction/widgets/no_transaction.dart';
import 'package:swappr/features/transaction/widgets/transaction_item.dart';
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
          const SizedBox(height: TSizes.spaceBtwSections),
          Text(
            'Transaction History',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: TSizes.md,),
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
