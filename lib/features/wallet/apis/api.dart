import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/data/modules/dio.dart';
import 'package:pouch/data/modules/interceptor.dart';
import 'package:pouch/utils/responses/handleApiError.dart';

const WALLET_URL = '/wallet';
const CREATE_URL = 'create';
const NAIRA_TRANSFER_URL = 'fund-wallet-naira-transfer';
const PAYSTACK_URL = 'fund-wallet-naira-paystack';
const ADD_LOCAL_BANK_URL = 'add-local-bank';
const TRANSFER_LOCAL_BANK_URL = 'transfer-local-bank';
const NAIRA_USSD_URL = 'fund-wallet-naira-ussd';
const NAIRA_BANK_DIRECT_URL = 'fund-wallet-naira-bank-direct';
const DEFAULT_WALLET_URL = 'default-wallet';
const GET_WALLET_URL = 'get-wallets';
const GET_DEFAULT_WALLET_URL = 'user-default-wallet';
const GET_LOCAL_BANK_URL = 'get-local-bank';
const GET_BANK_LIST_URL = 'list-banks';
const VERIFY_BANK_ACCOUNT_URL = 'verify-bank-account';
const CONFIRM_BIRTHDAY_URL = 'confirm-birthday';
const CONFIRM_OTP_URL = 'confirm-otp';


final _apiService = AppInterceptor(showLoader: false).dio;

class WalletServices{
  static final WalletServices _instance = WalletServices._();

  WalletServices._();

  static WalletServices get instance => _instance;

  Future createWallet({required String currency}) async {
    try {
      final response = await _apiService.post(
        '$WALLET_URL/$CREATE_URL',
        data: {'currency': currency},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        Get.snackbar('Error', 'Failed to create wallet: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      Get.snackbar('Error', handleApiFormatError(err), backgroundColor: Colors.red);
    }
  }

  Future createDefaultWallet({required String walletId}) async {
    try {
      final response = await _apiService.post(
        '$WALLET_URL/$DEFAULT_WALLET_URL',
        data: {'walletId': walletId},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        Get.snackbar('Error', 'Failed to create default wallet: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      Get.snackbar('Error', handleApiFormatError(err), backgroundColor: Colors.red);
    }
  }

  Future fundWalletViaNairaTransfer({required String amount}) async {
    try {
      final response = await _apiService.post(
        '$WALLET_URL/$NAIRA_TRANSFER_URL',
        data: {'amount': amount},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        Get.snackbar('Error', 'Failed to fund wallet via Naira transfer: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      Get.snackbar('Error', handleApiFormatError(err), backgroundColor: Colors.red);
    }
  }

  Future createFcy({required String currency, required String accountNumber}) async {
    try {
      final response = await _apiService.post(
        '$WALLET_URL/$CREATE_URL/fcy',
        data: {'currency': currency, 'accountNumber': accountNumber},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        Get.snackbar('Error', 'Failed to create FCY account: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      Get.snackbar('Error', handleApiFormatError(err), backgroundColor: Colors.red);
    }
  }

  Future fundFcy({required String amount, required String currency}) async {
    try {
      final response = await _apiService.post(
        '$WALLET_URL/fund-fcy',
        data: {'amount': amount, 'currency': currency},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        Get.snackbar('Error', 'Failed to fund FCY account: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      Get.snackbar('Error', handleApiFormatError(err), backgroundColor: Colors.red);
    }
  }

  Future fundWalletViaPaystack({required String amount}) async {
    try {
      final response = await _apiService.post(
        '$WALLET_URL/$PAYSTACK_URL',
        data: {'amount': amount},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        Get.snackbar('Error', 'Failed to fund wallet via Paystack: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      Get.snackbar('Error', handleApiFormatError(err), backgroundColor: Colors.red);
    }
  }

  Future addLocalBank({
    required String accountNumber,
    required String accountName,
    required String bankName,
    required String bankCode,
  }) async {
    try {
      final response = await _apiService.post(
        '$WALLET_URL/$ADD_LOCAL_BANK_URL',
        data: {
          'accountNumber': accountNumber,
          'accountName': accountName,
          'bankName': bankName,
          'bankCode': bankCode,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        Get.snackbar('Error', 'Failed to add local bank: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      Get.snackbar('Error', handleApiFormatError(err), backgroundColor: Colors.red);
    }
  }

  Future verifyBankAccount({
    required String accountNumber,
    required String bankCode,
  }) async {
    try {
      final response = await _apiService.get(
        '$WALLET_URL/$VERIFY_BANK_ACCOUNT_URL',
        queryParameters: {'accountNumber': accountNumber, 'bankCode': bankCode},
      );
      return response;
    } catch (err) {
      Get.snackbar('Error', handleApiFormatError(err), backgroundColor: Colors.red);
    }
  }

  Future transferToLocalBank({
    required String bankId,
    required int amount,
  }) async {
    try {
      final response = await _apiService.post(
        '$WALLET_URL/$TRANSFER_LOCAL_BANK_URL',
        data: {'bankId': bankId, 'amount': amount},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        Get.snackbar('Error', 'Failed to transfer to local bank: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      Get.snackbar('Error', handleApiFormatError(err), backgroundColor: Colors.red);
    }
  }

  Future fundWalletViaNairaUssd({
    required String amount,
    required String bank,
  }) async {
    try {
      final response = await _apiService.post(
        '$WALLET_URL/$NAIRA_USSD_URL',
        data: {'amount': amount, 'bank': bank},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        Get.snackbar('Error', 'Failed to fund wallet via Naira USSD: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      Get.snackbar('Error', handleApiFormatError(err), backgroundColor: Colors.red);
    }
  }

  Future fundWalletViaNairaBankDirect({
    required int amount,
    required String bankId,
  }) async {
    try {
      final response = await _apiService.post(
        '$WALLET_URL/$NAIRA_BANK_DIRECT_URL',
        data: {'amount': amount, 'bankId': bankId},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        Get.snackbar('Error', 'Failed to fund wallet via Naira bank direct: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      Get.snackbar('Error', handleApiFormatError(err), backgroundColor: Colors.red);
    }
  }

  Future confirmBirthday({
    required String birthday,
    required String reference,
  }) async {
    try {
      final response = await _apiService.post(
        '$WALLET_URL/$CONFIRM_BIRTHDAY_URL',
        data: {'birthday': birthday, 'reference': reference},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        Get.snackbar('Error', 'Failed to confirm birthday: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      Get.snackbar('Error', handleApiFormatError(err), backgroundColor: Colors.red);
    }
  }

  Future confirmingOtp({
    required String otp,
    required String reference,
  }) async {
    try {
      final response = await _apiService.post(
        '$WALLET_URL/$CONFIRM_OTP_URL',
        data: {'otp': otp, 'reference': reference},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        Get.snackbar('Error', 'Failed to confirm OTP: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      Get.snackbar('Error', handleApiFormatError(err), backgroundColor: Colors.red);
    }
  }

  Future fetchWallets({required String currency}) async {
    try {
      final response = await _apiService.get(
        '$WALLET_URL/$GET_WALLET_URL',
        data: {'currency': currency},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        Get.snackbar('Error', 'Failed to fetch wallets: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      Get.snackbar('Error', handleApiFormatError(err), backgroundColor: Colors.red);
    }
  }

  Future fetchDefaultWallet() async {
    try {
      final response = await _apiService.get('$WALLET_URL/$GET_DEFAULT_WALLET_URL');
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        Get.snackbar('Error', 'Failed to fetch default wallet: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      Get.snackbar('Error', handleApiFormatError(err), backgroundColor: Colors.red);
    }
  }

  Future fetchLocalBank() async {
    try {
      final response = await _apiService.get('$WALLET_URL/$GET_LOCAL_BANK_URL');
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        Get.snackbar('Error', 'Failed to fetch local bank: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      Get.snackbar('Error', handleApiFormatError(err), backgroundColor: Colors.red);
    }
  }

  Future fetchFcyAccount({required String currency}) async {
    try {
      final response = await _apiService.get(
        '$WALLET_URL/fcy-account',
        data: {'currency': currency},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        Get.snackbar('Error', 'Failed to fetch FCY account: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      Get.snackbar('Error', handleApiFormatError(err), backgroundColor: Colors.red);
    }
  }

  Future fetchBankList() async {
    try {
      final response = await _apiService.get('$WALLET_URL/$GET_BANK_LIST_URL');
      return response;
    } catch (err) {
      Get.snackbar('Error', handleApiFormatError(err), backgroundColor: Colors.red);
    }
  }

  Future deleteFcy({required String id}) async {
    try {
      final response = await _apiService.delete('$WALLET_URL/fcy/$id');
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        Get.snackbar('Error', 'Failed to delete FCY: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      Get.snackbar('Error', handleApiFormatError(err), backgroundColor: Colors.red);
    }
  }

  Future deleteLocalBankAccount({required String id}) async {
    try {
      final response = await _apiService.delete('$WALLET_URL/local-account/$id');
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        Get.snackbar('Error', 'Failed to delete local bank account: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      Get.snackbar('Error', handleApiFormatError(err), backgroundColor: Colors.red);
    }
  }


  // Post requests

  Future _createWallet(Object data) {
    return apiService.post('/wallet/create', data: data);
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

  Future _fundFcy(Object data) {
    return apiService.post('/wallet/fund-fcy', data: data);
  }

  Future _fundWalletNairaPaystack(Object data) {
    return apiService.post('/wallet/fund-wallet-naira-paystack', data: data);
  }

  Future _webhookPaystack(Object data) {
    return apiService.post('/wallet/webhook/paystack', data: data);
  }

  Future _addLocalBank(Object data) {
    return apiService.post('/wallet/add-local-bank', data: data);
  }

  Future _transferLocalBank(Object data) {
    return apiService.post('/wallet/transfer-local-bank', data: data);
  }

  Future _fundWalletNairaUssd(Object data) {
    return apiService.post('/wallet/fund-wallet-naira-ussd', data: data);
  }

  Future _fundWalletNairaBankDirect(Object data) {
    return apiService.post('/wallet/fund-wallet-naira-bank-direct', data: data);
  }

  Future _confirmBirthday(Object data) {
    return apiService.post('/wallet/confirm-birthday', data: data);
  }

  Future _confirmOtp(Object data) {
    return apiService.post('/wallet/confirm-otp', data: data);
  }

  Future _defaultWallet(Object data) {
    return apiService.post('/wallet/default-wallet', data: data);
  }

  // Get requests

  Future _getWallet({required String currency}) {
    return apiService.get('/wallet/get-wallets',
        queryParameters: {'currency': currency}
    );
  }

  Future _getDefaultWallet() {
    return apiService.get('/wallet/user-default-wallet');
  }

  Future _getFcyAccounts({
    required String currency
  }) {
    return apiService.get('/wallet/fcy-accounts',
        queryParameters: {'currency': currency});
  }

  Future _getFcyRates({
    required String currency
  }) {
    return apiService.get('/wallet/fcy-rates',
        queryParameters: {'currency': currency});
  }

  Future _getLocalBank() {
    return apiService.get('/wallet/get-local-bank');
  }

  Future _getBankList() {
    return apiService.get('/wallet/list-banks');
  }

  Future _verifyBankAccount({
    required String accountNumber,
    required String bankCode
  }) {
    return apiService.get('/wallet/verify-bank-account',
        queryParameters: {'accountNumber': accountNumber, 'bankCode': bankCode});
  }

  // Delete requests

  Future _deleteFcy({required String id}) {
    return apiService.delete('/wallet/fcy/$id');
  }

  Future _deleteLocalAccount({required String id}) {
    return apiService.delete('/wallet/local-account/$id');
  }

  // Post requests

  // createWallet({required WalletProvider walletProvider, required String currency, required TransactionProvider transactionProvider}) {
  //   _createWallet({'currency': currency})
  //       .then((response) async {
  //     await getWallets(transactionProvider: transactionProvider, walletProvider: walletProvider, currency: '');
  //     handleShowCustomToast(message: 'Your wallet has been created successfully');
  //   }).catchError((error) {
  //     handleShowCustomToast(message: handleApiFormatError(error));
  //     // showErrorAlertHelper(errorMessage: handleApiFormatError(error));
  //   });
  // }

  // defaultWallet({
  //   required WalletProvider walletProvider,
  //   required String walletId,
  //   required TransactionProvider transactionProvider
  // }) {
  //   _defaultWallet({'walletId': walletId})
  //       .then((response) async {
  //         await getDefaultWallet(transactionProvider: transactionProvider, walletProvider: walletProvider);
  //   }).catchError((error) {
  //     handleShowCustomToast(message: handleApiFormatError(error));
  //   });
  // }

  // fundWalletNairaTransfer({
  //   required String amount,
  //   required WalletProvider walletProvider
  // }) {
  //   _fundWalletNairaTransfer({'amount': amount})
  //       .then((response) async {
  //         var result = response.data;
  //
  //         FlutterwaveEntity flutterwaveEntity = FlutterwaveEntity(
  //             status: result['status'],
  //             message: result['message'],
  //             meta: result['meta']
  //         );
  //
  //         var item = flutterwaveEntity.meta['authorization'];
  //
  //           FlutterwaveModel flutterwaveModel = FlutterwaveModel(
  //               transfer_reference: item['transfer_reference'],
  //               transfer_account: item['transfer_account'],
  //               transfer_bank: item['transfer_bank'],
  //               account_expiration: item['account_expiration'],
  //               transfer_note: item['transfer_note'],
  //               transfer_amount: item['transfer_amount'],
  //               mode: item['mode']
  //           );
  //
  //           walletProvider.saveFlutterwaveDetails(flutterwaveModel);
  //           Get.to(() => FlutterwavePaymentScreen());
  //
  //   }).catchError((error) {
  //     print('finding $error');
  //     showErrorAlertHelper(errorMessage: handleApiFormatError(error));
  //   });
  // }

  // createFcy({
  //   required String currency,
  //   required String accountNumber
  // }) {
  //   _createFcy({
  //     'currency': currency,
  //     'accountNumber': accountNumber
  //   }).then((response) async {
  //     print('createfcy ${response.data}');
  //   }).catchError((error) {
  //     showErrorAlertHelper(errorMessage: handleApiFormatError(error));
  //   });
  // }

  // fundFcy({
  //   required String currency,
  //   required String amount,
  //   required WalletProvider walletProvider,
  //   required TransactionProvider transactionProvider,
  //   required VoidCallback onSuccess
  // }) {
  //   _fundFcy({
  //     'amount': amount,
  //     'currency': currency,
  //   }).then((response) async {
  //     print('fundFcy ${response.data}');
  //     await NoLoaderService.instance.getWallets(walletProvider: walletProvider, currency: '', transactionProvider: transactionProvider);
  //     onSuccess();
  //   }).catchError((error) {
  //     showErrorAlertHelper(errorMessage: handleApiFormatError(error));
  //   });
  // }

  // fundWalletNairaPaystack({
  //   required WalletProvider walletProvider,
  //   required String amount,
  // }) {
  //   _fundWalletNairaPaystack({
  //     'amount': amount
  //   }).then((response) async {
  //     var result = response.data;
  //
  //     PaystackEntity paystackEntity = PaystackEntity(
  //         status: result['status'],
  //         message: result['message'],
  //         data: result['data']
  //     );
  //
  //     var item = paystackEntity.data;
  //
  //     PaystackModel paystackModel = PaystackModel(
  //         reference: item['reference'],
  //         status: item['status'],
  //         display_text: item['display_text'],
  //         account_name: item['account_name'],
  //         account_number: item['account_number'],
  //         bank: item['bank'],
  //         account_expires_at: item['account_expires_at']
  //     );
  //
  //     walletProvider.savePaystackDetails(paystackModel);
  //     Get.to(() => PaystackPaymentScreen(amount: amount.toString()));
  //   }).catchError((error) {
  //     showErrorAlertHelper(errorMessage: handleApiFormatError(error));
  //   });
  // }

  // addLocalBank({
  //   required String accountNumber,
  //   required String accountName,
  //   required String bankName,
  //   required String bankCode,
  //   required WalletProvider walletProvider
  // }) {
  //   _addLocalBank({
  //     "accountNumber": accountNumber,
  //     "accountName": accountName,
  //     "bankName": bankName,
  //     "bankCode": bankCode
  //   }).then((response) async {
  //     await getLocalBank(walletProvider: walletProvider);
  //     handleShowCustomToast(message: 'Bank account successfully added');
  //     walletProvider.saveBankAccountDetails(null);
  //     walletProvider.setSelectedBank(null);
  //     Get.back();
  //   }).catchError((error) {
  //     showErrorAlertHelper(errorMessage: handleApiFormatError(error));
  //   });
  // }

  // verifyBankAccount({
  //   required String accountNumber,
  //   required String bankCode,
  //   required WalletProvider walletProvider
  // }) {
  //   _verifyBankAccount(
  //     accountNumber: accountNumber,
  //     bankCode: bankCode
  //   ).then((response) async {
  //     var data = response.data;
  //
  //     VerifyBankAccountEntity accountDetails = VerifyBankAccountEntity(
  //         status: data["status"],
  //         message: data['message'],
  //         data: data['data']
  //     );
  //
  //     var item = accountDetails.data;
  //
  //     VerifyBankAccountModel accountDetail = VerifyBankAccountModel(
  //         account_number: item['account_number'],
  //         account_name: item['account_name'],
  //         bank_id: item['bank_id']
  //     );
  //
  //     walletProvider.saveBankAccountDetails(accountDetail);
  //
  //   }).catchError((error) {
  //     showErrorAlertHelper(errorMessage: handleApiFormatError(error));
  //   });
  // }

  // transferLocalBank({
  //   required String bankId,
  //   required String amount,
  //   required String currency,
  //   required WalletProvider walletProvider,
  //   required TransactionProvider transactionProvider,
  // }) {
  //   _transferLocalBank({
  //     'bankId': bankId,
  //     'amount': amount
  //   }).then((response) async {
  //     var title = response.data['message'];
  //     await NoLoaderService.instance.getWallets(walletProvider: walletProvider, currency: '', transactionProvider: transactionProvider);
  //     walletProvider.saveWithdrawalBank(null);
  //     Get.to(() => WithdrawalSuccessScreen(title: title,));
  //   }).catchError((error) {
  //     print('withdrrwl error $error');
  //     // handleShowCustomToast(message: 'In progress ...');
  //     showErrorAlertHelper(errorMessage: handleApiFormatError(error));
  //   });
  // }

  // fundWalletNairaUssd({
  //   required WalletProvider walletProvider,
  //   required TransactionProvider transactionProvider,
  //   required String amount,
  //   required String currency,
  //   required String bank
  // }) {
  //   _fundWalletNairaUssd({
  //     'amount': amount,
  //     'bank': bank
  //   }).then((response) async {
  //     var result = response.data;
  //
  //     UssdEntity ussdEntity = UssdEntity(
  //         status: result['status'],
  //         message: result['message'],
  //         data: result['data']
  //     );
  //
  //     var item = ussdEntity.data;
  //
  //     UssdModel ussdModel = UssdModel(
  //         reference: item['reference'],
  //         status: item['status'],
  //         display_text: item['display_text'],
  //         ussd_code: item['ussd_code'],
  //     );
  //
  //     walletProvider.saveUssdDetail(ussdModel);
  //
  //     Get.to(() => UssdFundingDetailScreen(amount: amount));
  //   }).catchError((error) {
  //     showErrorAlertHelper(errorMessage: handleApiFormatError(error));
  //   });
  // }

  // fundWalletNairaBankDirect({
  //   required WalletProvider walletProvider,
  //   required TransactionProvider transactionProvider,
  //   required int amount,
  //   required String currency,
  //   required String bankId,
  // }) {
  //   _fundWalletNairaBankDirect({
  //     'amount': amount,
  //     'bankId': bankId
  //   }).then((response) async {
  //     await getWallets(transactionProvider: transactionProvider,walletProvider: walletProvider, currency: '');
  //     // Get.back();
  //     handleShowCustomToast(message: 'In progress ...');
  //   }).catchError((error) {
  //     showErrorAlertHelper(errorMessage: handleApiFormatError(error));
  //   });
  // }

  // confirmBirthday({
  //   required String birthday,
  //   required String reference
  // }) {
  //   _confirmOtp({
  //     'birthday': birthday,
  //     'reference': reference
  //   }).then((response) async {
  //     handleShowCustomToast(message: 'In progress ...');
  //   }).catchError((error) {
  //     showErrorAlertHelper(errorMessage: handleApiFormatError(error));
  //   });
  // }

  // confirmOtp({
  //   required String otp,
  //   required String reference
  // }) {
  //   _confirmOtp({
  //     'otp': otp,
  //     'reference': reference
  //   }).then((response) async {
  //     handleShowCustomToast(message: 'In progress ...');
  //   }).catchError((error) {
  //     showErrorAlertHelper(errorMessage: handleApiFormatError(error));
  //   });
  // }

  //. Get requests

  // getWallets({
  //   required WalletProvider walletProvider,
  //   required String currency,
  //   required TransactionProvider transactionProvider
  // }) {
  //   List<GetWalletModel> wallets = [];
  //   _getWallet(currency: currency).then((response) async {
  //     await TransactionService.instance.getTransactions(transactionProvider: transactionProvider);
  //     var data = response.data;
  //     for (var item in data) {
  //       wallets.add(GetWalletModel(
  //           id: item['id'],
  //           currency: item['currency'],
  //           balance: item['balance'],
  //           isActive: item['isActive'],
  //           createdDate: item['createdDate'],
  //           lastModifiedDate: item['lastModifiedDate']
  //       ));
  //     }
  //     walletProvider.saveWallets(wallets);
  //   });
  // }

  // getDefaultWallet({
  //   required WalletProvider walletProvider,
  //   required TransactionProvider transactionProvider
  // }) {
  //   _getDefaultWallet().then((response) async {
  //     await getWallets(transactionProvider: transactionProvider, walletProvider: walletProvider, currency: '');
  //     var item = response.data;
  //     DefaultWalletModel defaultWallet = DefaultWalletModel(
  //         id: item['id'],
  //         currency: item['currency'],
  //         balance: item['balance'],
  //         isActive: item['isActive'],
  //         pendingWithdrawals: item['pendingWithdrawals'],
  //         createdDate: item['createdDate'],
  //         lastModifiedDate: item['lastModifiedDate']
  //     );
  //     walletProvider.setDefaultWallet(defaultWallet);
  //   });
  // }

  // getLocalBank({
  //   required WalletProvider walletProvider
  // }) {
  //   List<GetBankAccountModel> bankAccounts = [];
  //   _getLocalBank().then((response) {
  //     var data = response.data;
  //     for (var item in data) {
  //       bankAccounts.add(GetBankAccountModel(
  //           id: item['id'],
  //           accountNumber: item['accountNumber'],
  //           accountName: item['accountName'],
  //           bankName: item['bankName'],
  //           currency: item['currency'],
  //           type: item['type'],
  //           bankCode: item['bankCode'],
  //           recipientCode: item['recipientCode'],
  //           createdDate: item['createdDate'],
  //           lastModifiedDate: item['lastModifiedDate']));
  //       walletProvider.saveBankAccounts(bankAccounts);
  //     }
  //   });
  // }

  // getFcyAccount({
  //   required WalletProvider walletProvider,
  //   required String currency
  // }) {
  //   List<FcyAccountModel> fcyAccount = [];
  //   _getWallet(currency: currency).then((response) {
  //     var data = response.data;
  //
  //     GetFcyAccountEntity getFcyAccountEntity = GetFcyAccountEntity(
  //       totalPages: data['totalPages'],
  //       payloadSize: data['payloadSize'],
  //       hasNext: data['hasNext'],
  //       content: data['content'],
  //       currentPage: data['currentPage'],
  //       skippedRecords: data['skippedRecords'],
  //       totalRecords: data['totalRecords'],
  //     );
  //     walletProvider.saveFcyAccountDetails(getFcyAccountEntity);
  //
  //     var content = getFcyAccountEntity.content;
  //
  //     for (var item in content) {
  //       fcyAccount.add(FcyAccountModel(
  //         id: item['id'],
  //       ));
  //       walletProvider.saveFcyAccount(fcyAccount);
  //     }
  //
  //   });
  // }

  // getBankList({required WalletProvider walletProvider}) {
  //   List<BankListModel> bankList = [];
  //   _getBankList().then((response) {
  //     var result = response.data;
  //
  //     BankListEntity bankListModel = BankListEntity(
  //       status: result['status'],
  //       message: result['message'],
  //       data: result['data'],
  //     );
  //
  //     final data = bankListModel.data;
  //
  //     for (var item in data) {
  //       bankList.add(BankListModel(
  //         id: item['id'],
  //         name: item['name'],
  //         slug: item['slug'],
  //         code: item['code'],
  //         longCode: item['longCode'],
  //         gateway: item['gateway'],
  //         pay_with_bank: item['pay_with_bank'],
  //         supports_transfer: item['supports_transfer'],
  //         active: item['active'],
  //         country: item['country'],
  //         currency: item['currency'],
  //         type: item['type'],
  //         is_deleted: item['is_deleted'],
  //         createdAt: item['createdAt'],
  //         updatedAt: item['updatedAt'],
  //       ));
  //     }
  //     walletProvider.saveBankList(bankList);
  //   });
  // }


  // Delete requests

  // deleteFcy({required String id, required WalletProvider walletProvider}) {
  //   _deleteFcy(id: id).then((response) async {
  //     await getFcyAccount(walletProvider: walletProvider, currency: '');
  //     handleShowCustomToast(message: response.toString());
  //   }).catchError((error) {
  //     showErrorAlertHelper(errorMessage: handleApiFormatError(error));
  //   });
  // }

  // deleteLocalAccount({required String id, required WalletProvider walletProvider}) {
  //   _deleteLocalAccount(id: id).then((response) async {
  //     await getLocalBank(walletProvider: walletProvider);
  //     handleShowCustomToast(message: 'Bank account successfully deleted');
  //   }).catchError((error) {
  //     showErrorAlertHelper(errorMessage: handleApiFormatError(error));
  //   });
  // }

}