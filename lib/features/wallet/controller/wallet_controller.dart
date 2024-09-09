import 'package:get/get.dart';
import 'package:pouch/features/wallet/apis/api.dart';
import 'package:pouch/features/wallet/models/default_wallet_model.dart';

class WalletController extends GetxController {
  var isDefaultWalletLoading = false.obs;
  var showWalletBalance = false.obs;
  var defaultWallet = DefaultWalletModel().obs;

  Future<void> fetchingDefaultWallet() async {
    try {
      defaultWallet.value == null && isDefaultWalletLoading(true);
      final response = await WalletServices.instance.fetchDefaultWallet();
      final data = response.data;
      defaultWallet(DefaultWalletModel(
          id: data['id'],
          currency: data['currency'],
          balance: data['balance'],
          isActive: data['isActive'],
          pendingWithdrawals: data['pendingWithdrawals'],
          createdDate: data['createdDate'],
          lastModifiedDate: data['lastModifiedDate']
      ));
      print('The new wallet datat is ${defaultWallet.value.balance}');
    } catch (err) {

    } finally {
      isDefaultWalletLoading(false);
    }
  }
  void clearData() {
    defaultWallet.value = DefaultWalletModel();
  }
}