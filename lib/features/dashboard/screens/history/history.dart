import 'package:flutter/material.dart';
import 'package:swappr/features/dashboard/screens/history/widgets/no_transaction.dart';
import 'package:swappr/features/dashboard/screens/history/widgets/transaction_list.dart';

import '../../../../common/styles/spacing_styles.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/layouts/list_layout.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int transactionList = 1;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.dashboardPadding * 1.3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Transaction History', style: Theme.of(context).textTheme.titleMedium,),
              if (transactionList == 0)
                const NoTransactionScreen(),
              // AddSubscription()
              if (transactionList > 0)
                const SizedBox(height: TSizes.xs,),
              if (transactionList > 0)
                Column(
                  children: [
                    TListLayout(
                        itemCount: 10,
                        itemBuilder: (_, index) => const TransactionList(),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
