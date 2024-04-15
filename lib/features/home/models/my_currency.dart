import 'package:flutter/cupertino.dart';

class Currency {
  final String name;
  bool isSelected;

  Currency(this.name, {this.isSelected = false});
}

class SelectedCurrency extends ChangeNotifier {
  Currency? _selectedCurrency;

  Currency? get selectedCurrency => _selectedCurrency;

  void updatedCurrency(Currency currency) {
    _selectedCurrency = currency;
    notifyListeners();
  }
}