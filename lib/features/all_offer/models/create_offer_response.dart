import 'package:pouch/utils/constants/enums.dart';

class CreateOfferResponse {
  final String id;
  final String debitedCurrency;
  final String creditedCurrency;
  final String amount;
  final String rate;
  String? expireIn;
  String? expireCountDown;
  final int views;
  String? negotiatorRate;
  String? negotiatorAmount;
  bool? negotiationAccepted;
  String? negotiatorId;
  bool? isActive;
  final String status;
  final String createdDate;
  final String lastModifiedDate;

  CreateOfferResponse({
    required this.id,
    required this.debitedCurrency,
    required this.creditedCurrency,
    required this.amount,
    required this.rate,
    required this.expireIn,
    required this.expireCountDown,
    required this.views,
    required this.negotiatorRate,
    required this.negotiatorAmount,
    required this.negotiationAccepted,
    required this.negotiatorId,
    required this.isActive,
    required this.status,
    required this.createdDate,
    required this.lastModifiedDate
  });

  factory CreateOfferResponse.fromJson(Map<String, dynamic> json) => CreateOfferResponse(
    debitedCurrency: json['debitedCurrency'] as String,
    creditedCurrency: json['creditedCurrency'] as String,
    amount: json['amount'] as String,
    rate: json['rate'] as String,
    expireIn: json['expireIn'] as String,
    expireCountDown: json['expireCountDown'] as String,
    status: json['status'] as String,
    lastModifiedDate: json['lastModifiedDate'] as String,
    createdDate: json['createdDate'] as String,
    views: json['views'] as int,
    negotiatorRate: json['negotiatorRate'] as String,
    negotiatorAmount: json['negotiatorAmount'] as String,
    negotiationAccepted: json['negotiationAccepted'] as bool,
    negotiatorId: json['negotiatorId'] as String,
    id: json['id'] as String,
    isActive: json['isActive'] as bool,
  );
}