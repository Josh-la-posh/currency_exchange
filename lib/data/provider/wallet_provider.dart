import 'dart:async';

import 'package:flutter/material.dart';
import 'package:swappr/features/wallet/models/bank_list.dart';
import 'package:swappr/features/wallet/models/bank_list_entity.dart';
import 'package:swappr/features/wallet/models/fcy_account_entity.dart';
import 'package:swappr/features/wallet/models/fcy_account_model.dart';
import 'package:swappr/features/wallet/models/flutterwave_model.dart';
import 'package:swappr/features/wallet/models/paystack_model.dart';
import '../../features/wallet/models/get_wallet.dart';
import '../../utils/constants/enums.dart';

class WalletProvider extends ChangeNotifier {
  List<GetWalletModel> _wallets = [];
  GetFcyAccountEntity? _fcyAccountDetails;
  BankListEntity? _bankListEntity;
  List<FcyAccountModel> _fcyAccount = [];
  Currency _selectedCurrency = Currency.Select;
  WalletCurrency _selectedWalletCurrency = WalletCurrency.NGN;
  String _selectedWallet = getWalletCurrencyName(WalletCurrency.NGN);
  List<Currency> _currencies = Currency.values;
  List<WalletCurrency> _walletCurrencies = WalletCurrency.values;
  List<BankListModel> _bankList = [];
  BankListModel? _selectedBank;
  FlutterwaveModel? _flutterwaveModel;
  PaystackModel? _paystackModel;
  bool _showErrorText = false;
  bool showWalletLists = false;
  bool showBankTransferOption = false;


  List<GetWalletModel> get wallets => _wallets;
  GetFcyAccountEntity? get fcyAccountDetails => _fcyAccountDetails;
  BankListEntity? get bankListEntity => _bankListEntity;
  List<FcyAccountModel> get fcyAccount => _fcyAccount;
  Currency get selectedCurrency => _selectedCurrency;
  WalletCurrency get selectedWalletCurrency => _selectedWalletCurrency;
  String get selectedWallet => _selectedWallet;
  List<Currency> get currencies => _currencies;
  List<WalletCurrency> get walletCurrencies => _walletCurrencies;
  List<BankListModel> get bankList => _bankList;
  bool get showErrorText => _showErrorText;
  List<BankListModel> filteredBanks = [];
  BankListModel? get selectedBank => _selectedBank;
  FlutterwaveModel? get flutterwaveModel => _flutterwaveModel;
  PaystackModel? get paystackModel => _paystackModel;


  void filterBanks(String searchText) {
    filteredBanks = bankList.where((bank) =>
    bank.name!.toLowerCase().contains(searchText.toLowerCase())
    ).toList();
    notifyListeners();
  }

  void saveWallets(List<GetWalletModel> data) {
    _wallets = data;
    notifyListeners();
  }

  void saveFlutterwaveDetails(FlutterwaveModel? val) {
    _flutterwaveModel = val;
    notifyListeners();
  }

  void savePaystackDetails(PaystackModel? val) {
    _paystackModel = val;
    notifyListeners();
    print('get paystack ${val?.account_name}');
  }

  void saveFcyAccount(List<FcyAccountModel> val) {
    _fcyAccount = val;
    notifyListeners();
  }

  setShowWalletList() {
    showWalletLists = true;
    notifyListeners();
  }
  void saveFcyAccountDetails(GetFcyAccountEntity val) {
    _fcyAccountDetails = val;
    notifyListeners();
  }

  removeShowWalletList() {
    showWalletLists = false;
    notifyListeners();
  }

  void setSelectedCurrency(Currency currency) {
    _selectedCurrency = currency;
    notifyListeners();
  }

  void setSelectedWalletCurrency(WalletCurrency currency) {
    _selectedWalletCurrency = currency;
    notifyListeners();
  }

  void setSelectedWallet(String? currency) {
    _selectedWallet = currency!;
    notifyListeners();
  }

  void setSelectedBank(BankListModel val) {
    _selectedBank = val;
    notifyListeners();
  }

  void showErrorMessage() {
    _showErrorText = true;
    notifyListeners();
    Timer(Duration(seconds: 3), () {
      _showErrorText = false;
      notifyListeners();
    });
  }

  void saveBankList(List<BankListModel> val) {
    _bankList = val;
    notifyListeners();
  }

  void setShowBankTransferOption(val) {
    showBankTransferOption = val as bool;
    notifyListeners();
  }

  resetState() {
    _wallets = [];
    _selectedCurrency = Currency.Select;
    showWalletLists = false;
    _fcyAccount = [];
    _bankList = [];
  }
}