import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/profile/screens/bank_account/add_bank_account.dart';
import 'package:pouch/utils/constants/sizes.dart';
import '../../../../common/widgets/buttons/floating_button.dart';
import '../../../../utils/layouts/list_layout.dart';
import '../../../wallet/controller/wallet_controller.dart';
import '../../widgets/bank/bank_item.dart';

class BankAccountScreen extends StatelessWidget {
  final walletController = Get.find<WalletController>();
  @override
  Widget build(BuildContext context) {
    final banks = walletController.bankAccounts;
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: darkMode ? TColors.textPrimary.withOpacity(0) : Colors.white,
        // surfaceTintColor: darkMode ? TColors.textPrimary.withOpacity(0) : Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
          style: IconButton.styleFrom(
            foregroundColor: Colors.grey,
            iconSize: TSizes.iconBackSize,
          ),
          hoverColor: Colors.transparent,
        ),
        title: Text(
          'Bank Accounts',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: Obx(() => SingleChildScrollView(
        child: TListLayout(
          itemCount: banks.length,
          itemBuilder: (_, index) {
            final item = banks[index];
            return BankAccountItem(item: item);
          },
        ),
      )),
      floatingActionButton: TFloatingButton(
        onPressed: (){
          Get.to(() => AddBankAccountScreen());
        },
      ),
    );
  }
}

