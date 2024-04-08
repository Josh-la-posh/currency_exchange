import 'package:flutter/material.dart';
import 'package:swappr/features/dashboard/screens/history/icons/svg.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/layouts/bottom_sheet_widget.dart';

import '../../../../../utils/constants/sizes.dart';

class TransactionDetails extends StatelessWidget {
  const TransactionDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return HalfBottomSheetWidget(
        title: 'Transaction Details',
        child: Column(
          children: [
            TransactionIcon(),
            const SizedBox(height: TSizes.spaceBtwElements,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                    text: TextSpan(
                        style: Theme.of(context).textTheme.headlineLarge,
                        children: <TextSpan> [
                          TextSpan(
                              text: '400 GBP ---',
                              style: TextStyle(color: TColors.textPrimaryO80)
                          )
                        ]
                    )
                ),
                RichText(
                    text: TextSpan(
                        style: Theme.of(context).textTheme.headlineLarge,
                        children: <TextSpan> [
                          TextSpan(
                              text: '20,000 NGN',
                              style: TextStyle(color: TColors.textPrimaryO80)
                          )
                        ]
                    )
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwElements,),
            RichText(
                text: TextSpan(
                    style: Theme.of(context).textTheme.labelMedium,
                    children: const <TextSpan> [
                      TextSpan(
                          text: '600 NGN // GBP',
                          style: TextStyle(fontSize: TSizes.fontSize11, color: TColors.primary)
                      ),
                    ]
                )
            ),
          ],
        )
    );
  }
}
