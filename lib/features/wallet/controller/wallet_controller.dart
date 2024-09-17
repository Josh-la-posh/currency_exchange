import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/authentication/controllers/auth_controller.dart';
import 'package:pouch/features/wallet/apis/api.dart';
import 'package:pouch/features/wallet/models/bank_list.dart';
import 'package:pouch/features/wallet/models/fcy_account_entity.dart';
import 'package:pouch/features/wallet/models/flutterwave_model.dart';
import 'package:pouch/features/wallet/models/get_bank_account.dart';
import 'package:pouch/features/wallet/models/get_wallet.dart';
import 'package:pouch/features/wallet/models/paystack_model.dart';
import 'package:pouch/features/wallet/models/ussd_modal.dart';
import 'package:pouch/features/wallet/models/verify_bank_account_model.dart';
import 'package:pouch/utils/constants/enums.dart';

import '../../payment_method/screens/flutterwave_payment.dart';
import '../../payment_method/screens/paystack_payment.dart';
import '../../payment_method/screens/ussd_funding_detail.dart';
import '../../withdrawals/screens/withdrawal_success.dart';

class WalletController extends GetxController {
  final authController = Get.find<AuthController>();
  var showBalance = false.obs;
  var showWalletLists = false.obs;
  var isDefaultWalletLoading = false.obs;
  var isLoading = false.obs;
  var isBankLoading = false.obs;
  var verifyingAccount = false.obs;
  var showWalletBalance = false.obs;
  var selectedWalletCurrency = WalletCurrency.NGN.obs;
  var defaultWallet = GetWalletModel().obs;
  var flutterwaveDetails = FlutterwaveModel().obs;
  var paystackDetails = PaystackModel().obs;
  var bankAccountDetails = VerifyBankAccountModel().obs;
  var selectedBank = BankListModel().obs;
  var selectedWithdrawalAccount = GetBankAccountModel().obs;
  var ussdDetails = UssdModel().obs;
  var bankAccounts = <GetBankAccountModel>[].obs;
  var walletCurrencies = WalletCurrency.values.obs;
  var nigBanks = Bank.values.obs;
  var foreignCurrencies = ForeignBank.values.obs;
  var selectedForeignCurrency = ForeignBank.USD.obs;
  var selectedNigBanks = Bank.GTB.obs;
  var bankList = <BankListModel>[].obs;
  var filteredBanks = <BankListModel>[].obs;
  var wallets = <GetWalletModel>[].obs;
  var amount = ''.obs;
  var showBankTransferOption = false.obs;
  var showErrorText = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchWallets(currency: '');
    fetchLocalBank();
    fetchBankList();
  }

  void updateShowWalletList() {
    showWalletLists.value = !showWalletLists.value;
  }

  void updateSelectedCurrency(WalletCurrency currency) {
    selectedWalletCurrency.value = currency;
  }

  void setAmount(String value) {
    amount.value = value;
  }

  void toggleBankTransferOption() {
    showBankTransferOption.value = !showBankTransferOption.value;
  }

  void setShowErrorText(bool value) {
    showErrorText.value = value;
  }

  void setSelectedNigBank(Bank bank) {
    selectedNigBanks.value = bank;
  }

  void setSelectedForeignCurrency(ForeignBank currency) {
    selectedForeignCurrency.value = currency;
  }

  void saveWithdrawalBank(GetBankAccountModel account) {
    selectedWithdrawalAccount.value = account;
  }

  void filterBanks(String searchText) {
    filteredBanks.value = bankList.where((bank) =>
        bank.name!.toLowerCase().contains(searchText.toLowerCase())
    ).toList();
  }

  Future<void> creatingWallet({required String currency, required VoidCallback onSuccess}) async {
    try {
      isLoading(true);
      final response = await WalletServices.instance.createWallet(currency: currency);
      if (response.statusCode == 200 || response.statusCode == 201) {
        await fetchWallets(currency: '');
        onSuccess();
        Get.snackbar('Success', 'Your wallet has been created successfully', backgroundColor: Colors.green);
      } else {
        Get.snackbar('Error', 'Failed to create wallet: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      return null;
    } finally {
      isLoading(false);
    }
  }

  Future<void> creatingDefaultWallet({required String walletId}) async {
    try {
      final response = await WalletServices.instance.createDefaultWallet(walletId: walletId);
      if (response.statusCode == 200 || response.statusCode == 201) {
        await fetchingDefaultWallet();
      } else {
        Get.snackbar('Error', 'Failed to create default wallet: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      return null;
    }
  }

  Future<void> fundingWalletViaNairaTransfer({required String amount}) async {
    try {
      isLoading(true);
      final response = await WalletServices.instance.fundWalletViaNairaTransfer(amount: amount);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var item = response.data['meta']['authorization'];
        flutterwaveDetails(FlutterwaveModel(
            transfer_reference: item['transfer_reference'],
            transfer_account: item['transfer_account'],
            transfer_bank: item['transfer_bank'],
            account_expiration: item['account_expiration'],
            transfer_note: item['transfer_note'],
            transfer_amount: item['transfer_amount'],
            mode: item['mode']
        ));
        Get.to(() => FlutterwavePaymentScreen());
      } else {
        Get.snackbar('Error', 'Failed to fund wallet via Naira transfer: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      return null;
    } finally {
      isLoading(false);
    }
  }

  Future<void> creatingFcy({required String currency, required String accountNumber}) async {
    try {
      isLoading(true);
      final response = await WalletServices.instance.createFcy(currency: currency, accountNumber: accountNumber);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var item = response.data;
        print('created fcy $item');
      } else {
        Get.snackbar('Error', 'Failed to create FCY account: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      return null;
    } finally {
      isLoading(false);
    }
  }

  Future<void> fundingFcy({required String currency, required String amount, required VoidCallback onSuccess}) async {
    try {
      isLoading(true);
      final response = await WalletServices.instance.fundFcy(currency: currency, amount: amount);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var item = response.data;
        await fetchWallets(currency: '');
        onSuccess();
      } else {
        Get.snackbar('Error', 'Failed to fund FCY account: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      return null;
    } finally {
      isLoading(false);
    }
  }

  Future<void> fundingWalletViaPaystack({required String amount}) async {
    try {
      isLoading(true);
      final response = await WalletServices.instance.fundWalletViaPaystack(amount: amount);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var item = response.data['data'];
        paystackDetails(PaystackModel(
            reference: item['reference'],
            status: item['status'],
            display_text: item['display_text'],
            account_name: item['account_name'],
            account_number: item['account_number'],
            bank: item['bank'],
            account_expires_at: item['account_expires_at']
        ));
        Get.to(() => PaystackPaymentScreen());
      } else {
        Get.snackbar('Error', 'Failed to fund wallet via Paystack: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      return null;
    } finally {
      isLoading(false);
    }
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
        Get.snackbar('Error', 'Failed to add local bank: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      return null;
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
        Get.snackbar('Error', 'Failed to verify bank account: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      return null;
    } finally {
      verifyingAccount(false);
    }
  }

  Future<void> transferToLocalBank({
    required String bankId,
    required int amount,
  }) async {
    try {
      isLoading(true);
      final response = await WalletServices.instance.transferToLocalBank(
          bankId: bankId,
          amount: amount,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var title = response.data['message'];
        await fetchWallets(currency: '');
        selectedWithdrawalAccount.value = GetBankAccountModel();
        Get.to(() => WithdrawalSuccessScreen(title: title,));
      } else {
        Get.snackbar('Error', 'Failed to transfer to local bank: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      return null;
    } finally {
      isLoading(false);
    }
  }

  Future<void> fundWalletViaNairaUssd({
    required String amount,
    required String bank
  }) async {
    try {
      isLoading(true);
      final response = await WalletServices.instance.fundWalletViaNairaUssd(
          amount: amount,
          bank: bank
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var item = response.data['data'];
        ussdDetails(UssdModel(
          reference: item['reference'],
          status: item['status'],
          display_text: item['display_text'],
          ussd_code: item['ussd_code'],
        ));
        Get.to(() => UssdFundingDetailScreen(amount: amount,));
      } else {
        Get.snackbar('Error', 'Failed to fund wallet via USSD: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      return null;
    } finally {
      isLoading(false);
    }
  }

  Future<void> fundWalletViaNairaBankDirect({
    required int amount,
    required String bankId,
  }) async {
    try {
      isLoading(true);
      final response = await WalletServices.instance.fundWalletViaNairaBankDirect(
          amount: amount,
          bankId: bankId
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        await fetchWallets(currency: '');
        Get.snackbar('Pending', 'Your transaction is in progress', backgroundColor: Colors.yellowAccent);
      } else {
        Get.snackbar('Error', 'Failed to fund wallet via Naira Bank Direct: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      return null;
    } finally {
      isLoading(false);
    }
  }

  Future<void> confirmBirthday({
    required String birthday,
    required String reference
  }) async {
    try {
      isLoading(true);
      final response = await WalletServices.instance.confirmBirthday(
          birthday: birthday,
          reference: reference
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar('Pending', 'Your request is in progress', backgroundColor: Colors.yellowAccent);
      } else {
        Get.snackbar('Error', 'Failed to confirm birthday: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      return null;
    } finally {
      isLoading(false);
    }
  }

  Future<void> confirmingOtp({
    required String otp,
    required String reference
  }) async {
    try {
      isLoading(true);
      final response = await WalletServices.instance.confirmingOtp(
          otp: otp,
          reference: reference
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar('Pending', 'Your request is in progress', backgroundColor: Colors.yellowAccent);
      } else {
        Get.snackbar('Error', 'Failed to confirm OTP: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      return null;
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchWallets({required String currency}) async {
    try {
      final response = await WalletServices.instance.fetchWallets(currency: currency);
      if (response.statusCode == 200) {
        final data = response.data;
        List<GetWalletModel> fetchedWallets = (data as List)
            .map((json) => GetWalletModel.fromJson(json)).toList();
        wallets.assignAll(fetchedWallets);
        await fetchingDefaultWallet();
      } else {
        Get.snackbar('Error', 'Failed to fetch wallets: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      return null;
    } finally {
      isDefaultWalletLoading(false);
    }
  }

  Future<void> fetchingDefaultWallet() async {
    try {
      defaultWallet.value.balance == null && isDefaultWalletLoading(true);
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
        Get.snackbar('Error', 'Failed to fetch default wallet: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      return null;
    } finally {
      isDefaultWalletLoading(false);
    }
  }

  Future<void> fetchLocalBank() async {
    try {
      isBankLoading(true);
      final response = await WalletServices.instance.fetchLocalBank();
      if (response.statusCode == 200) {
        final data = response.data;
        List<GetBankAccountModel> fetchedBankAccounts = (data as List)
            .map((json) => GetBankAccountModel.fromJson(json)).toList();
        bankAccounts.assignAll(fetchedBankAccounts);
      } else {
        Get.snackbar('Error', 'Failed to fetch local bank accounts: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      return null;
    } finally {
      isBankLoading(false);
    }
  }

  Future<void> fetchFcyAccount({required String currency}) async {
    try {
      isBankLoading(true);
      final response = await WalletServices.instance.fetchFcyAccount(currency: currency);
      if (response.statusCode == 200) {
        final data = response.data['content'];
        List<GetFcyAccountEntity> fetchedFcyAccounts = (data as List)
            .map((json) => GetFcyAccountEntity.fromJson(json)).toList();
      } else {
        Get.snackbar('Error', 'Failed to fetch FCY accounts: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      return null;
    } finally {
      isBankLoading(false);
    }
  }

  Future<void> fetchBankList() async {
    try {
      isLoading(true);
      final response = await WalletServices.instance.fetchBankList();
      if (response.statusCode == 200) {
        final data = response.data['data'];
        print(data);
        List<BankListModel> fetchedBankLists = (data as List)
            .map((json) => BankListModel.fromJson(json)).toList();
        bankList.assignAll(fetchedBankLists);
        print('Da bankLise $fetchedBankLists');
        print('Da bankLise $bankList');
      } else {
        Get.snackbar('Error', 'Failed to fetch bank list: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      print('Error occurred: $err');
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteFcy({required String id}) async {
    try {
      isLoading(true);
      final response = await WalletServices.instance.deleteFcy(id: id);
      if (response.statusCode == 200) {
        await fetchFcyAccount(currency: '');
      } else {
        Get.snackbar('Error', 'Failed to delete FCY account: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      return null;
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteLocalBankAccount({required String id}) async {
    try {
      isLoading(true);
      final response = await WalletServices.instance.deleteLocalBankAccount(id: id);
      if (response.statusCode == 200) {
        await fetchLocalBank();
        Get.snackbar('Success', 'Bank account deleted successfully', backgroundColor: Colors.green);
      } else {
        Get.snackbar('Error', 'Failed to delete bank account: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      return null;
    } finally {
      isLoading(false);
    }
  }

  void clearData() {
    defaultWallet.value = GetWalletModel();
    wallets.clear();
    flutterwaveDetails.value = FlutterwaveModel();
    paystackDetails.value = PaystackModel();
    bankAccountDetails.value = VerifyBankAccountModel();
    selectedBank.value = BankListModel();
    selectedNigBanks.value = Bank.GTB;
    selectedForeignCurrency.value = ForeignBank.USD;
    selectedWithdrawalAccount.value = GetBankAccountModel();
    ussdDetails.value = UssdModel();
    bankAccounts.clear();
    bankList.clear();
  }

  // String handleApiFormatError(dynamic error) {
  //   if (error is ApiException) {
  //     return error.message;
  //   } else if (error is FormatException) {
  //     return 'Data format error';
  //   } else {
  //     return 'An unexpected error occurred';
  //   }
  // }
}
