import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:swappr/features/home/models/offer.dart';
import 'package:swappr/features/subscription/models/subscribeEnity.dart';

class SubscriptionProvider extends ChangeNotifier {
  final List<SubscriptionEntity> _subscriptions = [];
  String? buyingCurrency;
  String? sellingCurrency;
  // List<String> currencies;

  SubscriptionEntity _subscriptionEntity = SubscriptionEntity(sellingCurrency: '', buyingCurrency: '', minimumRate: '', maximumRate: '');
  SubscriptionEntity get subscriptionEntity => _subscriptionEntity;

  List<SubscriptionEntity> get subscriptions => _subscriptions;

  void updateNeededCurrency(String currency) {
    _subscriptionEntity.buyingCurrency= currency;
    notifyListeners();
  }

  void updateHasCurrency(String currency) {
    _subscriptionEntity.sellingCurrency = currency;
    notifyListeners();
  }

  void updateMaximumRate(String amount) {
    _subscriptionEntity.maximumRate = amount;
    notifyListeners();
  }

  void updateMinimumRare(String amount) {
    _subscriptionEntity.minimumRate = amount;
    notifyListeners();
  }

}