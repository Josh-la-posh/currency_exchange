import 'package:flutter/material.dart';import 'package:swappr/features/transaction_history/widgets/no_transaction.dart';
import 'package:swappr/features/transaction_history/widgets/transaction_item.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/layouts/list_layout.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    const int offer = 1;

    return SizedBox(
      child: offer == 0
          ? LayoutBuilder(builder: (context, constraints) {
        return const NoTransactionScreen();
      })
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: TSizes.spaceBtwSections),
          Text(
            'Transaction History',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: TSizes.md,),
          Column(
            children: [
              TListLayout(
                  itemCount: 3,
                  itemBuilder: (_, index) => const TransactionItem()
              )
            ],
          )
        ],
      ),
    );
  }
}
