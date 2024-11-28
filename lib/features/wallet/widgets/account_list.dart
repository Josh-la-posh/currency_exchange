import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/wallet/controller/wallet_controller.dart';
import 'package:pouch/utils/shimmer/wallet_shimmer.dart';
import '../../../utils/helpers/helper_functions.dart';

class AccountList extends StatelessWidget {
  AccountList({super.key});

  @override
  Widget build(BuildContext context) {
  final WalletController walletController = Get.find();

    return WalletListView(walletController: walletController);
  }
}

class WalletLoadingView extends StatelessWidget {
  const WalletLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12),
        WalletShimmer(),
      ],
    );
  }
}

class WalletListView extends StatelessWidget {
  final WalletController walletController;

  const WalletListView({required this.walletController, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Accounts',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 14),
        ),
        const SizedBox(height: 5),
        ListView.builder(
          itemCount: walletController.wallets.length,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            final item = walletController.wallets[index];

            return WalletItem(
              walletController: walletController,
              item: item,
              isSelected: item.currency == walletController.defaultWallet.value.currency,
              onTap: () {
                if (!walletController.isCreatingDefaultWallet.value) {
                  walletController.creatingDefaultWallet(walletId: item.id.toString());
                } else {
                  Get.snackbar(
                    '',
                    'A request is yet to be completed',
                    duration: const Duration(seconds: 4),
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }
}

class WalletItem extends StatelessWidget {
  final WalletController walletController;
  final dynamic item;
  final bool isSelected;
  final VoidCallback onTap;

  const WalletItem({required this.walletController, required this.item, required this.isSelected, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: THelperFunctions.isDarkMode(context) ? const Color(0xFF3E3E3E) : const Color(0xFFF6F6F6),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${item.currency} wallet', style: Theme.of(context).textTheme.labelSmall),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      THelperFunctions.moneyFormatter(item.balance.toString()),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(width: 5),
                    Text(item.currency.toString(), style: Theme.of(context).textTheme.labelSmall),
                  ],
                ),
              ],
            ),
            Obx(() => SizedBox(
              width: 10,
              child: item.currency == walletController.defaultWallet.value.currency
                  ? Image(image: AssetImage('assets/icons/wallet_check.png'))
                  : SizedBox(),
            )),
          ],
        ),
      ),
    );
  }
}
