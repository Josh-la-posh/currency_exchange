import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:swappr/features/home/models/offer.dart';
import 'package:swappr/features/home/models/offer_details_entity.dart';
import 'package:swappr/utils/constants/enums.dart';

class OfferProvider extends ChangeNotifier {
  OfferDetailsEntity? _offerDetails;
  List<OfferEntity> _offers = [];
  OfferEntity? _offerDetail;
  List<Currency> _currencies = Currency.values;
  Currency _selectedCurrency = Currency.Select;
  List<Date> _dates = Date.values;
  Date _selectedDate = Date.Select;
  OfferEntity? _selectedOffer;
  Currency creditedCurrency = Currency.Select;
  Currency debitedCurrency = Currency.Select;
  int amount = 0;
  int rate = 0;
  int expireIn = 1;
  int negotiatorRate = 0;
  int negotiatorAmount = 0;
  String? waitingHour;
  List hours = [1, 2, 3, 4, 5];
  bool _filterAll = false;

  CreateOfferEntity _createOfferEntity = CreateOfferEntity(
      debitedCurrency: Currency.Select, creditedCurrency: Currency.Select, amount: 0, rate: 0, expireIn: 1);
  CreateOfferEntity get createOfferEntity => _createOfferEntity;

  OfferDetailsEntity? get offerDetails => _offerDetails;
  List<OfferEntity> get offers => _offers;
  OfferEntity? get offerDetail => _offerDetail;
  OfferEntity? get selectedOffer => _selectedOffer;
  List<Currency> get currencies => _currencies;
  Currency get selectedCurrency => _selectedCurrency;
  List<Date> get dates => _dates;
  Date get selectedDate => _selectedDate;
  bool get filterAll => _filterAll;



  List<Currency> get availableBuyingCurrencies {
    if (debitedCurrency == null) return currencies;
    if (debitedCurrency == creditedCurrency) return currencies;
    return currencies.where((currency) => currency != debitedCurrency).toList();
  }

  void saveOfferDetails(OfferDetailsEntity data) {
    _offerDetails = data;
    notifyListeners();
  }

  void saveOffers(List<OfferEntity> data) {
    _offers = data;
    notifyListeners();
  }

  setFilterAll(bool val) {
    _filterAll = val;
    notifyListeners();
  }

  void saveOffersById(OfferEntity id) {
    _offerDetail = id;
    notifyListeners();
  }

  // void updateSelectedBuyingCurrencies(String newBuyingCurrency) {
  //   if (newBuyingCurrency != debitedCurrency) {
  //     creditedCurrency = newBuyingCurrency;
  //     notifyListeners();
  //   } else {
  //     debitedCurrency = 'select';
  //     notifyListeners();
  //   }
  // }
  //
  // void updateSelectedSellingCurrencies(String newdebitedCurrency) {
  //   if (newdebitedCurrency != creditedCurrency) {
  //     debitedCurrency = newdebitedCurrency;
  //     notifyListeners();
  //   } else {
  //     debitedCurrency = 'select';
  //     notifyListeners();
  //   }
  // }

  void setSelectedCurrency(Currency val) {
    _selectedCurrency = val;
    notifyListeners();
  }

  void setSelectedDate(Date val) {
    _selectedDate = val;
    notifyListeners();
  }

  void setSelectedOffer(OfferEntity offer) {
    _selectedOffer = offer;
    notifyListeners();
  }

  void updateAmount(String val) {
    _createOfferEntity.amount = int.parse(val);
    amount = int.parse(val);
  }

  void updateDebitedCurrency(Currency currency) {
    _createOfferEntity.debitedCurrency = currency;
    debitedCurrency = currency;
    notifyListeners();
  }

  void updateCreditedCurrency(Currency currency) {
    _createOfferEntity.creditedCurrency = currency;
    creditedCurrency = currency;
    notifyListeners();
  }

  void updateRate(String val) {
    _createOfferEntity.rate = int.parse(val);
    rate = int.parse(val);
    notifyListeners();
  }

  // void updateMinimumRate(String amount) {
  //   _createOfferEntity.minimumRate = amount;
  //   notifyListeners();
  // }

  void updateExpiryIn(time) {
    _createOfferEntity.expireIn = time;
    expireIn = time;
    notifyListeners();
  }

  void setNegotiatorAmount(String val) {
    negotiatorAmount = int.parse(val);
    notifyListeners();
  }

  void setNegotiatorRate(String val) {
    negotiatorRate = int.parse(val);
    notifyListeners();
  }

  resetState() {
    _offers = [];
    _offerDetails = null;
    // _currencies = [];
    _dates = [];
    creditedCurrency = Currency.Select;
    debitedCurrency = Currency.Select;
    _selectedOffer = null;
    _createOfferEntity.amount = 0;
    _createOfferEntity.creditedCurrency = Currency.Select;
    _createOfferEntity.debitedCurrency = Currency.Select;
    _createOfferEntity.rate = 0;
    amount = 0;
    rate = 0;
    // _createOfferEntity.minimumRate = '';
    _createOfferEntity.expireIn = 0;
    negotiatorAmount = 0;
    negotiatorRate = 0;
  }

}