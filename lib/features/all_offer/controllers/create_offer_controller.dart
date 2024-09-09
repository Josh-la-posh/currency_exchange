import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../utils/constants/enums.dart';

class CreateOfferController extends GetxController {

  final TextEditingController amountController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController expiryHourController = TextEditingController();

  var debitedCurrency = Currency.NGN.obs;
  var creditedCurrency = Currency.NGN.obs;
  var selectedCurrency = Currency.NGN.obs;
  var selectedDate = Date.First.obs;
  var expiryHour = '1'.obs;
  final expiryHours = ['1', '2', '5', '8', '12', '24', '48', '72', 'Never'];


  @override
  void onInit() {
    super.onInit();
    expiryHourController.text = expiryHour.value;
    amountController.text = '0';
    rateController.text = '0';
  }

  @override
  void onClose() {
    amountController.dispose();
    rateController.dispose();
    expiryHourController.dispose();
    super.onClose();
  }

  void updateDebitedCurrency(Currency newCurrency) {
    debitedCurrency.value = newCurrency;
  }

  void updateCreditedCurrency(Currency newCurrency) {
    creditedCurrency.value = newCurrency;
  }

  void updateExpiryHour(String newHour) {
    expiryHour.value = newHour;
    expiryHourController.text = newHour;
  }


  void clearForm() {
    amountController.clear();
    rateController.clear();
    expiryHourController.clear();
    expiryHour.value = '1';
    debitedCurrency.value = Currency.NGN;
    creditedCurrency.value = Currency.NGN;
    selectedCurrency.value = Currency.NGN;
    selectedDate.value = Date.First;
  }

}