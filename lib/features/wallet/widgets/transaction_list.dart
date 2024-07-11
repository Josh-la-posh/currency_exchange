import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';

import '../../../data/provider/transaction_provider.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';

class WalletTransactionList extends StatelessWidget {
  const WalletTransactionList({
    super.key,
    required this.darkMode,
  });

  final bool darkMode;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TransactionProvider>(context);
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: provider.transactions.length > 3 ? 3 : provider.transactions.length,
        itemBuilder: (_, index) {
          final item = provider.transactions[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        // color: Color(0xFFDBC8C8).withOpacity(0.71),
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child: const Image(image: AssetImage('assets/icons/wallet_transaction.png')),
                    ),
                    const SizedBox(width: 15,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            if (item.rate != null)
                            RichText(
                                text: TextSpan(
                                    style: Theme.of(context).textTheme.bodyMedium,
                                    children: <TextSpan> [
                                      TextSpan(
                                          text:'${THelperFunctions.moneyFormatter(THelperFunctions.getStringMultiplication(item.rate.toString(), item.amount.toString()))} ${item.debitedCurrency} ',
                                          style:  TextStyle(
                                              fontSize: 13,
                                              fontWeight: TSizes.fontWeightMd,
                                              color: darkMode ? Colors.white : Colors.black
                                          )
                                      ),
                                    ]
                                )
                            ),
                            if (item.rate != null)
                              Image(image: AssetImage(TImages.handIcon), height: 15,),
                            RichText(
                                text: TextSpan(
                                    style: Theme.of(context).textTheme.bodyMedium,
                                    children: <TextSpan> [
                                      TextSpan(
                                          text:'${THelperFunctions.moneyFormatter(item.amount.toString())} ${item.creditedCurrency != null ? item.creditedCurrency : item.debitedCurrency}',
                                          style:  TextStyle(
                                              fontSize: 13,
                                              fontWeight: TSizes.fontWeightMd,
                                              color: darkMode ? Colors.white : Colors.black
                                          )
                                      ),
                                    ]
                                )
                            ),
                          ],
                        ),
                        const SizedBox(height: 5,),
                        Text(
                          item.status.toString(),
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: TColors.primary,
                              fontFamily: 'Roboto'
                          ),
                        )

                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          item.rate == null ? '' : '${item.rate.toString()} ${item.debitedCurrency} // ${item.creditedCurrency}',
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: TColors.primary,
                              fontFamily: 'Roboto'
                          ),
                        ),
                        const SizedBox(height: 2,),
                        Text(
                          '${THelperFunctions.getFormattedDate(item.createdDate.toString())}  ${THelperFunctions.getFormattedTime(item.createdDate.toString())}',
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: TColors.primary,
                              fontFamily: 'Roboto'
                          ),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20,),
                Container(
                  height: 1,
                  width: double.infinity,
                  decoration:BoxDecoration(
                    color: Colors.black.withOpacity(0.05),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}