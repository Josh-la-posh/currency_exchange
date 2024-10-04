import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/utils/responses/handleApiError.dart';

import '../../../data/modules/interceptor.dart';

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

}