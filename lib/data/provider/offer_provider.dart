import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:swappr/utils/constants/enums.dart';

import '../../features/all_offer/models/negotiate_offer_model.dart';
import '../../features/all_offer/models/offer.dart';
import '../../features/all_offer/models/offer_details_entity.dart';

class OfferProvider extends ChangeNotifier {
  OfferDetailsEntity? _offerDetails;
  List<OfferEntity> _offers = [];
  List<NegotiateOfferModel> _negotiationsOffers = [];
  OfferEntity? _offerDetail;
  List<Currency> _currencies = Currency.values;
  Currency _selectedCurrency = Currency.NGN;
  List<Date> _dates = Date.values;
  Date _selectedDate = Date.Select;
  OfferEntity? _selectedOffer;
  Currency creditedCurrency = Currency.NGN;
  Currency debitedCurrency = Currency.NGN;
  int amount = 0;
  int rate = 0;
  int expireIn = 1;
  int negotiatorRate = 0;
  int negotiatorAmount = 0;
  String? waitingHour;
  List hours = [1, 2, 3, 4, 5];
  bool _filterAll = false;

  CreateOfferEntity _createOfferEntity = CreateOfferEntity(
      debitedCurrency: Currency.NGN, creditedCurrency: Currency.NGN, amount: 0, rate: 0, expireIn: 1);
  CreateOfferEntity get createOfferEntity => _createOfferEntity;

  OfferDetailsEntity? get offerDetails => _offerDetails;
  List<OfferEntity> get offers => _offers;
  List<NegotiateOfferModel> get negotiationsOffers => _negotiationsOffers;
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

  void saveNegotiations(List<NegotiateOfferModel> data) {
    _negotiationsOffers = data;
    notifyListeners();
  }

  setFilterAll(bool val) {
    _filterAll = val;
    notifyListeners();
  }

  void saveOffersById(OfferEntity data) {
    _offerDetail = data;
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
  // void updateSelectedSellingCurrencies(String newdebittedCurrency) {
  //   if (newdebittedCurrency != creditedCurrency) {
  //     debitedCurrency = newdebittedCurrency;
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

  resetCreateOfferDetails() {
    amount = 0;
    debitedCurrency = Currency.NGN;
    creditedCurrency = Currency.NGN;
    rate = 0;
    expireIn = 1;
  }

  resetState() {
    _offers = [];
    resetCreateOfferDetails();
    _offerDetails = null;
    _dates = [];
    _selectedOffer = null;
    _createOfferEntity.amount = 0;
    _createOfferEntity.creditedCurrency = Currency.NGN;
    _createOfferEntity.debitedCurrency = Currency.NGN;
    _createOfferEntity.rate = 0;
    _createOfferEntity.expireIn = 1;
    negotiatorAmount = 0;
    negotiatorRate = 0;
  }

}