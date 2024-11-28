import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/wallet/models/bank_list.dart';
import 'package:pouch/features/wallet/models/verify_bank_account_model.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/responses/handleApiError.dart';
import '../../../utils/shared/error_dialog_response.dart';
import '../apis/api.dart';
import '../models/get_bank_account.dart';

class BankController extends GetxController {
  var showErrorText = false.obs;
  var isSubmitting = false.obs;
  var verifyingAccount = false.obs;
  var isLocalBankLoading = false.obs;
  var bankAccountDetails = VerifyBankAccountModel().obs;
  var selectedBank = BankListModel().obs;
  var bankAccounts = <GetBankAccountModel>[].obs;
  var bankList = <BankListModel>[].obs;
  var filteredBanks = <BankListModel>[].obs;
  
  
  final TextEditingController accountNumberController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    accountNumberController.dispose();
    accountNumberController.clear();
    selectedBank.value = BankListModel();
    bankAccountDetails.value = VerifyBankAccountModel();
    bankAccounts.clear();
    bankList.clear();
    super.onClose();
  }

  void filterBanks(String searchText) {
    filteredBanks.value = bankList.where((bank) =>
        bank.name!.toLowerCase().contains(searchText.toLowerCase())
    ).toList();
  }

  Future<void> addingLocalBank({
    required String accountNumber,
    required String accountName,
    required String bankName,
    required String bankCode,
    required VoidCallback onSubmit
  }) async {
    try {
      verifyingAccount(true);
      final response = await WalletServices.instance.addLocalBank(
          accountNumber: accountNumber,
          accountName: accountName,
          bankName: bankName,
          bankCode: bankCode
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        await fetchLocalBank();
        bankAccountDetails.value = VerifyBankAccountModel();
        selectedBank.value = BankListModel();
        onSubmit();
        Get.back();
      } else {
        print('Failed to add local bank: ${response.data['message']}');
      }
    } catch (err) {
      showErrorAlertHelper(errorMessage: handleApiFormatError(err));
    } finally {
      verifyingAccount(false);
    }
  }

  Future<void> verifyBankAccount({
    required String accountNumber,
    required String bankCode,
  }) async {
    try {
      verifyingAccount(true);
      final response = await WalletServices.instance.verifyBankAccount(
          accountNumber: accountNumber,
          bankCode: bankCode
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = response.data['data'];
        bankAccountDetails(VerifyBankAccountModel(
            account_number: data['account_number'],
            account_name: data['account_name'],
            bank_id: data['bank_id']
        ));
      } else {
        print('Failed to verify bank account: ${response.data['message']}');
      }
    } catch (err) {
      showErrorAlertHelper(errorMessage: handleApiFormatError(err));
    } finally {
      verifyingAccount(false);
    }
  }

  Future<void> fetchLocalBank() async {
    try {
      bankAccounts.isEmpty && isLocalBankLoading(true);
      final response = await WalletServices.instance.fetchLocalBank();
      if (response.statusCode == 200) {
        final data = response.data;
        List<GetBankAccountModel> fetchedBankAccounts = (data as List)
            .map((json) => GetBankAccountModel.fromJson(json)).toList();
        bankAccounts.assignAll(fetchedBankAccounts);
      } else {
        print('Failed to fetch local bank accounts: ${response.data['message']}');
      }
    } catch (err) {
      showErrorAlertHelper(errorMessage: handleApiFormatError(err));
    } finally {
      isLocalBankLoading(false);
    }
  }

  Future<void> fetchBankList() async {
    try {
      final response = await WalletServices.instance.fetchBankList();
      if (response.statusCode == 200) {
        final data = response.data['data'];
        print(data);
        List<BankListModel> fetchedBankLists = (data as List)
            .map((json) => BankListModel.fromJson(json)).toList();
        bankList.assignAll(fetchedBankLists);
      } else {
        print('Failed to fetch bank list: ${response.data['message']}');
      }
    } catch (err) {
      print('Error occurred: $err');
    } finally {
    }
  }

  Future<void> deleteLocalBankAccount({required String id}) async {
    try {
      Get.snackbar('', 'Deleting local bank', backgroundColor: TColors.primary);
      final response = await WalletServices.instance.deleteLocalBankAccount(id: id);
      if (response.statusCode == 200) {
        await fetchLocalBank();
        Get.snackbar('Success', 'Bank account deleted successfully', backgroundColor: Colors.green);
      } else {
        print('Failed to delete bank account: ${response.data['message']}');
      }
    } catch (err) {
      showErrorAlertHelper(errorMessage: handleApiFormatError(err));
    } finally {
      Get.closeAllSnackbars();
    }
  }

  void submitForm() {
    final detail = bankAccountDetails.value;
    final bank = selectedBank.value;
    if (formKey.currentState!.validate()) {
      if (bank.name == null) {
        showErrorMessage();
      } else {
        if (detail.account_number == null) {
          verifyBankAccount(
              accountNumber: accountNumberController.text,
              bankCode: bank.code.toString()
          );
        } else {
          addingLocalBank(
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

  void showErrorMessage() {
    showErrorText.value = true;
    Timer(Duration(seconds: 3), () {
      showErrorText.value = false;
    });
  }

  void clearData() {
    accountNumberController.clear();
    selectedBank.value = BankListModel();
    bankAccountDetails.value = VerifyBankAccountModel();
    bankAccounts.clear();
    bankList.clear();
  }
}