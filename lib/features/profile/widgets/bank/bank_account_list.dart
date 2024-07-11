import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import 'package:provider/provider.dart';
import 'package:pouch/data/provider/wallet_provider.dart';
import 'package:pouch/features/profile/widgets/bank/bank_item.dart';
import 'package:pouch/utils/constants/colors.dart';
import 'package:pouch/utils/constants/sizes.dart';

import '../../../../utils/layouts/list_layout.dart';

class BankAccountListScreen extends StatelessWidget {
  const BankAccountListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WalletProvider>(context);
    final banks = provider.savedBankAccounts;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [IconButton(
        onPressed: (){
          Get.back();},
        icon: const Icon(Icons.arrow_back_ios_sharp),
        style: IconButton.styleFrom(
            foregroundColor: TColors.primary,
            iconSize: TSizes.iconBackSize
        ),
        hoverColor: Colors.transparent,
      ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 30),
          child: RichText(
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
        ),
        const SizedBox(height: TSizes.defaultSpace),
        Container(
          width: THelperFunctions.screenWidth() * 0.7,
          padding: EdgeInsets.only(left: 20),
          child: RichText(
              text: TextSpan(
                  style: Theme.of(context).textTheme.labelMedium,
                  children: const <TextSpan> [
                    TextSpan(
                        text: 'Here are the lists of all the bank accounts you have',
                      style: TextStyle(
                        fontWeight: TSizes.fontWeightLg,
                        fontSize: 16
                      )
                    )
                  ]
              )
          ),
        ),
        const SizedBox(height: TSizes.defaultSpace/2,),

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
