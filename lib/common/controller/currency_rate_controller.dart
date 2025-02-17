import 'package:get/get.dart';

import '../../features/wallet/apis/api.dart';

class CurrencyController extends GetxController {
  var selectedCurrency = 'USD'.obs;
  var currencyRates = <Map<String, dynamic>>[].obs;
  final List<String> currencies = ['USD', 'NGN', 'EUR', 'GBP', 'CAD'];

  @override
  void onInit() {
    super.onInit();
    fetchCurrencyRates(currency: selectedCurrency.value);
  }

  Future<void> fetchCurrencyRates({required String currency}) async {
    try {
      final response = await WalletServices.instance.fetchFxRates(
          currency: currency,
          onFailure: () {});
      final rates = response.data['conversion_rates'] as Map<String, dynamic>;
      currencyRates.value = rates.entries
          .map((entry) => {'currency': entry.key, 'rate': entry.value})
          .toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load currency rates',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void updateCurrency(String currency) {
    selectedCurrency.value = currency;
    fetchCurrencyRates(currency: currency);
  }
}
