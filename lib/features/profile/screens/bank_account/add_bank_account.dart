import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/wallet/controller/add_bank_controller.dart';
import 'package:pouch/common/widgets/buttons/elevated_button.dart';
import 'package:pouch/common/widgets/buttons/outlined_button.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/validators/validation.dart';
import '../../../payment_method/widgets/bank_list.dart';

class AddBankAccountScreen extends StatelessWidget {
  final AddBankController addBankController = Get.put(AddBankController());

  AddBankAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    if (addBankController.walletController.bankList.isEmpty) {
      addBankController.walletController.fetchBankList();
    }
    addBankController.walletController.verifyingAccount.value = false;
    return Scaffold(
      appBar: AppBar(
        leading: Obx(() => IconButton(
          onPressed: addBankController.walletController.bankAccountDetails.value.account_name == null ?  () {
            addBankController.clearData();
            Get.back();
          } : null,
          icon: addBankController.walletController.bankAccountDetails.value.account_name == null
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
      body: Obx(() => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace * 2, vertical: TSizes.defaultSpace),
          child: Form(
            key: addBankController.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (addBankController.walletController.bankAccountDetails.value.account_name == null)
                  RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.bodyMedium,
                          children: const <TextSpan> [
                            TextSpan(
                                text: 'Select Bank Provider',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                )
                            ),
                          ]
                      )
                  ),
                const SizedBox(height: TSizes.defaultSpace / 1.7),
                // Search bank list
                BankList(),
                const SizedBox(height: TSizes.defaultSpace),

                // Account number
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: darkMode ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                fontFamily: 'Roboto'
                            ),
                            children: const <TextSpan> [
                              TextSpan(
                                text: 'Account Number',
                              ),
                            ]
                        )
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      validator: TValidator.acctNumValidator,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: addBankController.accountNumberController,
                      enabled: addBankController.walletController.bankAccountDetails.value.account_name == null,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                if (addBankController.walletController.bankAccountDetails.value.account_name != null)
                  const SizedBox(height: TSizes.defaultSpace),

                // Account name
                if (addBankController.walletController.bankAccountDetails.value.account_name != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: darkMode ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  fontFamily: 'Roboto'
                              ),
                              children: const <TextSpan> [
                                TextSpan(
                                  text: 'Account Name',
                                ),
                              ]
                          )
                      ),
                      const SizedBox(height: 10,),
                      TextFormField(
                        enabled: false,
                        initialValue: addBankController.walletController.bankAccountDetails.value.account_name == null
                            ? ''
                            : addBankController.walletController.bankAccountDetails.value.account_name,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),

                const SizedBox(height: TSizes.defaultSpace * 4,),

                // Submit Button
                TElevatedButton(
                    onTap: addBankController.walletController.verifyingAccount.value
                        ? null
                        : addBankController.submitForm,
                    buttonText: addBankController.walletController.bankAccountDetails.value.account_name == null
                        ? addBankController.walletController.verifyingAccount.value
                        ? 'Verifying ...'
                        : 'Proceed'
                        : 'Submit'
                ),

                // Cancel Button
                if (addBankController.walletController.bankAccountDetails.value.account_name != null)
                  const SizedBox(height: TSizes.defaultSpace),

                if (addBankController.walletController.bankAccountDetails.value.account_name != null)
                  TOutlinedButton(
                      onTap: () => addBankController.clearData(),
                      buttonText: 'Cancel'
                  )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
