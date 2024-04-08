import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:swappr/common/styles/spacing_styles.dart';
import 'package:swappr/common/widgets/buttons/app_bar_widget.dart';
import 'package:swappr/features/dashboard/screens/profile/widgets/bank/bank_details.dart';
import 'package:swappr/utils/constants/sizes.dart';

import '../../../../common/widgets/buttons/floating_button.dart';
import '../../../../utils/layouts/list_layout.dart';

class BankAccounts extends StatelessWidget {
  const BankAccounts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: TSpacingStyle.homePadding,
        child: Column(
          children: [
            const AppBarWidget(heading: '',),
            const SizedBox(height: TSizes.lg,),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Bank Accounts', style: Theme.of(context).textTheme.headlineLarge,),
                      const SizedBox(height: TSizes.md,),
                      Text(
                          'Here are a list of all the bank accounts you have created.',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems,),
                      TListLayout(
                          itemCount: 9,
                          itemBuilder: (_, index) => const  BankDetails()
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: TFloatingButton(
        onPressed: (){},
      ),
    );
  }
}

