import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:swappr/features/home/models/offer.dart';

class OfferProvider extends ChangeNotifier {
  final List<OfferEntity> _offers = [];
  OfferEntity? _selectedOffer;
  String? buyingCurrency;
  String? sellingCurrency;
  String? waitingHour;
  List<String> currencies;
  List hours = ['1', '2', '3', '4', '5'];

  List<String> get availableBuyingCurrencies {
    if (sellingCurrency == null) return currencies;
    if (sellingCurrency == buyingCurrency) return currencies;
    return currencies.where((currency) => currency != sellingCurrency).toList();
  }

  CreateOfferEntity _createOfferEntity = CreateOfferEntity(hasAmount: '', minimumRate: '', preferredRate: '', selectedCurrency: '', expireHour: '', neededCurrency: '');
  CreateOfferEntity get createOfferEntity => _createOfferEntity;

  List<OfferEntity> get offers => _offers;
  OfferEntity? get selectedOffer => _selectedOffer;

  // Future<void> fetchOffers() async {
  //   // await Future.delayed(Duration(seconds: 2));
  //   final response = await '';
  //
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body) as List<dynamic>;
  //     _offers.addAll(
  //       data.map((dynamic offerData) => Offer.fromJson(offerData)).toList());
  //   } else {
  //     print('Error fetching offers: ${response.statusCode}');
  //   }
  //   notifyListeners();
  // }


  OfferProvider(this.currencies);

  void updateSelectedBuyingCurrencies(String newBuyingCurrency) {
    if (newBuyingCurrency != sellingCurrency) {
      buyingCurrency = newBuyingCurrency;
      notifyListeners();
    } else {
      sellingCurrency = 'select';
      notifyListeners();
    }
  }

  void updateSelectedSellingCurrencies(String newSellingCurrency) {
    if (newSellingCurrency != buyingCurrency) {
      sellingCurrency = newSellingCurrency;
      notifyListeners();
    } else {
      sellingCurrency = 'select';
      notifyListeners();
    }
  }

  void setSelectedOffer(OfferEntity offer) {
    _selectedOffer = offer;
    notifyListeners();
  }

  void updateHasAmount(String amount) {
    _createOfferEntity.hasAmount = amount;
    notifyListeners();
  }

  void updateNeedAmount(String amount) {
    _createOfferEntity.neededCurrency = amount;
    notifyListeners();
  }

  void updateHasCurrency(String currency) {
    _createOfferEntity.selectedCurrency = currency;
    notifyListeners();
  }

  void updateNeededCurrency(String currency) {
    _createOfferEntity.neededCurrency = currency;
    notifyListeners();
  }

  void updatePreferredRate(String amount) {
    _createOfferEntity.preferredRate = amount;
    notifyListeners();
  }

  void updateMinimumRate(String amount) {
    _createOfferEntity.minimumRate = amount;
    notifyListeners();
  }

  void updateExpiryHour(String time) {
    _createOfferEntity.expireHour = time;
    notifyListeners();
  }

}