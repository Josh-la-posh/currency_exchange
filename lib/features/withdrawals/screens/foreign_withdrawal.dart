import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/profile/screens/bank_account/add_foreign_bank.dart';
import 'package:pouch/features/wallet/controller/bank_controller.dart';
import 'package:pouch/features/withdrawals/screens/local_withdrawal.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class ForeignWithdrawalScreen extends StatelessWidget {
  ForeignWithdrawalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BankController controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.keyboard_arrow_left_outlined),
          style: IconButton.styleFrom(
            foregroundColor: TColors.primary,
            iconSize: 35
          ),
        ),
        title: Text(
          'Foreign Payout',
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
              onTap: () => controller.viewDirectPayout.value = !controller.viewDirectPayout.value,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: TColors.secondaryBorder,
                ),
                child: Row(
                  children: [
                    Icon(Icons.account_balance_wallet, color: TColors.primary,),
                    SizedBox(width: 8),
                    Text('Direct Payout',
                      style: TextStyle(
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                          fontSize: 13,
                          fontWeight: TSizes.fontWeightLg
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.keyboard_arrow_down_rounded)
                  ],
                ),
              ),
            ),
            Obx(() {
              if (controller.viewDirectPayout.value) {
                return SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(height: 20,),
                      SizedBox(
                        width: Get.width * 0.75,
                        child: ListTile(
                          onTap: () {},
                          hoverColor: TColors.secondaryBorder,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: TColors.primary),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          title: Text('USD', style: TextStyle(
                              color: TColors.primary,
                              fontWeight: TSizes.fontWeightLg,
                              fontSize: 15
                          ),),
                        ),
                      ),
                      SizedBox(height: 20,),
                      SizedBox(
                        width: Get.width * 0.75,
                        child: ListTile(
                          onTap: () {},
                          hoverColor: TColors.secondaryBorder,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: TColors.primary),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          title: Text('EUR', style: TextStyle(
                              color: TColors.primary,
                              fontWeight: TSizes.fontWeightLg,
                              fontSize: 15
                          ),),
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: Get.width * 0.75,
                        child: ListTile(
                          onTap: () {},
                          hoverColor: TColors.secondaryBorder,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: TColors.primary),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          title: Text('GPB', style: TextStyle(
                              color: TColors.primary,
                              fontWeight: TSizes.fontWeightLg,
                              fontSize: 15
                          ),),
                        ),
                      ),
                      SizedBox(height: 20,),
                    ],
                  ),
                );
              } else {
                return SizedBox();
              }
            }),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: () => Get.to(() => AddForeignBankAccountScreen()),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: TColors.secondaryBorder,
                ),
                child: Row(
                  children: [
                    Icon(Icons.add_circle_outlined, color: TColors.primary,),
                    SizedBox(width: 8),
                    Text('Add USD Domiciliary',
                      style: TextStyle(
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                          fontSize: 13,
                          fontWeight: TSizes.fontWeightLg
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.keyboard_arrow_down_rounded)
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
