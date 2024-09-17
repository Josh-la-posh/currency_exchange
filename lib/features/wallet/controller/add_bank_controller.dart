import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pouch/features/wallet/controller/wallet_controller.dart';
import 'package:pouch/features/wallet/models/bank_list.dart';
import 'package:pouch/features/wallet/models/verify_bank_account_model.dart';

class AddBankController extends GetxController {
  var showErrorText = false.obs;
  final walletController = Get.find<WalletController>();
  var isSubmitting = false.obs;
  final TextEditingController accountNumberController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    accountNumberController.dispose();
    super.onClose();
  }

  void showErrorMessage() {
    showErrorText.value = true;
    Timer(Duration(seconds: 3), () {
      showErrorText.value = false;
    });
  }

  void submitForm() {
    final detail = walletController.bankAccountDetails.value;
    final bank = walletController.selectedBank.value;
    if (formKey.currentState!.validate()) {
      if (bank.name == null) {
        showErrorMessage();
      } else {
        if (detail.account_number == null) {
          walletController.verifyBankAccount(
              accountNumber: accountNumberController.text,
              bankCode: bank.code.toString()
          );
        } else {
          walletController.addingLocalBank(
              accountNumber: detail.account_number.toString(),
              accountName: detail.account_name.toString(),
              bankName: bank.code.toString(),
              bankCode: bank.code.toString(),
              onSubmit: () {
                accountNumberController.clear();
              }
          );
        }
      }
    }
  }

  void clearData() {
    accountNumberController.clear();
    walletController.selectedBank.value = BankListModel();
    walletController.bankAccountDetails.value = VerifyBankAccountModel();
  }
}