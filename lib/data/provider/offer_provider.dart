import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:pouch/features/all_offer/models/create_offer_response.dart';
import 'package:pouch/utils/constants/enums.dart';

import '../../features/all_offer/models/negotiate_offer_model.dart';
import '../../features/all_offer/models/offer.dart';
import '../../features/all_offer/models/offer_details_entity.dart';

class OfferProvider extends ChangeNotifier {
  OfferDetailsEntity? _offerDetails;


  List<OfferEntity> tOffers = [];
  List<OfferEntity> _allOffers = [];
  List<OfferEntity> _usdOffers = [];
  List<OfferEntity> _ngnOffers = [];
  List<OfferEntity> _gbpOffers = [];
  List<OfferEntity> _cadOffers = [];
  List<OfferEntity> _eurOffers = [];
  List<OfferEntity> _allNewOffers = [];
  List<OfferEntity> _usdNewOffers = [];
  List<OfferEntity> _ngnNewOffers = [];
  List<OfferEntity> _gbpNewOffers = [];
  List<OfferEntity> _cadNewOffers = [];
  List<OfferEntity> _eurNewOffers = [];
  List<OfferEntity> _allTrendingOffers = [];
  List<OfferEntity> _usdTrendingOffers = [];
  List<OfferEntity> _ngnTrendingOffers = [];
  List<OfferEntity> _gbpTrendingOffers = [];
  List<OfferEntity> _cadTrendingOffers = [];
  List<OfferEntity> _eurTrendingOffers = [];




  CreateOfferResponse? _offerResponse;
  List<NegotiateOfferModel> _negotiationsOffers = [];
  List<NegotiateOfferModel> _myOffers = [];
  List<NegotiateOfferModel> _myBids = [];
  OfferEntity? _offerDetail;
  List<Currency> _currencies = Currency.values;
  Currency _selectedCurrency = Currency.NGN;
  List<Date> _dates = Date.values;
  Date _selectedDate = Date.First;
  OfferEntity? _selectedOffer;
  Currency creditedCurrency = Currency.NGN;
  Currency debitedCurrency = Currency.NGN;
  int amount = 0;
  String rate = '';
  String expireIn = '1';
  int negotiatorRate = 0;
  int negotiatorAmount = 0;
  String? waitingHour;
  List hours = ['1', '2', '3', '4', '5', '24', '48', '72', 'Never'];
  bool _filterAll = false;

  CreateOfferEntity _createOfferEntity = CreateOfferEntity(
      debitedCurrency: Currency.NGN, creditedCurrency: Currency.NGN, amount: 0, rate: '', expireIn: '1');
  CreateOfferEntity get createOfferEntity => _createOfferEntity;

  OfferDetailsEntity? get offerDetails => _offerDetails;


  List<OfferEntity> get offers => tOffers;
  List<OfferEntity> get allOffers => _allOffers;
  List<OfferEntity> get usdOffers => _usdOffers;
  List<OfferEntity> get ngnOffers => _ngnOffers;
  List<OfferEntity> get gbpOffers => _gbpOffers;
  List<OfferEntity> get cadOffers => _cadOffers;
  List<OfferEntity> get eurOffers => _eurOffers;
  List<OfferEntity> get allNewOffers => _allNewOffers;
  List<OfferEntity> get usdNewOffers => _usdNewOffers;
  List<OfferEntity> get ngnNewOffers => _ngnNewOffers;
  List<OfferEntity> get gbpNewOffers => _gbpNewOffers;
  List<OfferEntity> get cadNewOffers => _cadNewOffers;
  List<OfferEntity> get eurNewOffers => _eurNewOffers;
  List<OfferEntity> get allTrendingOffers => _allTrendingOffers;
  List<OfferEntity> get usdTrendingOffers => _usdTrendingOffers;
  List<OfferEntity> get ngnTrendingOffers => _ngnTrendingOffers;
  List<OfferEntity> get gbpTrendingOffers => _gbpTrendingOffers;
  List<OfferEntity> get cadTrendingOffers => _cadTrendingOffers;
  List<OfferEntity> get eurTrendingOffers => _eurTrendingOffers;



  List<NegotiateOfferModel> get negotiationsOffers => _negotiationsOffers;
  List<NegotiateOfferModel> get myOffers => _myOffers;
  List<NegotiateOfferModel> get myBids => _myBids;
  OfferEntity? get offerDetail => _offerDetail;
  OfferEntity? get selectedOffer => _selectedOffer;
  List<Currency> get currencies => _currencies;
  Currency get selectedCurrency => _selectedCurrency;
  List<Date> get dates => _dates;
  Date get selectedDate => _selectedDate;
  bool get filterAll => _filterAll;
  CreateOfferResponse? get offerResponse => _offerResponse;



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
    tOffers = data;
    notifyListeners();
  }

  void saveAllOffers(List<OfferEntity> data) {
    _allOffers = data;
    notifyListeners();
  }

  void saveUsdOffers(List<OfferEntity> data) {
    _usdOffers = data;
    notifyListeners();
  }

  void saveNgnOffers(List<OfferEntity> data) {
    _ngnOffers = data;
    notifyListeners();
  }

  void saveGbpOffers(List<OfferEntity> data) {
    _gbpOffers = data;
    notifyListeners();
  }

  void saveCadOffers(List<OfferEntity> data) {
    _cadOffers = data;
    notifyListeners();
  }

  void saveEurOffers(List<OfferEntity> data) {
    _eurOffers = data;
    notifyListeners();
  }

  void saveAllNewOffers(List<OfferEntity> data) {
    _allNewOffers = data;
    notifyListeners();
  }

  void saveUsdNewOffers(List<OfferEntity> data) {
    _usdNewOffers = data;
    notifyListeners();
  }

  void saveNgnNewOffers(List<OfferEntity> data) {
    _ngnNewOffers = data;
    notifyListeners();
  }

  void saveGbpNewOffers(List<OfferEntity> data) {
    _gbpNewOffers = data;
    notifyListeners();
  }

  void saveCadNewOffers(List<OfferEntity> data) {
    _cadNewOffers = data;
    notifyListeners();
  }

  void saveEurNewOffers(List<OfferEntity> data) {
    _eurNewOffers = data;
    notifyListeners();
  }

  void saveAllTrendingOffers(List<OfferEntity> data) {
    _allTrendingOffers = data;
    notifyListeners();
  }

  void saveUsdTrendingOffers(List<OfferEntity> data) {
    _usdTrendingOffers = data;
    notifyListeners();
  }

  void saveNgnTrendingOffers(List<OfferEntity> data) {
    _ngnTrendingOffers = data;
    notifyListeners();
  }

  void saveGbpTrendingOffers(List<OfferEntity> data) {
    _gbpTrendingOffers = data;
    notifyListeners();
  }

  void saveCadTrendingOffers(List<OfferEntity> data) {
    _cadTrendingOffers = data;
    notifyListeners();
  }

  void saveEurTrendingOffers(List<OfferEntity> data) {
    _eurTrendingOffers = data;
    notifyListeners();
  }

  void saveNegotiations(List<NegotiateOfferModel> data) {
    _negotiationsOffers = data;
    notifyListeners();
  }

  void saveMyOffers(List<NegotiateOfferModel> data) {
    _myOffers = data;
    notifyListeners();
  }

  void saveMyBids(List<NegotiateOfferModel> data) {
    _myBids = data;
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

  void saveOfferResponse(CreateOfferResponse? data) {
    _offerResponse = data;
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
    _createOfferEntity.rate = val;
    rate = val;
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
    rate = '';
    expireIn = '1';
    _createOfferEntity.amount = 0;
    _createOfferEntity.creditedCurrency = Currency.NGN;
    _createOfferEntity.debitedCurrency = Currency.NGN;
    _createOfferEntity.rate = '';
    _createOfferEntity.expireIn = '1';
  }

  resetState() {
    tOffers = [];
    _allOffers = [];
    _usdOffers = [];
    _ngnOffers = [];
    _gbpOffers = [];
    _cadOffers = [];
    _eurOffers = [];
    _allNewOffers = [];
    _usdNewOffers = [];
    _ngnNewOffers = [];
    _gbpNewOffers = [];
    _cadNewOffers = [];
    _eurNewOffers = [];
    _allTrendingOffers = [];
    _usdTrendingOffers = [];
    _ngnTrendingOffers = [];
    _gbpTrendingOffers = [];
    _cadTrendingOffers = [];
    _eurTrendingOffers = [];
    resetCreateOfferDetails();
    _offerDetails = null;
    _selectedOffer = null;
    negotiatorAmount = 0;
    negotiatorRate = 0;
    _offerResponse = null;
    _myOffers = [];
    _myBids = [];
    _negotiationsOffers = [];
  }

}