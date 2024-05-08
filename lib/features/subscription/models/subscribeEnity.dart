

import 'package:swappr/utils/constants/enums.dart';

class SubscriptionEntity{
  String id;
  String currency;
  int minRate;
  int maxRate;

  SubscriptionEntity({
    required this.id,
    required this.currency,
    required this.minRate,
    required this.maxRate
  });

  factory SubscriptionEntity.fromJson(Map<String, dynamic> json) => SubscriptionEntity(
    id: json['id'] as String,
    currency: json['currency'] as String,
    minRate: json['minRate'] as int,
    maxRate: json['maxRate'] as int,
  );
}


class CreateSubscription{
  Currency debitedCurrency;
  Currency creditedCurrency;
  int minRate;
  int maxRate;

  CreateSubscription({
    required this.debitedCurrency,
    required this.creditedCurrency,
    required this.minRate,
    required this.maxRate
  });
}