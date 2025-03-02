import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/common/widgets/form/custom_input_field.dart';
import 'package:pouch/features/wallet/controller/bank_controller.dart';
import 'package:pouch/common/widgets/buttons/elevated_button.dart';
import 'package:pouch/common/widgets/buttons/outlined_button.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/validators/validation.dart';
import '../../../payment_method/widgets/bank_list.dart';

class AddForeignBankAccountScreen extends StatelessWidget {
  final BankController addBankController = Get.find();

  AddForeignBankAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    if (addBankController.bankList.isEmpty) {
      addBankController.fetchBankList();
    }
    addBankController.verifyingAccount.value = false;
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace),
          child: Form(
            key: addBankController.formKey,
            child: Column(
              children: [
                CustomInputField(label: 'Bank Name'),
                SizedBox(height: 20),
                CustomInputField(label: 'Account Name'),
                SizedBox(height: 20),
                CustomInputField(label: 'Swift Code'),
                SizedBox(height: 20),
                CustomInputField(label: 'Routing Code'),
                const SizedBox(height: TSizes.defaultSpace * 4,),

                // Submit Button
                TElevatedButton(
                    onTap: addBankController.verifyingAccount.value
                        ? null
                        : addBankController.submitForm,
                    buttonText: 'Proceed'
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
