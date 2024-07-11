import 'package:flutter/material.dart';
import 'package:pouch/features/transaction/models/transaction_entity.dart';
import 'package:pouch/features/transaction/widgets/transaction_details.dart';
import 'package:pouch/utils/constants/image_strings.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
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
                                          text:'${THelperFunctions.moneyFormatter(THelperFunctions.getStringMultiplication(item.rate.toString(), item.amount.toString()))}',
                                          style: const TextStyle(
                                              fontWeight: TSizes.fontWeightLg,
                                          )
                                      ),
                                      TextSpan(
                                          text:' ${item.debitedCurrency} ',
                                          style: const TextStyle(
                                              fontWeight: TSizes.fontWeightLg,
                                              fontSize: 12
                                          )
                                      ),
                                    ]
                                )
                            ),
                            if (item.rate != null)
                            Image(image: AssetImage(TImages.handIcon), height: 15, color: TColors.primary,),
                            RichText(
                                text: TextSpan(
                                    style: Theme.of(context).textTheme.bodyMedium,
                                    children: <TextSpan> [
                                      TextSpan(
                                          text:'${THelperFunctions.moneyFormatter(item.amount.toString())}',
                                          style: const TextStyle(
                                              fontWeight: TSizes.fontWeightLg,
                                          )
                                      ),
                                      TextSpan(
                                          text:' ${item.creditedCurrency != null ? item.creditedCurrency : item.debitedCurrency}',
                                          style: const TextStyle(
                                              fontWeight: TSizes.fontWeightLg,
                                              fontSize: 12
                                          )
                                      ),
                                    ]
                                )
                            ),
                          ],
                        ),
                        RichText(
                            text: TextSpan(
                                style: Theme.of(context).textTheme.labelMedium,
                                children: <TextSpan> [
                                  TextSpan(
                                      text: '${item.status}',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
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
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: <TextSpan> [
                              TextSpan(
                                  text: item.rate == null ? '' : '${item.rate.toString()}',
                                  style: const TextStyle(
                                      color: TColors.primary,
                                      fontWeight: TSizes.fontWeightLg
                                  )
                              ),
                              TextSpan(
                                  text: item.rate == null ? '' : ' ${item.debitedCurrency} // ${item.creditedCurrency}',
                                  style: const TextStyle(
                                    color: TColors.primary,
                                      fontWeight: TSizes.fontWeightLg,
                                    fontSize: 12
                                  )
                              ),
                            ]
                        )
                    ),
                    RichText(
                        text: TextSpan(
                            style: Theme.of(context).textTheme.labelSmall,
                            children: <TextSpan> [
                              TextSpan(
                                  text: '${THelperFunctions.getFormattedDate(item.createdDate.toString())}  ${THelperFunctions.getFormattedTime(item.createdDate.toString())}',
                                  style: TextStyle(
                                      color: TColors.primary,
                                      fontSize: 9,
                                    fontWeight: FontWeight.w700
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
