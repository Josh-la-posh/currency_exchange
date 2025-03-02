import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/wallet/controller/bank_controller.dart';
import 'package:pouch/features/withdrawals/screens/foreign_withdrawal.dart';
import 'package:pouch/features/withdrawals/screens/local_withdrawal.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class WithdrawalScreen extends StatelessWidget {
  WithdrawalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BankController addBankController = Get.put(BankController());
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        leading: Obx(() => IconButton(
          onPressed: addBankController.bankAccountDetails.value.account_name == null ?  () {
            addBankController.clearData();
            Get.back();
          } : null,
          icon: addBankController.bankAccountDetails.value.account_name == null
              ? const Icon(Icons.keyboard_arrow_left_outlined)
              : const Text(''),
          style: IconButton.styleFrom(
              foregroundColor: TColors.primary,
              iconSize: 35
          ),
        )),
        title: Text(
          'Withdrawal',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 20,),
            GestureDetector(
              onTap: () => Get.to(() => LocalWithdrawalScreen()),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: TColors.secondaryBorder,
                ),
                child: Row(
                  children: [
                    Icon(Icons.account_balance_wallet, color: TColors.primary,),
                    SizedBox(width: 8),
                    Text('Local Withdrawal',
                      style: TextStyle(
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                          fontSize: 13,
                          fontWeight: TSizes.fontWeightLg
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: () => Get.to(() => ForeignWithdrawalScreen()),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: TColors.secondaryBorder,
                ),
                child: Row(
                  children: [
                    Icon(Icons.account_balance_wallet, color: TColors.primary,),
                    SizedBox(width: 8),
                    Text('Foreign Withdrawal',
                      style: TextStyle(
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                          fontSize: 13,
                          fontWeight: TSizes.fontWeightLg
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
