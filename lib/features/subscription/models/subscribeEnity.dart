

import 'package:swappr/utils/constants/enums.dart';

class SubscriptionEntity{
  String? id;
  String? debitedCurrency;
  String? creditedCurrency;
  String? createdDate;
  int? minRate;
  int? maxRate;
  String? lastModifiedDate;

  SubscriptionEntity({
    required this.id,
    required this.debitedCurrency,
    required this.creditedCurrency,
    required this.createdDate,
    required this.minRate,
    required this.maxRate,
    required this.lastModifiedDate
  });

  factory SubscriptionEntity.fromJson(Map<String, dynamic> json) => SubscriptionEntity(
    id: json['id'] as String,
    debitedCurrency: json['debitedCurrency'] as String,
    creditedCurrency: json['creditedCurrency'] as String,
    createdDate: json['createdDate'] as String,
    minRate: json['minRate'] as int,
    maxRate: json['maxRate'] as int,
    lastModifiedDate: json['lastModifiedDate'] as String,
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