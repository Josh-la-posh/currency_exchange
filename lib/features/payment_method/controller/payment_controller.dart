import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/wallet/controller/wallet_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/shared/error_dialog_response.dart';
import '../../wallet/apis/api.dart';
import '../../wallet/models/fcy_account_entity.dart';
import '../../wallet/models/flutterwave_model.dart';
import '../../wallet/models/get_bank_account.dart';
import '../../wallet/models/paystack_model.dart';
import '../../wallet/models/ussd_modal.dart';
import '../../withdrawals/screens/withdrawal_success.dart';
import '../screens/flutterwave_payment.dart';
import '../screens/paystack_payment.dart';
import '../screens/ussd_funding_detail.dart';

class PaymentController extends GetxController {
  final WalletController walletController = Get.find();
  var isFundingWalletViaNairaTransfer = false.obs;
  var isCreatingFcy = false.obs;
  var isFundingFcy = false.obs;
  var isFundingWalletViaPaystack = false.obs;
  var isTransferToLocalBank = false.obs;
  var isFundWalletViaNairaUssd = false.obs;
  var isFundWalletViaNairaBankDirect = false.obs;
  var isConfirmBirthday = false.obs;
  var isConfirmingOtp = false.obs;
  var isBankLoading = false.obs;
  var flutterwaveDetails = FlutterwaveModel().obs;
  var paystackDetails = PaystackModel().obs;
  var selectedWithdrawalAccount = GetBankAccountModel().obs;
  var ussdDetails = UssdModel().obs;
  var nigBanks = Bank.values.obs;
  var foreignCurrencies = ForeignBank.values.obs;
  var selectedForeignCurrency = ForeignBank.USD.obs;
  var selectedNigBanks = Bank.GTB.obs;
  var amount = ''.obs;

  @override
  void onClose() {
    flutterwaveDetails.value = FlutterwaveModel();
    paystackDetails.value = PaystackModel();
    selectedNigBanks.value = Bank.GTB;
    selectedForeignCurrency.value = ForeignBank.USD;
    selectedWithdrawalAccount.value = GetBankAccountModel();
    ussdDetails.value = UssdModel();
    isFundingWalletViaNairaTransfer.value = false;
    isCreatingFcy.value = false;
    isFundingFcy.value = false;
    isFundingWalletViaPaystack.value = false;
    isBankLoading.value = false;
    isTransferToLocalBank.value = false;
    isFundWalletViaNairaUssd.value = false;
    isFundWalletViaNairaBankDirect.value = false;
    isConfirmBirthday.value = false;
    isConfirmingOtp.value = false;
    super.onClose();
  }

  void setSelectedNigBank(Bank bank) {
    selectedNigBanks.value = bank;
  }

  void setSelectedForeignCurrency(ForeignBank currency) {
    selectedForeignCurrency.value = currency;
  }

  void setAmount(String value) {
    amount.value = value;
  }

  void saveWithdrawalBank(GetBankAccountModel account) {
    selectedWithdrawalAccount.value = account;
  }

  Future<void> fundingWalletViaNairaTransfer({required String amount}) async {
    try {
      isFundingWalletViaNairaTransfer(true);
      final response = await WalletServices.instance.fundWalletViaNairaTransfer(
          amount: amount,
          onFailure: () {
            isFundingWalletViaNairaTransfer(false);
          }
      );
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
    } catch (err) {
      showErrorAlertHelper(errorMessage: err.toString());
    } finally {
      isFundingWalletViaNairaTransfer(false);
    }
  }

  Future<void> creatingFcy({required String currency, required String accountNumber}) async {
    try {
      isCreatingFcy(true);
      final response = await WalletServices.instance.createFcy(
          currency: currency,
          accountNumber: accountNumber,
          onFailure: () {
            isCreatingFcy(false);
          }
      );
      var item = response.data;
    } catch (err) {
      showErrorAlertHelper(errorMessage: err.toString());
    } finally {
      isCreatingFcy(false);
    }
  }

  Future<void> fundingFcy({required String currency, required String amount, required VoidCallback onSuccess}) async {
    try {
      isFundingFcy(true);
      final response = await WalletServices.instance.fundFcy(
          currency: currency,
          amount: amount,
          onFailure: () {isFundingFcy(false);}
      );
      var item = response.data;
      await walletController.fetchWallets(currency: '');
      onSuccess();
    } catch (err) {
      showErrorAlertHelper(errorMessage: err.toString());
    } finally {
      isFundingFcy(false);
    }
  }

  Future<void> fundingWalletViaPaystack({required String amount}) async {
    try {
      isFundingWalletViaPaystack(true);
      final response = await WalletServices.instance.fundWalletViaPaystack(
          amount: amount,
          onFailure: () {isFundingWalletViaPaystack(false);}
      );
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
      Get.to(() => PaystackPaymentScreen(amount: amount));
    } catch (err) {
      showErrorAlertHelper(errorMessage: err.toString());
    } finally {
      isFundingWalletViaPaystack(false);
    }
  }

  Future<void> transferToLocalBank({
    required String bankId,
    required int amount,
  }) async {
    try {
      isTransferToLocalBank(true);
      final response = await WalletServices.instance.transferToLocalBank(
          bankId: bankId,
          amount: amount,
          onFailure: () {
            isTransferToLocalBank(false);
          }
      );
      var title = response.data['message'];
      await walletController.fetchWallets(currency: '');
      selectedWithdrawalAccount.value = GetBankAccountModel();
      Get.to(() => WithdrawalSuccessScreen(title: title,));
    } catch (err) {
      showErrorAlertHelper(errorMessage: err.toString());
    } finally {
      isTransferToLocalBank(false);
    }
  }

  Future<void> fundWalletViaNairaUssd({
    required String amount,
    required String bank
  }) async {
    try {
      isFundWalletViaNairaUssd(true);
      final response = await WalletServices.instance.fundWalletViaNairaUssd(
          amount: amount,
          bank: bank,
          onFailure: () {
            isFundWalletViaNairaUssd(false);
          }
      );
      var item = response.data['data'];
      ussdDetails(UssdModel(
        reference: item['reference'],
        status: item['status'],
        display_text: item['display_text'],
        ussd_code: item['ussd_code'],
      ));
      Get.to(() => UssdFundingDetailScreen(amount: amount,));
    } catch (err) {
      showErrorAlertHelper(errorMessage: err.toString());
    } finally {
      isFundWalletViaNairaUssd(false);
    }
  }

  Future<void> fundWalletViaNairaBankDirect({
    required int amount,
    required String bankId,
  }) async {
    try {
      isFundWalletViaNairaBankDirect(true);
      final response = await WalletServices.instance.fundWalletViaNairaBankDirect(
          amount: amount,
          bankId: bankId,
          onFailure: () {
            isFundWalletViaNairaBankDirect(false);
          }
      );
      await walletController.fetchWallets(currency: '');
      Get.snackbar('Pending', 'Your transaction is in progress', backgroundColor: Colors.yellowAccent);
    } catch (err) {
      showErrorAlertHelper(errorMessage: err.toString());
    } finally {
      isFundWalletViaNairaBankDirect(false);
    }
  }

  Future<void> confirmBirthday({
    required String birthday,
    required String reference
  }) async {
    try {
      isConfirmBirthday(true);
      await WalletServices.instance.confirmBirthday(
          birthday: birthday,
          reference: reference,
          onFailure: () {
            isConfirmBirthday(false);
          }
      );
        Get.snackbar('Pending', 'Your request is in progress', backgroundColor: Colors.yellowAccent);
    } catch (err) {
      showErrorAlertHelper(errorMessage: err.toString());
    } finally {
      isConfirmBirthday(false);
    }
  }

  Future<void> confirmingOtp({
    required String otp,
    required String reference
  }) async {
    try {
      isConfirmingOtp(true);
      await WalletServices.instance.confirmingOtp(
          otp: otp,
          reference: reference,
          onFailure: () {
            isConfirmingOtp(false);
          }
      );
      Get.snackbar('Pending', 'Your request is in progress', backgroundColor: Colors.yellowAccent);
    } catch (err) {
      showErrorAlertHelper(errorMessage: err.toString());
    } finally {
      isConfirmingOtp(false);
    }
  }

  Future<void> fetchFcyAccount({required String currency}) async {
    try {
      final response = await WalletServices.instance.fetchFcyAccount(
          currency: currency,
          onFailure: () {
          }
      );
      final data = response.data['content'];
      List<GetFcyAccountEntity> fetchedFcyAccounts = (data as List)
          .map((json) => GetFcyAccountEntity.fromJson(json)).toList();
    } catch (err) {
      showErrorAlertHelper(errorMessage: err.toString());
    } finally {
    }
  }

  Future<void> deleteFcy({required String id}) async {
    try {
      Get.snackbar('', 'Deleting account', backgroundColor: TColors.primary);
      await WalletServices.instance.deleteFcy(
          id: id,
          onFailure: () {
            Get.closeAllSnackbars();
          }
      );
      await fetchFcyAccount(currency: '');
    } catch (err) {
      showErrorAlertHelper(errorMessage: err.toString());
    } finally {
      Get.closeAllSnackbars();
    }
  }

  void resetBoolOnOutgoingRequest() {
    isFundingWalletViaNairaTransfer.value = false;
    isCreatingFcy.value = false;
    isFundingFcy.value = false;
    isFundingWalletViaPaystack.value = false;
    isBankLoading.value = false;
    isTransferToLocalBank.value = false;
    isFundWalletViaNairaUssd.value = false;
    isFundWalletViaNairaBankDirect.value = false;
    isConfirmBirthday.value = false;
    isConfirmingOtp.value = false;
  }

  void clearData() {
    flutterwaveDetails.value = FlutterwaveModel();
    paystackDetails.value = PaystackModel();
    selectedNigBanks.value = Bank.GTB;
    selectedForeignCurrency.value = ForeignBank.USD;
    selectedWithdrawalAccount.value = GetBankAccountModel();
    ussdDetails.value = UssdModel();
  }

}