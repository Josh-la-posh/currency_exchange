import 'package:flutter/material.dart';
import 'package:swappr/features/transaction/models/transaction_entity.dart';
import 'package:swappr/features/transaction/widgets/transaction_details.dart';
import 'package:swappr/utils/constants/image_strings.dart';
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
            hoverColor: Colors.transparent,
            onTap: (){
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (cdx) => TransactionDetails(item: item,)
              );
            },
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.only(top: 5),
                        child: TransactionIcon(height: 16)
                    ),
                    const SizedBox(width: TSizes.lg,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (item.rate != null)
                            RichText(
                                text: TextSpan(
                                    style: Theme.of(context).textTheme.titleSmall,
                                    children: <TextSpan> [
                                      TextSpan(
                                          text:'${THelperFunctions.moneyFormatter(THelperFunctions.getStringMultiplication(item.rate.toString(), item.amount))} ${item.debitedCurrency} ',
                                          style: const TextStyle(fontWeight: TSizes.fontWeightLg)
                                      ),
                                    ]
                                )
                            ),
                            if (item.rate != null)
                            Image(image: AssetImage(TImages.handIcon), height: 17,),
                            RichText(
                                text: TextSpan(
                                    style: Theme.of(context).textTheme.titleSmall,
                                    children: <TextSpan> [
                                      TextSpan(
                                          text:'${THelperFunctions.moneyFormatter(item.amount)} ${item.creditedCurrency}',
                                          style: const TextStyle(fontWeight: TSizes.fontWeightLg)
                                      ),
                                    ]
                                )
                            ),
                          ],
                        ),
                        RichText(
                            text: TextSpan(
                                style: Theme.of(context).textTheme.labelSmall,
                                children: <TextSpan> [
                                  TextSpan(
                                      text: '${item.status}',
                                      style: TextStyle(
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
                                  text: item.rate == null ? '' : '${item.rate.toString()} ${item.debitedCurrency} // ${item.creditedCurrency}',
                                  style: const TextStyle(color: TColors.primary)
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
                                      color: TColors.primary,
                                      fontSize: 10.5
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
