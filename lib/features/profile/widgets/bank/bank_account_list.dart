import 'package:flutter/material.dart';
import 'package:swappr/features/profile/widgets/bank/bank_item.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/constants/sizes.dart';

import '../../../../utils/layouts/list_layout.dart';

class BankAccountListScreen extends StatelessWidget {
  const BankAccountListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(
                style: Theme.of(context).textTheme.titleLarge,
                children: <TextSpan> [
                  TextSpan(
                    text: 'Bank Accounts',
                    style: TextStyle(
                      fontSize: 22
                    )
                  )
                ]
            )
        ),
        SizedBox(height: TSizes.defaultSpace,),
        RichText(
            text: TextSpan(
                style: Theme.of(context).textTheme.labelMedium,
                children: <TextSpan> [
                  TextSpan(
                      text: 'Here are the lists of all the bank accounts you have',
                  )
                ]
            )
        ),
        const SizedBox(height: TSizes.defaultSpace,),
        Column(
          children: [
            TListLayout(
                itemCount: 4,
                itemBuilder: (_, index) {
                  // final item = provider.subscriptions[index];
                  return BankAccountItem();
                }
            )
          ],
        )
      ],
    );
  }
}
