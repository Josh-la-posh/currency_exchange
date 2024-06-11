// currencies.dart
import 'package:swappr/data/provider/wallet_provider.dart';

enum WalletCurrency {
  NGN,
  USD,
  CAD,
  GBP,
  EUR,
}

String getWalletCurrencyName(WalletCurrency currency) {
  switch (currency) {
    case WalletCurrency.USD:
      return 'USD';
    case WalletCurrency.CAD:
      return 'CAD';
    case WalletCurrency.GBP:
      return 'GBP';
    case WalletCurrency.EUR:
      return 'EUR';
    default:
      return 'NGN';
  }
}

enum Currency {
  Select,
  NGN,
  USD,
  CAD,
  GBP,
  EUR,
}

String getCurrencyName(Currency currency) {
  switch (currency) {
    case Currency.NGN:
      return 'NGN';
    case Currency.USD:
      return 'USD';
    case Currency.CAD:
      return 'CAD';
    case Currency.GBP:
      return 'GBP';
    case Currency.EUR:
      return 'EUR';
    default:
      return 'Select';
  }
}


enum Date {
  Select,
  First,
  Second,
  Third,
  Forth,
}

String getDateValue(Date currency) {
  switch (currency) {
    case Date.First:
      return '7';
    case Date.Second:
      return '14';
    case Date.Third:
      return '21';
    case Date.Forth:
      return '28';
    default:
      return 'Select';
  }
}
