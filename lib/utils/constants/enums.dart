// currencies.dart
import 'package:pouch/data/provider/wallet_provider.dart';

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
      return 'NGN';
  }
}


enum Date {
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
      return '';
  }
}

enum Bank {
  GTB,
  UBA,
  Sterling,
  Zenith,
}

String getBankName(Bank bank) {
  switch (bank) {
    case Bank.UBA:
      return 'UBA';
    case Bank.Sterling:
      return 'Sterling';
    case Bank.Zenith:
      return 'Zenith';
    default:
      return 'GTB';

  }
}
