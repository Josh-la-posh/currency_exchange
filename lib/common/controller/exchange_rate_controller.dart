import 'package:get/get.dart';
import 'package:pouch/features/wallet/apis/api.dart';
import 'package:pouch/utils/shared/error_dialog_response.dart';

class ExchangeRateController extends GetxController {
  var isConverting = false.obs;
  var baseCurrency = 'USD'.obs;
  var targetCurrency = 'NGN'.obs;
  var exchangeRate = 1.0.obs;
  var baseAmount = 0.0.obs;
  var targetAmount = 0.0.obs;

  var currencyRates = <Map<String, dynamic>>[].obs;
  final List<String> currencies = ['USD', 'NGN', 'EUR', 'GBP', 'CAD'];

  @override
  void onInit() {
    super.onInit();
    isConverting.value = false;
  }

  void updateTargetAmount() {
    targetAmount.value = baseAmount.value * exchangeRate.value;
  }

  void updateTargetCurrency(String currency) {
    targetCurrency.value = currency;
  }

  void updateBaseCurrency(String currency) {
    baseCurrency.value = currency;
  }

  // Logic for reversing currencies, if required
  void reverseCurrency() {
  }

  Future<void> fetchConversionRate() async {
    isConverting(true);
    print('The values are: ${baseCurrency.value} ${targetCurrency.value} ${baseAmount.value}');
    try {
      final response = await WalletServices.instance.fetchConversionRate(
          baseCurrency: baseCurrency.value,
          targetCurrency: targetCurrency.value,
          amount: baseAmount.value,
          onFailure: () {
            isConverting(false);
          }
      );
      final data = response['conversion_rates'];
      exchangeRate.value = data[targetCurrency.value];
      updateTargetAmount();
    } catch (e) {
      showErrorAlertHelper(errorMessage: e.toString());
      isConverting(false);
    } finally {
      isConverting(false);
    }
  }
}
