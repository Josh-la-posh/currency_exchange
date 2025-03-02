import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/enums.dart';
import '../../../utils/shared/error_dialog_response.dart';
import '../apis/api.dart';
import '../models/create_offer_response.dart';
import '../screens/create_review_details.dart';

class CreateOfferController extends GetxController {
  final isCreatingOfferLoading = false.obs;
  final CancelToken requestCancelToken = CancelToken();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController expiryHourController = TextEditingController();

  var debitedCurrency = Currency.NGN.obs;
  var creditedCurrency = Currency.NGN.obs;
  var selectedCurrency = Currency.NGN.obs;
  var selectedDate = Date.First.obs;
  var expiryHour = '1'.obs;
  final expiryHours = ['1', '2', '5', '8', '12', '24', '48', '72', 'Never'];
  final createOfferResponse = CreateOfferResponse().obs;
  final error = ''.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  void onInit() {
    super.onInit();
    expiryHourController.text = expiryHour.value;
    amountController.text = '0';
    rateController.text = '0';
  }

  @override
  void onClose() {
    createOfferResponse.value = CreateOfferResponse();
    amountController.dispose();
    rateController.dispose();
    expiryHourController.dispose();
    expiryHour.value = '1';
    debitedCurrency.value = Currency.NGN;
    creditedCurrency.value = Currency.NGN;
    selectedCurrency.value = Currency.NGN;
    selectedDate.value = Date.First;
    isCreatingOfferLoading.value = false;
    super.onClose();
  }

  Future<void> creatingOffer({
    required String debitedCurrency,
    required String creditedCurrency,
    required String amount,
    required String rate,
    String? expireIn,
    required onSuccess
  }) async {
    try {
      isCreatingOfferLoading(true);
      error.value = '';

      final response = await OfferService.instance.creatingOffer(
        data: {
          "debitedCurrency": debitedCurrency,
          "creditedCurrency": creditedCurrency,
          "amount": amount,
          "rate": rate,
          'expireIn': expireIn != 'Never' ? int.parse(expireIn.toString()) : 0
        },
        onFailure: () {
          isCreatingOfferLoading(false);
        }
      );

      var item = response;
      createOfferResponse(CreateOfferResponse(
          id: item['id'],
          debitedCurrency: item['debitedCurrency'],
          creditedCurrency: item['creditedCurrency'],
          amount: item['amount'],
          rate: item['rate'],
          expireIn: item['expireIn'],
          views: item['views'],
          negotiatorRate: item['negotiatorRate'],
          negotiatorAmount: item['negotiatorAmount'],
          negotiationAccepted: item['negotiationAccepted'],
          negotiatorId: item['negotiatorId'],
          isActive: item['isActive'],
          status: item['status'],
          createdDate: item['createdDate'],
          lastModifiedDate: item['lastModifiedDate'],
          expireCountDown: item['expireCountDown']
      ));
      await onSuccess();
    } catch (err) {
      error.value = err.toString();
      showErrorAlertHelper(errorMessage: err.toString());
    } finally {
      isCreatingOfferLoading(false);
    }
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

  void submitForm() {
    if (amountController.text == '0' ||
        rateController.text == '0') {
      return null;
    } else {
      print('Working');
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        Get.to(() => CreateReviewDetailsScreen());
      }
    }
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

  @override
  void dispose() {
    requestCancelToken.cancel('Component disposed');
    super.dispose();
  }
}