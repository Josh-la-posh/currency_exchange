import 'package:flutter/material.dart';
import 'package:swappr/features/transaction/models/transaction_entity.dart';
import 'package:swappr/features/transaction/widgets/transaction_details.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';
import '../../../common/widgets/divider.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../icons/svg.dart';

class TransactionItem extends StatelessWidget {
  final TransactionEntity item;
  const TransactionItem({
    super.key,
    required this.item
  });

  @override
  Widget build(BuildContext context) {
    String? status = item.status;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: TSizes.md),
          child: ListTile(
            onTap: (){
              showModalBottomSheet(
                  // backgroundColor: TColors.white,
                  isScrollControlled: true,
                  context: context,
                  builder: (cdx) => TransactionDetails(item: item,)
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
                                children: <TextSpan> [
                                  TextSpan(
                                      // text: '400 GPB - 20,000 NGN',
                                      text:'${item!.rate == null ? '' : THelperFunctions.moneyFormatter(THelperFunctions.getStringMultiplication(item.rate.toString(), item.amount))} ${item.rate == null ? '' : item.debitedCurrency} ${item.rate == null ? '' : '-'} ${THelperFunctions.moneyFormatter(item.amount)} ${item.creditedCurrency}',
                                      style: const TextStyle(fontSize: TSizes.fontSize11, fontWeight: TSizes.fontWeightLg)
                                  ),
                                ]
                            )
                        ),
                        RichText(
                            text: TextSpan(
                                style: Theme.of(context).textTheme.labelSmall,
                                children: <TextSpan> [
                                  TextSpan(
                                      text: '${item.status}',
                                      style: TextStyle(
                                        fontSize: TSizes.fontSize9,
                                        color: status == 'in progress'
                                            ? TColors.golden
                                            : status == 'Successful'
                                            ? TColors.primary
                                            : status == 'successful'
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
                            children: <TextSpan> [
                              TextSpan(
                                  // text: '600 NGN // GBP ',
                                  text: item.rate == null ? '' : '${item.rate.toString()} ${item.debitedCurrency} // ${item.creditedCurrency}',
                                  style: const TextStyle(fontSize: TSizes.fontSize11, color: TColors.primary)
                              ),
                            ]
                        )
                    ),
                    RichText(
                        text: TextSpan(
                            style: Theme.of(context).textTheme.labelSmall,
                            children: <TextSpan> [
                              TextSpan(
                                  text: '${THelperFunctions.getFormattedDate(item.createdDate)}  ${THelperFunctions.getFormattedTime(item.createdDate)}',
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
