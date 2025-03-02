import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/profile/screens/bank_account/add_foreign_bank.dart';
import 'package:pouch/features/profile/screens/bank_account/add_local_bank.dart';
import 'package:pouch/features/wallet/controller/bank_controller.dart';
import 'package:pouch/common/widgets/buttons/elevated_button.dart';
import 'package:pouch/common/widgets/buttons/outlined_button.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/validators/validation.dart';
import '../../../payment_method/widgets/bank_list.dart';

class AddBankAccountScreen extends StatelessWidget {
  AddBankAccountScreen({super.key});

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
          'Add Bank Account',
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
              onTap: () => Get.to(() => AddLocalBankAccountScreen()),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: TColors.secondaryBorder,
                ),
                child: Row(
                  children: [
                    Icon(Icons.credit_card, color: TColors.primary,),
                    SizedBox(width: 8),
                    Text('Local Bank',
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
              onTap: () => Get.to(() => AddForeignBankAccountScreen()),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: TColors.secondaryBorder,
                ),
                child: Row(
                  children: [
                    Icon(Icons.credit_card, color: TColors.primary,),
                    SizedBox(width: 8),
                    Text('Foreign Bank',
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
