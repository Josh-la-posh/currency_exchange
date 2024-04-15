import 'package:flutter/foundation.dart';
import 'package:swappr/features/home/models/my_currency.dart';

class CurrencyProvider extends ChangeNotifier {

  int selectedCurrency = 0;

  final List<Currency> _currencies = [
    // Currency('USD'),
    Currency('EUR'),
    Currency('GBP'),
    Currency('NGN'),
  ];

  List<Currency>? get currencies => _currencies;
  SelectedCurrency selectedCurrencyProvider = SelectedCurrency();

  void updateCurrency(Currency currency) {
    for (var item in _currencies) {
      item.isSelected = (item == currency);
    }
    selectedCurrencyProvider.updatedCurrency(currency);
    notifyListeners();
  }
}