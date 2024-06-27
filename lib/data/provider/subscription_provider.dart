import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:swappr/features/subscription/models/subscribeEnity.dart';
import 'package:swappr/features/subscription/models/subscription_details.dart';
import 'package:swappr/utils/constants/enums.dart';

class SubscriptionProvider extends ChangeNotifier {
  SubscriptionDetailsEntity? _subscriptionDetails;
  List<SubscriptionEntity> _subscriptions = [];
  List<Currency> _currencies = Currency.values;
  CreateSubscription _createSubscription = CreateSubscription(
      debitedCurrency: Currency.NGN, creditedCurrency: Currency.NGN, minRate: 0, maxRate: 0);

  Currency debitedCurrency = Currency.NGN;
  Currency creditedCurrency = Currency.NGN;
  final formKey = GlobalKey<FormState>();



  SubscriptionDetailsEntity? get subscriptionDetails => _subscriptionDetails;
  List<SubscriptionEntity> get subscriptions => _subscriptions;
  List<Currency> get currencies => _currencies;
  CreateSubscription? get createSubscription => _createSubscription;


  void saveSubscriptionDetails(SubscriptionDetailsEntity val) {
    _subscriptionDetails = val;
    notifyListeners();
  }
  void saveSubscriptions(List<SubscriptionEntity> val) {
    _subscriptions = val;
    notifyListeners();
  }

  void setDebitedCurrency(Currency val) {
    _createSubscription.debitedCurrency = val;
    notifyListeners();
  }

  void setCreditedCurrency(Currency val) {
    _createSubscription.creditedCurrency = val;
    notifyListeners();
  }

  void setMinRate(String amount) {
    _createSubscription.minRate = int.parse(amount);
    notifyListeners();
  }

  void setMaxRate(String amount) {
    _createSubscription.maxRate = int.parse(amount);
    notifyListeners();
  }

  resetState() {
    _subscriptionDetails = null;
    _subscriptions = [];
    _createSubscription.debitedCurrency = Currency.NGN;
    _createSubscription.creditedCurrency = Currency.NGN;
    _createSubscription.minRate = 0;
    _createSubscription.maxRate = 0;
    notifyListeners();
  }

}