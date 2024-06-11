import 'dart:async';

import 'package:flutter/material.dart';
import 'package:swappr/features/profile/models/wallet_model.dart';
import '../../utils/constants/enums.dart';

class WalletProvider extends ChangeNotifier {
  List<GetWalletModel> _wallets = [];
  Currency _selectedCurrency = Currency.Select;
  WalletCurrency _selectedWalletCurrency = WalletCurrency.NGN;
  String _selectedWallet = getWalletCurrencyName(WalletCurrency.NGN);
  List<Currency> _currencies = Currency.values;
  List<WalletCurrency> _walletCurrencies = WalletCurrency.values;
  bool _showErrorText = false;
  bool showWalletLists = false;


  List<GetWalletModel> get wallets => _wallets;
  Currency get selectedCurrency => _selectedCurrency;
  WalletCurrency get selectedWalletCurrency => _selectedWalletCurrency;
  String get selectedWallet => _selectedWallet;
  List<Currency> get currencies => _currencies;
  List<WalletCurrency> get walletCurrencies => _walletCurrencies;
  bool get showErrorText => _showErrorText;

  void saveWallets(List<GetWalletModel> data) {
    _wallets = data;
    notifyListeners();
  }

  setShowWalletList() {
    showWalletLists = true;
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

  void showErrorMessage() {
    _showErrorText = true;
    notifyListeners();
    Timer(Duration(seconds: 3), () {
      _showErrorText = false;
      notifyListeners();
    });
  }

  resetState() {
    _wallets = [];
    _selectedCurrency = Currency.Select;
    showWalletLists = false;
  }
}