import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SwapController extends GetxController {
  var hasCurrency = 'USD'.obs;
  var needCurrency = 'NGN'.obs;
  var amount = 100.0.obs;
  var rate = 1500.0.obs;
  final isFetchingAutoData = false.obs;
  var autoSwaps = [].obs;

  String get formattedAmount => NumberFormat('#,##0.00', 'en_US').format(amount.value);
  String get formattedRate => NumberFormat('#,##0.00', 'en_US').format(rate.value);
  String get estimatedAmount => NumberFormat('#,##0.00', 'en_US').format(amount.value * rate.value);

  Future<void> fetchAutoswapData() async {

  }
}