import 'my_currency.dart';

class OfferEntity {
  final String id;
  final String hasAmount;
  final String needAmount;
  final String rate;

  OfferEntity({
    required this.id,
    required this.hasAmount,
    required this.needAmount,
    required this.rate
  });

  factory OfferEntity.fromJson(Map<String, dynamic> json) => OfferEntity(
    id: json['id'] as String,
    hasAmount: json['hasAmount'] as String,
    needAmount: json['needAmount'] as String,
    rate: json['rate'] as String,
  );
}

class CreateOfferEntity {
  String hasAmount;
  String selectedCurrency;
  String neededCurrency;
  String preferredRate;
  String minimumRate;
  String expireHour;

  CreateOfferEntity({
    required this.hasAmount,
    required this.minimumRate,
    required this.preferredRate,
    required this.selectedCurrency,
    required this.expireHour,
    required this.neededCurrency
  });

}