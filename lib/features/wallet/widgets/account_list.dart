import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/wallet/controller/wallet_controller.dart';
import '../../../utils/helpers/helper_functions.dart';

class AccountList extends StatelessWidget {
  final walletController = Get.find<WalletController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (walletController.wallets.isEmpty) {
        return Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: THelperFunctions.isDarkMode(context) ? Color(0xFF3E3E3E) : Color(0xFFF6F6F6),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('No wallet created'),
            ],
          ),
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Accounts',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 14),
            ),
            if (walletController.wallets.isNotEmpty && walletController.defaultWallet.value.currency == null)
              Text(
                'Please, select a default wallet below',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 12, color: Colors.red),
              ),
            SizedBox(height: 5),
            ListView.builder(
              itemCount: walletController.wallets.length,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                final item = walletController.wallets[index];
                final isSelected = item.currency == walletController.defaultWallet.value.currency;

                return GestureDetector(
                  onTap: () {
                    walletController.creatingDefaultWallet(walletId: item.id.toString());
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
          ],
        );
      }
    });
  }
}
