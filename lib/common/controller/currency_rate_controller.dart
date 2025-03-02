import 'package:get/get.dart';

import '../../features/wallet/apis/api.dart';

class CurrencyController extends GetxController {
  var selectedCurrency = 'USD'.obs;
  var currencyRates = <Map<String, dynamic>>[].obs;
  final errMsg = ''.obs;
  final List<String> currencies = ['USD', 'NGN', 'EUR', 'GBP', 'CAD'];

  @override
  void onInit() {
    super.onInit();
    fetchCurrencyRates(currency: selectedCurrency.value);
  }

  Future<void> fetchCurrencyRates({required String currency}) async {
    try {
      errMsg.value = '';
      final response = await WalletServices.instance.fetchFxRates(
          currency: currency,
          onFailure: () {});
      final rates = response['conversion_rates'] as Map<String, dynamic>;
      currencyRates.value = rates.entries
          .map((entry) => {'currency': entry.key, 'rate': entry.value})
          .toList();
    } catch (e) {
      errMsg.value = 'Failed to load currency rates';
    }
  }

  void updateCurrency(String currency) {
    selectedCurrency.value = currency;
    fetchCurrencyRates(currency: currency);
  }
}
