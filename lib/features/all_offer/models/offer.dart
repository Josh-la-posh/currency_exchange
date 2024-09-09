import 'package:pouch/utils/constants/enums.dart';

class OfferEntity {
  String? id;
  String? debitedCurrency;
  String? creditedCurrency;
  String? amount;
  String? rate;
  String? expireIn;
  String? expireCountDown;
  int? views;
  String? negotiatorRate;
  String? negotiatorAmount;
  bool? negotiationAccepted;
  String? negotiatorId;
  bool? isActive;
  String? status;
  String? createdDate;
  String? lastModifiedDate;

  OfferEntity({
    this.id,
    this.debitedCurrency,
    this.creditedCurrency,
    this.amount,
    this.rate,
    this.expireIn,
    this.expireCountDown,
    this.views,
    this.negotiatorRate,
    this.negotiatorAmount,
    this.negotiationAccepted,
    this.negotiatorId,
    this.isActive,
    this.status,
    this.createdDate,
    this.lastModifiedDate
  });

  factory OfferEntity.fromJson(Map<String, dynamic> json) => OfferEntity(
    id: json['id'] as String?,
    debitedCurrency: json['debitedCurrency'] as String?,
    creditedCurrency: json['creditedCurrency'] as String?,
    amount: json['amount'] as String?,
    rate: json['rate'] as String?,
    expireIn: json['expireIn'] as String?,
    expireCountDown: json['expireCountDown'] as String?,
    views: json['views'] as int?,
    negotiatorRate: json['negotiatorRate'] as String?,
    negotiatorAmount: json['negotiatorAmount'] as String?,
    negotiationAccepted: json['negotiationAccepted'] as bool?,
    negotiatorId: json['negotiatorId'] as String?,
    isActive: json['isActive'] as bool?,
    status: json['status'] as String?,
    createdDate: json['createdDate'] as String?,
    lastModifiedDate: json['lastModifiedDate'] as String?,
  );
}

class CreateOfferEntity {
  Currency? debitedCurrency;
  Currency? creditedCurrency;
  String? amount;
  String? rate;
  String? expireIn;

  CreateOfferEntity({
    this.debitedCurrency,
    this.creditedCurrency,
    this.amount,
    this.rate,
    this.expireIn,
  });

}