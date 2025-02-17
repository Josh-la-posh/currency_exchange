import 'dart:async';
import 'package:dio/dio.dart';
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
  final CancelToken requestCancelToken = CancelToken();
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
      await WalletServices.instance.addLocalBank(
          accountNumber: accountNumber,
          accountName: accountName,
          bankName: bankName,
          bankCode: bankCode,
          onFailure: () {verifyingAccount(false);}
      );
      await fetchLocalBank();
      bankAccountDetails.value = VerifyBankAccountModel();
      selectedBank.value = BankListModel();
      onSubmit();
      Get.back();
    } catch (err) {
      showErrorAlertHelper(errorMessage: err.toString());
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
          bankCode: bankCode,
          onFailure: () {
            verifyingAccount(false);
          }
      );
      var data = response.data['data'];
      bankAccountDetails(VerifyBankAccountModel(
          account_number: data['account_number'],
          account_name: data['account_name'],
          bank_id: data['bank_id']
      ));
    } catch (err) {
      showErrorAlertHelper(errorMessage: err.toString());
    } finally {
      verifyingAccount(false);
    }
  }

  Future<void> fetchLocalBank() async {
    try {
      bankAccounts.isEmpty && isLocalBankLoading(true);
      final response = await WalletServices.instance.fetchLocalBank(
          onFailure: () {
            isLocalBankLoading(false);
          }
      );
      final data = response.data;
      List<GetBankAccountModel> fetchedBankAccounts = (data as List)
          .map((json) => GetBankAccountModel.fromJson(json)).toList();
      bankAccounts.assignAll(fetchedBankAccounts);
    } catch (err) {
      showErrorAlertHelper(errorMessage: err.toString());
    } finally {
      isLocalBankLoading(false);
    }
  }

  Future<void> fetchBankList() async {
    try {
      final response = await WalletServices.instance.fetchBankList(
          onFailure: () {}
      );
      final data = response.data['data'];
      print(data);
      List<BankListModel> fetchedBankLists = (data as List)
          .map((json) => BankListModel.fromJson(json)).toList();
      bankList.assignAll(fetchedBankLists);
    } catch (err) {
      print('Error occurred: $err');
    } finally {
    }
  }

  Future<void> deleteLocalBankAccount({required String id}) async {
    try {
      Get.snackbar('', 'Deleting local bank', backgroundColor: TColors.primary);
      final response = await WalletServices.instance.deleteLocalBankAccount(
          id: id,
          onFailure: () {
            Get.closeAllSnackbars();
          }
      );
      await fetchLocalBank();
      Get.snackbar('Success', 'Bank account deleted successfully', backgroundColor: Colors.green);
    } catch (err) {
      showErrorAlertHelper(errorMessage: err.toString());
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

  @override
  void dispose() {
    requestCancelToken.cancel('Component disposed');
    super.dispose();
  }
}