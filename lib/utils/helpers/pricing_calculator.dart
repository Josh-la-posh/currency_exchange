
class TPriceCalculator {
  static double calculateTotalPrice(String sellingAmount, String currency) {
    double fee = calculateFee(currency);
    double amount = double.parse(sellingAmount);
    double totalPrice = amount + fee;

    return totalPrice;
  }

  static double calculateFee(String currency) {
    if (currency == 'NGN') {
      return 100;
    } else {
      return 5;
    }
  }
}