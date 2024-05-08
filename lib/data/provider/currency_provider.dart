import 'package:flutter/foundation.dart';
import '../../utils/constants/enums.dart';

class CurrencyProvider extends ChangeNotifier {
  Currency _selectedCurrency = Currency.Select;
  List<Currency> _currencies = Currency.values;


  Currency get selectedCurrency => _selectedCurrency;
  List<Currency> get currencies => _currencies;

  void setSelectedCurrency(Currency currency) {
    _selectedCurrency = currency;
    notifyListeners();
  }

  resetState() {
    _currencies = [];
    _selectedCurrency = Currency.Select;
  }
}