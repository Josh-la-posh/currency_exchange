import 'package:flutter/material.dart';
import 'package:swappr/common/widgets/divider.dart';
import 'package:swappr/features/dashboard/screens/history/icons/svg.dart';
import 'package:swappr/features/dashboard/screens/history/widgets/transaction_details.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    const String status = 'in progress';
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: TSizes.md),
          child: ListTile(
            onTap: (){
              showModalBottomSheet(
                  backgroundColor: TColors.white,
                  isDismissible: false,
                  isScrollControlled: true,
                  enableDrag: false,
                  context: context,
                  builder: (cdx) => const TransactionDetails()
              );
            },
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    TransactionIcon(),
                    const SizedBox(width: TSizes.lg,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(
                                style: Theme.of(context).textTheme.labelSmall,
                                children: const <TextSpan> [
                                  TextSpan(
                                      text: '400 GPB - 20,000 NGN',
                                      style: TextStyle(fontSize: TSizes.fontSize11)
                                  ),
                                ]
                            )
                        ),
                        RichText(
                            text: TextSpan(
                                style: Theme.of(context).textTheme.labelSmall,
                                children: <TextSpan> [
                                  TextSpan(
                                      text: 'in progress',
                                      style: TextStyle(
                                        fontSize: TSizes.fontSize9,
                                        color: status == 'in progress'
                                            ? TColors.golden
                                            : status == 'completed'
                                            ? TColors.primary
                                            : TColors.danger,

                                      )
                                  ),
                                ]
                            )
                        ),
                      ],
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
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
                    RichText(
                        text: TextSpan(
                            style: Theme.of(context).textTheme.labelSmall,
                            children: <TextSpan> [
                              TextSpan(
                                  text: 'June 56, 10:00AM',
                                  style: TextStyle(
                                      color: TColors.textPrimary.withOpacity(0.5),
                                      fontSize: TSizes.fontSize9
                                  )
                              ),
                            ]
                        )
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        const DividerWidget()
      ],
    );
  }
}
