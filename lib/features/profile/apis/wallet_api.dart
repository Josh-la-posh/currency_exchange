import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:swappr/data/modules/dio.dart';
import 'package:swappr/data/provider/transaction_provider.dart';
import 'package:swappr/data/provider/wallet_provider.dart';
import 'package:swappr/features/profile/models/wallet_model.dart';
import 'package:swappr/features/transaction/apis/api.dart';
import 'package:swappr/utils/responses/error_dialog.dart';
import 'package:swappr/utils/responses/handleApiError.dart';
import 'package:swappr/utils/responses/success_dialog.dart';
import 'package:swappr/utils/shared/notification/snackbar.dart';

import '../../../data/modules/app_navigator.dart';
import '../routes/names.dart';

class WalletServices{
  static final WalletServices _instance = WalletServices._();

  WalletServices._();

  static WalletServices get instance => _instance;

  // Post requests

  Future _createWallet(Object data) {
    return apiService.post('/wallet/create', data: data);
  }

  Future _getWallet() {
    return apiService.post('/wallet/get-wallets');
  }

  Future _fundWalletNairaTransfer(Object data) {
    return apiService.post('/wallet/fund-wallet-naira-transfer', data: data);
  }

  Future _webhook() {
    return apiService.post('/wallet/webhook');
  }

  Future _createFcy(Object data) {
    return apiService.post('/wallet/create/fcy', data: data);
  }

  // Get requests

  Future getFcyAccounts({
    required String currency
  }) {
    return apiService.get('/wallet/fcy-accounts',
        queryParameters: {'currency': currency});
  }

  // Delete requests

  Future _removeFcy({required String id}) {
    return apiService.delete('/wallet/fcy/$id');
  }

  createWallet({required WalletProvider walletProvider, required String currency}) {
    _createWallet({'currency': currency})
        .then((response) async {
          await getWallets(walletProvider: walletProvider);
          handleShowCustomToast(message: 'Your wallet has been created successfully');
    }).catchError((error) {
      showErrorAlertHelper(errorMessage: handleApiFormatError(error));
    });
  }

  getWallets({required WalletProvider walletProvider}) {
      List<GetWalletModel> wallets = [];
      _getWallet().then((response) {
        var data = response.data;

          for (var item in data) {
            wallets.add(GetWalletModel(
              id: item['id'],
              currency: item['currency'],
              balance: item['balance'],
              isActive: item['isActive'],
              createdDate: item['createdDate'],
              lastModifiedDate: item['lastModifiedDate']
            ));
          }
          walletProvider.saveWallets(wallets);
          print(wallets.last.balance);
    });
  }

  fundWalletNairaTransfer({required String amount, required WalletProvider walletProvider, required TransactionProvider transactionProvider}) {
    _fundWalletNairaTransfer({'amount': amount})
        .then((response) async {
          await getWallets(walletProvider: walletProvider);
          await TransactionService.instance.getTransactions(transactionProvider: transactionProvider);
          Get.back();
          handleShowCustomToast(message: 'In progress ...');
        }).catchError((error) {
      showErrorAlertHelper(errorMessage: handleApiFormatError(error));
    });
  }
  
}