import 'dart:async';
import 'dart:ui';
import 'package:dio/dio.dart';
import '../../../data/modules/interceptor.dart';
import '../../../utils/responses/handleApiError.dart';
import '../../../utils/shared/error_dialog_response.dart';

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

  Future _createWallet({required Object data}) {
    return _apiService.post('/wallet/create', data: data);
  }

  Future _createDefaultWallet({required Object data}) {
    return _apiService.post('/wallet/default-wallet', data: data);
  }

  Future _fundWalletViaNairaTransfer({required Object data}) {
    return _apiService.post('/wallet/fund-wallet-naira-transfer', data: data);
  }

  Future _createFcy({required Object data}) {
    return _apiService.post('/wallet/create/fcy', data: data);
  }

  Future _fundFcy({required Object data}) {
    return _apiService.post('/wallet/fund-fcy', data: data);
  }

  Future _fundWalletViaPaystack({required Object data}) {
    return _apiService.post('/wallet/fund-wallet-naira-paystack', data: data);
  }

  Future _addLocalBank({required Object data}) {
    return _apiService.post('/wallet/add-local-bank', data: data);
  }

  Future _verifyBankAccount({required Map<String, dynamic> queryParameters}) {
    return _apiService.get('/wallet/verify-bank-account', queryParameters: queryParameters);
  }

  Future _transferToLocalBank({required Object data}) {
    return _apiService.post('/wallet/transfer-local-bank', data: data);
  }

  Future _fundWalletViaNairaUssd({required Object data}) {
    return _apiService.post('/wallet/fund-wallet-naira-ussd', data: data);
  }

  Future _fundWalletViaNairaBankDirect({required Object data}) {
    return _apiService.post('/wallet/fund-wallet-naira-bank-direct', data: data);
  }

  Future _confirmBirthday({required Object data}) {
    return _apiService.post('/wallet/confirm-birthday', data: data);
  }

  Future _confirmingOtp({required Object data}) {
    return _apiService.post('/wallet/confirm-otp', data: data);
  }

  Future _fetchWallets({required Map<String, dynamic> queryParameters}) {
    return _apiService.get('/wallet/get-wallets', queryParameters: queryParameters);
  }

  Future _fetchDefaultWallet() {
    return _apiService.get('/wallet/user-default-wallet');
  }

  Future _fetchLocalBank() {
    return _apiService.get('/wallet/get-local-bank');
  }

  Future _fetchFcyAccount({required Map<String, dynamic> queryParameters}) {
    return _apiService.get('/wallet/fcy-account', queryParameters: queryParameters);
  }

  Future _fetchBankList() {
    return _apiService.get('/wallet/list-banks');
  }

  Future _fetchFxRates({required Map<String, dynamic> queryParameters}) {
    return _apiService.get('/wallet/fx-rates', queryParameters: queryParameters);
  }

  Future _deleteFcy({required String id}) {
    return _apiService.delete('/wallet/fcy/$id');
  }

  Future _deleteLocalBankAccount({required String id}) {
    return _apiService.delete('/wallet/local-account/$id');
  }




  Future createWallet({required String currency, required VoidCallback onFailure}) async {
    return _createWallet(data: {'currency': currency}).then((response) {
      return response;
    }).catchError((error) {
      onFailure();
      throw (handleApiFormatError(error));
    });
  }

  Future createDefaultWallet({required String walletId, required VoidCallback onFailure}) async {
    return _createDefaultWallet(data: {'walletId': walletId}).then((response) {
      return response;
    }).catchError((error) {
      onFailure();
      throw (handleApiFormatError(error));
    });
  }

  Future fundWalletViaNairaTransfer({required String amount, required VoidCallback onFailure}) async {
    return _fundWalletViaNairaTransfer(data: {'amount': amount}).then((response) {
      return response;
    }).catchError((error) {
      onFailure();
      throw (handleApiFormatError(error));
    });
  }

  Future createFcy({required String currency, required String accountNumber, required VoidCallback onFailure}) async {
    return _createFcy(data: {'currency': currency, 'accountNumber': accountNumber}).then((response) {
      return response;
    }).catchError((error) {
      onFailure();
      throw (handleApiFormatError(error));
    });
  }

  Future fundFcy({required String amount, required String currency, required VoidCallback onFailure}) async {
    return _fundFcy(data: {'amount': amount, 'currency': currency}).then((response) {
      return response;
    }).catchError((error) {
      onFailure();
      throw (handleApiFormatError(error));
    });
  }

  Future fundWalletViaPaystack({required String amount, required VoidCallback onFailure}) async {
    return _fundWalletViaPaystack(data: {'amount': amount}).then((response) {
      return response;
    }).catchError((error) {
      onFailure();
      throw (handleApiFormatError(error));
    });
  }

  Future addLocalBank({
    required String accountNumber,
    required String accountName,
    required String bankName,
    required String bankCode,
    required VoidCallback onFailure
  }) async {
    return _addLocalBank(data: {
      'accountNumber': accountNumber,
      'accountName': accountName,
      'bankName': bankName,
      'bankCode': bankCode,
    }).then((response) {
      return response;
    }).catchError((error) {
      onFailure();
      throw (handleApiFormatError(error));
    });
  }

  Future verifyBankAccount({
    required String accountNumber,
    required String bankCode,
    required VoidCallback onFailure
  }) async {
    return _verifyBankAccount(
        queryParameters: {'accountNumber': accountNumber, 'bankCode': bankCode}).then((response) {
      return response;
    }).catchError((error) {
      onFailure();
      throw (handleApiFormatError(error));
    });
  }

  Future transferToLocalBank({
    required String bankId,
    required int amount,
    required VoidCallback onFailure
  }) async {
    return _transferToLocalBank(
        data: {'bankId': bankId, 'amount': amount}).then((response) {
      return response;
    }).catchError((error) {
      onFailure();
      throw (handleApiFormatError(error));
    });
  }

  Future fundWalletViaNairaUssd({
    required String amount,
    required String bank,
    required VoidCallback onFailure
  }) async {
    return _fundWalletViaNairaUssd(
        data: {'amount': amount, 'bank': bank}).then((response) {
      return response;
    }).catchError((error) {
      onFailure();
      throw (handleApiFormatError(error));
    });
  }

  Future fundWalletViaNairaBankDirect({
    required int amount,
    required String bankId,
    required VoidCallback onFailure
  }) async {
    return _fundWalletViaNairaBankDirect(
        data: {'amount': amount, 'bankId': bankId}).then((response) {
      return response;
    }).catchError((error) {
      onFailure();
      throw (handleApiFormatError(error));
    });
  }

  Future confirmBirthday({
    required String birthday,
    required String reference,
    required VoidCallback onFailure
  }) async {
    return _confirmBirthday(
        data: {'birthday': birthday, 'reference': reference}).then((response) {
      return response;
    }).catchError((error) {
      onFailure();
      throw (handleApiFormatError(error));
    });
  }

  Future confirmingOtp({
    required String otp,
    required String reference,
    required VoidCallback onFailure
  }) async {
    return _confirmingOtp(
        data: {'otp': otp, 'reference': reference}).then((response) {
      return response;
    }).catchError((error) {
      onFailure();
      throw (handleApiFormatError(error));
    });
  }

  Future fetchWallets({
    required String currency,
    required VoidCallback onFailure
  }) async {
    return _fetchWallets(
        queryParameters: {'currency': currency}).then((response) {
      return response;
    }).catchError((error) {
      onFailure();
      throw (handleApiFormatError(error));
    });
  }

  Future fetchDefaultWallet({required VoidCallback onFailure}) async {
    return _fetchDefaultWallet().then((response) {
      return response;
    }).catchError((error) {
      onFailure();
      throw (handleApiFormatError(error));
    });
  }

  Future fetchLocalBank({required VoidCallback onFailure}) async {
    return _fetchLocalBank().then((response) {
      return response;
    }).catchError((error) {
      onFailure();
      throw (handleApiFormatError(error));
    });
  }

  Future fetchFcyAccount({
    required String currency,
    required VoidCallback onFailure
  }) async {
    return _fetchFcyAccount(queryParameters: {'currency': currency}).then((response) {
      return response;
    }).catchError((error) {
      onFailure();
      throw (handleApiFormatError(error));
    });
  }

  Future fetchBankList({required VoidCallback onFailure}) async {
    return _fetchBankList().then((response) {
      return response;
    }).catchError((error) {
      onFailure();
      throw (handleApiFormatError(error));
    });
  }

  Future fetchFxRates({
    required String currency,
    required VoidCallback onFailure
  }) async {
    return _fetchFxRates(queryParameters: {
      'baseCurrency': currency
    }).then((response) {
      return response;
    }).catchError((error) {
      onFailure();
      throw (handleApiFormatError(error));
    });
  }

  Future fetchConversionRate({
    required String baseCurrency,
    required String targetCurrency,
    required double amount,
    required VoidCallback onFailure
  }) async {
    return _fetchFxRates(queryParameters: {
      'baseCurrency': baseCurrency,
      'targetCurrency': targetCurrency,
      'amount': amount
    }).then((response) {
      return response;
    }).catchError((error) {
      onFailure();
      throw (handleApiFormatError(error));
    });
  }

  Future deleteFcy({
    required String id,
    required VoidCallback onFailure
  }) async {
    return _deleteFcy(id: id).then((response) {
      return response;
    }).catchError((error) {
      onFailure();
      throw (handleApiFormatError(error));
    });
  }

  Future deleteLocalBankAccount({
    required String id,
    required VoidCallback onFailure
  }) async {
    return _deleteLocalBankAccount(id: id).then((response) {
      return response;
    }).catchError((error) {
      onFailure();
      throw (handleApiFormatError(error));
    });
  }
}