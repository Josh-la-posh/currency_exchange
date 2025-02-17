import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/wallet/apis/api.dart';
import 'package:pouch/features/wallet/models/get_wallet.dart';
import 'package:pouch/utils/constants/enums.dart';
import 'package:pouch/utils/shared/error_dialog_response.dart';
import '../../../utils/constants/colors.dart';

class WalletController extends GetxController {
  final CancelToken requestCancelToken = CancelToken();
  var showBalance = false.obs;
  var showWalletLists = false.obs;
  var isWalletLoading = false.obs;
  var isDefaultWalletLoading = false.obs;
  var isCreatingWallet = false.obs;
  var isCreatingDefaultWallet = false.obs;
  var showWalletBalance = false.obs;
  var selectedWalletCurrency = WalletCurrency.NGN.obs;
  var defaultWallet = GetWalletModel().obs;
  var wallets = <GetWalletModel>[].obs;
  var showBankTransferOption = false.obs;
  var showErrorText = false.obs;
  var walletCurrencies = WalletCurrency.values.obs;
  var selectedAccountCurrency = WalletCurrency.NGN.obs;

  @override
  void onInit() {
    super.onInit();
    fetchWallets(currency: '');
  }

  void updateShowWalletList() {
    showWalletLists.value = !showWalletLists.value;
  }

  void updateSelectedCurrency(WalletCurrency currency) {
    selectedWalletCurrency.value = currency;
  }

  void updateSelectedAccount(WalletCurrency currency) {
    selectedAccountCurrency.value = currency;
  }

  void toggleBankTransferOption() {
    showBankTransferOption.value = !showBankTransferOption.value;
  }

  void setShowErrorText(bool value) {
    showErrorText.value = value;
  }

  Future<void> creatingWallet({required String currency, required VoidCallback onSuccess}) async {
    try {
      isCreatingWallet(true);
      final response = await WalletServices.instance.createWallet(
          currency: currency,
          onFailure: () {
            isCreatingWallet(false);
          }
      );
      await fetchWallets(currency: '');
      onSuccess();
      Get.snackbar('Success', 'Your wallet has been created successfully', backgroundColor: Colors.green);
    } catch (err) {
      showErrorAlertHelper(errorMessage: err.toString());
    } finally {
      isCreatingWallet(false);
    }
  }

  Future<void> creatingDefaultWallet({required String walletId}) async {
    try {
      Get.snackbar('', 'Setting default wallet', backgroundColor: TColors.primary);
      isCreatingDefaultWallet(true);
      await WalletServices.instance.createDefaultWallet(
          walletId: walletId,
          onFailure: () {
            isCreatingDefaultWallet(false);
          }
      );
      await fetchingDefaultWallet();

    } catch (err) {
      showErrorAlertHelper(errorMessage: err.toString());
    } finally {
      Get.closeAllSnackbars();
      isCreatingDefaultWallet(false);
    }
  }

  Future<void> fetchWallets({required String currency}) async {
    try {
      isWalletLoading(true);
      final response = await WalletServices.instance.fetchWallets(
          currency: currency,
          onFailure: () {
            isWalletLoading(false);
          }
      );
      final data = response.data;
      List<GetWalletModel> fetchedWallets = (data as List)
          .map((json) => GetWalletModel.fromJson(json)).toList();
      wallets.assignAll(fetchedWallets);
      await fetchingDefaultWallet();
    } catch (err) {
      showErrorAlertHelper(errorMessage: err.toString());
    } finally {
      isWalletLoading(false);
    }
  }

  Future<void> fetchingDefaultWallet() async {
    try {
      isDefaultWalletLoading(true);
      final response = await WalletServices.instance.fetchDefaultWallet(
          onFailure: () {
            isDefaultWalletLoading(false);
          }
      );
      final data = response.data;
      defaultWallet(GetWalletModel(
          id: data['id'],
          currency: data['currency'],
          balance: data['balance'],
          isActive: data['isActive'],
          pendingWithdrawals: data['pendingWithdrawals'],
          createdDate: data['createdDate'],
          lastModifiedDate: data['lastModifiedDate']
      ));
    } catch (err) {
      // showErrorAlertHelper(errorMessage: err.toString());
    } finally {
      isDefaultWalletLoading(false);
    }
  }

  void clearData() {
    defaultWallet.value = GetWalletModel();
    wallets.clear();
  }

  @override
  void dispose() {
    requestCancelToken.cancel('Component disposed');
    super.dispose();
  }
}
