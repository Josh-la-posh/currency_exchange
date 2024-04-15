

class SubscriptionEntity{
  String sellingCurrency;
  String buyingCurrency;
  String minimumRate;
  String maximumRate;

  SubscriptionEntity({
    required this.sellingCurrency,
    required this.buyingCurrency,
    required this.minimumRate,
    required this.maximumRate
  });
}