import 'dart:async';

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
const CONVERT_RATES_URL = 'convert-rates';


final _apiService = AppInterceptor(showLoader: false).dio;

class WalletServices{
  static final WalletServices _instance = WalletServices._();

  WalletServices._();

  static WalletServices get instance => _instance;

  Future createWallet({required String currency}) async {
    final response = await _apiService.post(
        '$WALLET_URL/$CREATE_URL', data: {'currency': currency},
      );
    return response;
  }

  Future createDefaultWallet({required String walletId}) async {
    final response = await _apiService.post(
        '$WALLET_URL/$DEFAULT_WALLET_URL',
        data: {'walletId': walletId},
      );
      return response;
  }

  Future fundWalletViaNairaTransfer({required String amount}) async {
    final response = await _apiService.post(
        '$WALLET_URL/$NAIRA_TRANSFER_URL',
        data: {'amount': amount},
      );
    return response;
  }

  Future createFcy({required String currency, required String accountNumber}) async {
    final response = await _apiService.post(
        '$WALLET_URL/$CREATE_URL/fcy',
        data: {'currency': currency, 'accountNumber': accountNumber},
      );
      return response;
  }

  Future fundFcy({required String amount, required String currency}) async {
    final response = await _apiService.post(
        '$WALLET_URL/fund-fcy',
        data: {'amount': amount, 'currency': currency},
      );
      return response;
  }

  Future fundWalletViaPaystack({required String amount}) async {
    final response = await _apiService.post(
        '$WALLET_URL/$PAYSTACK_URL',
        data: {'amount': amount},
      );
      return response;
  }

  Future addLocalBank({
    required String accountNumber,
    required String accountName,
    required String bankName,
    required String bankCode,
  }) async {
    final response = await _apiService.post(
        '$WALLET_URL/$ADD_LOCAL_BANK_URL',
        data: {
          'accountNumber': accountNumber,
          'accountName': accountName,
          'bankName': bankName,
          'bankCode': bankCode,
        },
      );
      return response;
  }

  Future verifyBankAccount({
    required String accountNumber,
    required String bankCode,
  }) async {
    final response = await _apiService.get(
        '$WALLET_URL/$VERIFY_BANK_ACCOUNT_URL',
        queryParameters: {'accountNumber': accountNumber, 'bankCode': bankCode},
      );
    return response;
  }

  Future transferToLocalBank({
    required String bankId,
    required int amount,
  }) async {
    final response = await _apiService.post(
        '$WALLET_URL/$TRANSFER_LOCAL_BANK_URL',
        data: {'bankId': bankId, 'amount': amount},
      );
      return response;
  }

  Future fundWalletViaNairaUssd({
    required String amount,
    required String bank,
  }) async {
    final response = await _apiService.post(
        '$WALLET_URL/$NAIRA_USSD_URL',
        data: {'amount': amount, 'bank': bank},
      );
      return response;
  }

  Future fundWalletViaNairaBankDirect({
    required int amount,
    required String bankId,
  }) async {
    final response = await _apiService.post(
        '$WALLET_URL/$NAIRA_BANK_DIRECT_URL',
        data: {'amount': amount, 'bankId': bankId},
      );
      return response;
  }

  Future confirmBirthday({
    required String birthday,
    required String reference,
  }) async {
    final response = await _apiService.post(
        '$WALLET_URL/$CONFIRM_BIRTHDAY_URL',
        data: {'birthday': birthday, 'reference': reference},
      );
    return response;
  }

  Future confirmingOtp({
    required String otp,
    required String reference,
  }) async {
    final response = await _apiService.post(
        '$WALLET_URL/$CONFIRM_OTP_URL',
        data: {'otp': otp, 'reference': reference},
      );
      return response;
  }

  Future fetchWallets({required String currency}) async {
    final response = await _apiService.get(
        '$WALLET_URL/$GET_WALLET_URL',
        queryParameters: {'currency': currency},
      );
      return response;
  }

  Future fetchDefaultWallet() async {
    final response = await _apiService.get('$WALLET_URL/$GET_DEFAULT_WALLET_URL');
    return response;
  }

  Future fetchLocalBank() async {
    final response = await _apiService.get('$WALLET_URL/$GET_LOCAL_BANK_URL');
    return response;
  }

  Future fetchFcyAccount({required String currency}) async {
    final response = await _apiService.get(
        '$WALLET_URL/fcy-account',
        queryParameters: {'currency': currency},
      );
    return response;
  }

  Future fetchBankList() async {
    final response = await _apiService.get('$WALLET_URL/$GET_BANK_LIST_URL');
    return response;
  }

  Future fetchFxRates({required String currency}) async {
    final response = await _apiService.get(
        '$WALLET_URL/fx-rates',
        queryParameters: {
          'baseCurrency': currency
        },
      );
    return response;
  }

  Future fetchConversionRate({
    required String baseCurrency,
    required String targetCurrency,
    required double amount
  }) async {
    final response = await _apiService.get(
      '$WALLET_URL/fx-rates',
      queryParameters: {
        'baseCurrency': baseCurrency,
        'targetCurrency': targetCurrency,
        'amount': amount
      },
    );
    return response;
  }

  Future deleteFcy({required String id}) async {
    final response = await _apiService.delete('$WALLET_URL/fcy/$id');
    return response;
  }

  Future deleteLocalBankAccount({required String id}) async {
    final response = await _apiService.delete('$WALLET_URL/local-account/$id');
    return response;
  }
}