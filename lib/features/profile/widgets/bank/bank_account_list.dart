import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swappr/data/provider/wallet_provider.dart';
import 'package:swappr/features/profile/widgets/bank/bank_item.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/constants/sizes.dart';

import '../../../../utils/layouts/list_layout.dart';

class BankAccountListScreen extends StatelessWidget {
  const BankAccountListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WalletProvider>(context);
    final banks = provider.savedBankAccounts;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(
                style: Theme.of(context).textTheme.titleLarge,
                children: const <TextSpan> [
                  TextSpan(
                    text: 'Bank Accounts',
                    style: TextStyle(
                      fontSize: 22
                    )
                  )
                ]
            )
        ),
        const SizedBox(height: TSizes.defaultSpace,),
        RichText(
            text: TextSpan(
                style: Theme.of(context).textTheme.labelMedium,
                children: const <TextSpan> [
                  TextSpan(
                      text: 'Here are the lists of all the bank accounts you have',
                  )
                ]
            )
        ),
        const SizedBox(height: TSizes.defaultSpace,),

        // List of saved bank accounts

        Column(
          children: [
            TListLayout(
                itemCount: banks.length,
                itemBuilder: (_, index) {
                  final item = banks[index];
                  return BankAccountItem(item: item, provider: provider,);
                }
            )
          ],
        )
      ],
    );
  }
}
