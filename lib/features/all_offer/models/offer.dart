import 'package:swappr/utils/constants/enums.dart';

class OfferEntity {
  final String id;
  final String debitedCurrency;
  final String creditedCurrency;
  String? amount;
  final String rate;
  final String expireIn;
  final String expireCountDown;
  int? views;
  int? negotiatorRate;
  int? negotiatorAmount;
  bool? negotiationAccepted;
  String? negotiatorId;
  bool? isActive;
  final String status;
  final String createdDate;
  final String lastModifiedDate;

  OfferEntity({
    required this.id,
    required this.debitedCurrency,
    required this.creditedCurrency,
    this.amount,
    required this.rate,
    required this.expireIn,
    required this.expireCountDown,
    this.views,
    this.negotiatorRate,
    this.negotiatorAmount,
    this.negotiationAccepted,
    this.negotiatorId,
    this.isActive,
    required this.status,
    required this.createdDate,
    required this.lastModifiedDate
  });

  factory OfferEntity.fromJson(Map<String, dynamic> json) => OfferEntity(
    id: json['id'] as String,
    debitedCurrency: json['debitedCurrency'] as String,
    creditedCurrency: json['creditedCurrency'] as String,
    amount: json['amount'] as String,
    rate: json['rate'] as String,
    expireIn: json['expireIn'] as String,
    expireCountDown: json['expireCountDown'] as String,
    views: json['views'] as int,
    negotiatorRate: json['negotiatorRate'] as int,
    negotiatorAmount: json['negotiatorAmount'] as int,
    negotiationAccepted: json['negotiationAccepted'] as bool,
    negotiatorId: json['negotiatorId'] as String,
    isActive: json['isActive'] as bool,
    status: json['status'] as String,
    createdDate: json['createdDate'] as String,
    lastModifiedDate: json['lastModifiedDate'] as String,
  );
}

class CreateOfferEntity {
  Currency debitedCurrency;
  Currency creditedCurrency;
  int amount;
  int rate;
  int expireIn;

  CreateOfferEntity({
    required this.debitedCurrency,
    required this.creditedCurrency,
    required this.amount,
    required this.rate,
    required this.expireIn,
  });

}