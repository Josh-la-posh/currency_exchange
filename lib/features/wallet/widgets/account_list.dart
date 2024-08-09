import 'package:flutter/material.dart';
import 'package:pouch/data/provider/transaction_provider.dart';
import 'package:pouch/data/provider/wallet_provider.dart';
import 'package:provider/provider.dart';

import '../../../data/modules/background_task.dart';
import '../../../utils/helpers/helper_functions.dart';

class AccountList extends StatelessWidget {
  const AccountList({super.key});

  @override
  Widget build(BuildContext context) {
    final _walletProvider = Provider.of<WalletProvider>(context);
    final _transactionProvider = Provider.of<TransactionProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Accounts',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 14),
        ),
        SizedBox(height: 5),
        _walletProvider.wallets.isNotEmpty
        ? ListView.builder(
          itemCount: _walletProvider.wallets.length,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            final item = _walletProvider.wallets[index];
            final isSelected = item.currency == _walletProvider.defaultWallet?.currency;

            return GestureDetector(
              onTap: () {
                print(_walletProvider.defaultWallet?.currency);
                NoLoaderService.instance.defaultWallet(
                  transactionProvider: _transactionProvider,
                  walletProvider: _walletProvider,
                  walletId: item.id.toString(),
                );
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: THelperFunctions.isDarkMode(context) ? Color(0xFF3E3E3E) : Color(0xFFF6F6F6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${item.currency} wallet', style: Theme.of(context).textTheme.labelSmall),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text(THelperFunctions.moneyFormatter(item.balance.toString()), style: Theme.of(context).textTheme.titleMedium),
                            SizedBox(width: 5),
                            Text(item.currency.toString(), style: Theme.of(context).textTheme.labelSmall),
                          ],
                        ),
                      ],
                    ),
                    if (isSelected)
                      const SizedBox(
                        width: 10,
                        child: Image(image: AssetImage('assets/icons/wallet_check.png')),
                      ),
                  ],
                ),
              ),
            );
          },
        )
        : SizedBox(height: 0,),
      ],
    );
  }
}
