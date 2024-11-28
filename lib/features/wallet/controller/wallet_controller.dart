import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/transaction/controller/transaction_controller.dart';
import 'package:pouch/features/wallet/apis/api.dart';
import 'package:pouch/features/wallet/models/get_wallet.dart';
import 'package:pouch/utils/constants/enums.dart';
import 'package:pouch/utils/responses/handleApiError.dart';
import 'package:pouch/utils/shared/error_dialog_response.dart';
import '../../../utils/constants/colors.dart';

class WalletController extends GetxController {
  // final TransactionController transactionController = Get.put(TransactionController());
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
      final response = await WalletServices.instance.createWallet(currency: currency);
      if (response.statusCode == 200 || response.statusCode == 201) {
        await fetchWallets(currency: '');
        onSuccess();
        Get.snackbar('Success', 'Your wallet has been created successfully', backgroundColor: Colors.green);
      }
    } catch (err) {
      showErrorAlertHelper(errorMessage: handleApiFormatError(err));
    } finally {
      isCreatingWallet(false);
    }
  }

  Future<void> creatingDefaultWallet({required String walletId}) async {
    try {
      Get.snackbar('', 'Setting default wallet', backgroundColor: TColors.primary);
      isCreatingDefaultWallet(true);
      final response = await WalletServices.instance.createDefaultWallet(walletId: walletId);
      if (response.statusCode == 200 || response.statusCode == 201) {
        await fetchingDefaultWallet();
      } else {
        print('Failed to create default wallet: ${response.data['message']}');
      }
    } catch (err) {
      showErrorAlertHelper(errorMessage: handleApiFormatError(err));
    } finally {
      Get.closeAllSnackbars();
      isCreatingDefaultWallet(false);
    }
  }

  Future<void> fetchWallets({required String currency}) async {
    try {
      isWalletLoading(true);
      final response = await WalletServices.instance.fetchWallets(currency: currency);
      if (response.statusCode == 200) {
        final data = response.data;
        List<GetWalletModel> fetchedWallets = (data as List)
            .map((json) => GetWalletModel.fromJson(json)).toList();
        wallets.assignAll(fetchedWallets);
        await fetchingDefaultWallet();
        // await transactionController.fetchTransactions();
      } else {
        print('Failed to fetch wallets: ${response.data['message']}');
      }
    } catch (err) {
      showErrorAlertHelper(errorMessage: handleApiFormatError(err));
    } finally {
      isWalletLoading(false);
    }
  }

  Future<void> fetchingDefaultWallet() async {
    try {
      isDefaultWalletLoading(true);
      final response = await WalletServices.instance.fetchDefaultWallet();
      if (response.statusCode == 200) {
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
      } else {
        print('Failed to fetch default wallet: ${response.data['message']}');
      }
    } catch (err) {
      // showErrorAlertHelper(errorMessage: handleApiFormatError(err));
    } finally {
      isDefaultWalletLoading(false);
    }
  }

  void clearData() {
    defaultWallet.value = GetWalletModel();
    wallets.clear();
  }
}
