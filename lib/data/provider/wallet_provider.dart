import 'dart:async';

import 'package:flutter/material.dart';
import 'package:swappr/features/wallet/models/bank_list.dart';
import 'package:swappr/features/wallet/models/bank_list_entity.dart';
import 'package:swappr/features/wallet/models/default_wallet_model.dart';
import 'package:swappr/features/wallet/models/fcy_account_entity.dart';
import 'package:swappr/features/wallet/models/fcy_account_model.dart';
import 'package:swappr/features/wallet/models/flutterwave_model.dart';
import 'package:swappr/features/wallet/models/get_bank_account.dart';
import 'package:swappr/features/wallet/models/paystack_model.dart';
import '../../features/wallet/models/get_wallet.dart';
import '../../features/wallet/models/ussd_modal.dart';
import '../../features/wallet/models/verify_bank_account_model.dart';
import '../../utils/constants/enums.dart';

class WalletProvider extends ChangeNotifier {
  List<GetWalletModel> _wallets = [];
  GetWalletModel? _selectedWallet;
  List<GetBankAccountModel> _savedBankAccounts = [];
  BankListEntity? _bankListEntity;
  GetFcyAccountEntity? _fcyAccountDetails;
  List<FcyAccountModel> _fcyAccount = [];
  Currency _selectedCurrency = Currency.NGN;
  WalletCurrency _selectedWalletCurrency = WalletCurrency.NGN;
  List<Currency> _currencies = Currency.values;
  List<WalletCurrency> _walletCurrencies = WalletCurrency.values;
  List<BankListModel> _bankList = [];
  BankListModel? _selectedBank;
  FlutterwaveModel? _flutterwaveModel;
  PaystackModel? _paystackModel;
  UssdModel? _ussdModel;
  VerifyBankAccountModel? _bankAccountDetails;
  bool _showErrorText = false;
  bool showWalletLists = false;
  bool showBankTransferOption = false;
  bool showWalletBalance = false;
  Bank _selectedNigBank = Bank.GTB;
  List<Bank> _nigBanks = Bank.values;

  DefaultWalletModel? defaultWalletDetail;





  List<GetWalletModel> get wallets => _wallets;
  GetWalletModel? get selectedWallet => _selectedWallet;
  List<GetBankAccountModel> get savedBankAccounts => _savedBankAccounts;
  GetFcyAccountEntity? get fcyAccountDetails => _fcyAccountDetails;
  BankListEntity? get bankListEntity => _bankListEntity;
  List<FcyAccountModel> get fcyAccount => _fcyAccount;
  Currency get selectedCurrency => _selectedCurrency;
  WalletCurrency get selectedWalletCurrency => _selectedWalletCurrency;
  List<Currency> get currencies => _currencies;
  List<WalletCurrency> get walletCurrencies => _walletCurrencies;
  List<BankListModel> get bankList => _bankList;
  bool get showErrorText => _showErrorText;
  List<BankListModel> filteredBanks = [];
  BankListModel? get selectedBank => _selectedBank;
  FlutterwaveModel? get flutterwaveModel => _flutterwaveModel;
  PaystackModel? get paystackModel => _paystackModel;
  UssdModel? get ussdModel => _ussdModel;
  VerifyBankAccountModel? get bankAccountDetails => _bankAccountDetails;
  Bank get selectedNigBank => _selectedNigBank;
  List<Bank> get nigBanks => _nigBanks;

  DefaultWalletModel? get defaultWallet => defaultWalletDetail;


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

  void setSelectedWallet(GetWalletModel? data) {
    _selectedWallet = data;
    notifyListeners();
  }

  void saveBankAccounts(List<GetBankAccountModel> data) {
    _savedBankAccounts = data;
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

  void saveUssdDetail(UssdModel? val) {
    _ussdModel = val;
    notifyListeners();
    print('get paystack ${val?.reference}');
  }

  void saveBankAccountDetails(VerifyBankAccountModel? val) {
    _bankAccountDetails = val;
    notifyListeners();
  }

  void saveFcyAccount(List<FcyAccountModel> val) {
    _fcyAccount = val;
    notifyListeners();
  }

  setShowWalletList() {
    showWalletLists = !showWalletLists;
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

  void setSelectedNigBank(Bank bank) {
    _selectedNigBank = bank;
    notifyListeners();
  }

  void setSelectedWalletCurrency(WalletCurrency currency) {
    _selectedWalletCurrency = currency;
    notifyListeners();
  }

  void setSelectedBank(BankListModel? val) {
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

  void setShowWalletBalance(val) {
    showWalletBalance = val as bool;
    notifyListeners();
  }

  void setDefaultWallet(DefaultWalletModel? wallet) {
    defaultWalletDetail = wallet;
    print('default $defaultWallet');
    notifyListeners();
  }

  resetState() {
    _wallets = [];
    _selectedWallet = null;
    _selectedCurrency = Currency.NGN;
    _selectedWalletCurrency = WalletCurrency.NGN;
    showWalletLists = false;
    _fcyAccountDetails = null;
    _bankListEntity = null;
    _fcyAccount = [];
    filteredBanks = [];
    _bankList = [];
    _selectedBank = null;
    _flutterwaveModel = null;
    _paystackModel = null;
    _ussdModel = null;
    _bankAccountDetails = null;
    _selectedNigBank = Bank.GTB;
    defaultWalletDetail = null;
  }
}