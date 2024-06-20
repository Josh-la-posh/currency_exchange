import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';

import '../../../data/provider/transaction_provider.dart';
import '../../../utils/constants/colors.dart';
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
        itemCount: 4,
        itemBuilder: (_, index) {
          final item = provider.transactions[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        RichText(
                            text: TextSpan(
                                style: Theme.of(context).textTheme.bodySmall,
                                children: <TextSpan> [
                                  TextSpan(
                                      text:'${item!.rate == null ? '' : THelperFunctions.moneyFormatter(THelperFunctions.getStringMultiplication(item.rate.toString(), item.amount))} ${item.rate == null ? '' : item.debitedCurrency} ${item.rate == null ? '' : '-'} ${THelperFunctions.moneyFormatter(item.amount)} ${item.creditedCurrency}',
                                      style:  TextStyle(
                                          fontSize: 10,
                                          fontWeight: TSizes.fontWeightMd,
                                          color: darkMode ? Colors.white : Colors.black
                                      )
                                  ),
                                ]
                            )
                        ),
                        const SizedBox(height: 5,),
                        Text(
                          item.status.toString(),
                          style: const TextStyle(
                              fontSize: 7,
                              fontWeight: FontWeight.w700,
                              color: TColors.primary,
                              fontFamily: 'Roboto'
                          ),
                        )

                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.rate == null ? '' : '${item.rate.toString()} ${item.debitedCurrency} // ${item.creditedCurrency}',
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: TColors.primary,
                              fontFamily: 'Roboto'
                          ),
                        ),
                        const SizedBox(height: 2,),
                        Text(
                          '${THelperFunctions.getFormattedDate(item.createdDate)}  ${THelperFunctions.getFormattedTime(item.createdDate)}',
                          style: const TextStyle(
                              fontSize: 8.3,
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