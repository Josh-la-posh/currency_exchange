import 'dart:async';

import 'package:flutter/material.dart';
import 'package:swappr/features/profile/models/wallet_model.dart';
import '../../utils/constants/enums.dart';

class WalletProvider extends ChangeNotifier {
  List<GetWalletModel> _wallets = [];
  Currency _selectedCurrency = Currency.Select;
  List<Currency> _currencies = Currency.values;
  bool _showErrorText = false;


  List<GetWalletModel> get wallets => _wallets;
  Currency get selectedCurrency => _selectedCurrency;
  List<Currency> get currencies => _currencies;
  bool get showErrorText => _showErrorText;

  void saveWallets(List<GetWalletModel> data) {
    _wallets = data;
    notifyListeners();
  }

  void setSelectedCurrency(Currency currency) {
    _selectedCurrency = currency;
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
    // _currencies = [];
    _selectedCurrency = Currency.Select;
  }
}