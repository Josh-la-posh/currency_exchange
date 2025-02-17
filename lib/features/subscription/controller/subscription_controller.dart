import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/utils/constants/enums.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/shared/error_dialog_response.dart';
import '../apis/api.dart';
import '../models/subscribeEnity.dart';

class SubscriptionController extends GetxController {
  var isCreatingSubscription = false.obs;
  var isFetchingSubscription = false.obs;
  var subscriptions = <SubscriptionEntity>[].obs;
  var currencies = Currency.values.obs;
  var debitedCurrency = Currency.USD.obs;
  var creditedCurrency = Currency.NGN.obs;
  var minRate = ''.obs;
  var maxRate = ''.obs;

  @override
  void onInit() {
    super.onInit();
    if (subscriptions.isEmpty) {
      fetchSubscription(currency: '');
    }
  }

  @override
  void onClose() {
    subscriptions.clear();
    debitedCurrency.value = Currency.USD;
    creditedCurrency.value = Currency.NGN;
    minRate.value = '';
    maxRate.value = '';
    super.onClose();
  }

  void setDebitedCurrency(Currency currency) {
    debitedCurrency.value = currency;
  }

  void setCreditedCurrency(Currency currency) {
    creditedCurrency.value = currency;
  }

  void setMinRate(String amount) {
    minRate.value = amount;
  }

  void setMaxRate(String amount) {
    maxRate.value = amount;
  }

  Future<void> createSubscription({
    required String debitedCurrency,
    required String creditedCurrency,
    required double minRate,
    required double maxRate,
    required VoidCallback onSuccess
  }) async {
    try {
      isCreatingSubscription(true);
      final response = await SubscriptionService.instance.createSubscription(
        data: {
          'debitedCurrency': debitedCurrency,
          'creditedCurrency': creditedCurrency,
          'minRate': minRate,
          'maxRate': maxRate
        },
        onFailure: () {isCreatingSubscription(false);}
      );
      await fetchSubscription(currency: '');
      onSuccess();
      Get.snackbar('Success', 'Subscription created successfully', backgroundColor: Colors.green);
    } catch (err) {
      showErrorAlertHelper(errorMessage: err.toString());
    } finally {
      isCreatingSubscription(false);
    }
  }

  Future<void> fetchSubscription({required String currency}) async {
    try {
      subscriptions.isEmpty && isFetchingSubscription(true);
      final response = await SubscriptionService.instance.getSubscriptions(
        currency: currency,
        onFailure: () {isFetchingSubscription(false);}
      );
      final data = response.data['content'];
      List<SubscriptionEntity> fetchedSubscription = (data as List)
          .map((json) => SubscriptionEntity.fromJson(json)).toList();
      subscriptions.assignAll(fetchedSubscription);
    } catch (err) {
      showErrorAlertHelper(errorMessage: err.toString());
    } finally {
      isFetchingSubscription(false);
    }
  }

  Future<void> deleteSubscription({required String id}) async {
    try {
      Get.snackbar('', 'Deleting subscription', backgroundColor: TColors.primary);
      await SubscriptionService.instance.deleteSubscriptions(
        id: id,
        onFailure: () {
          Get.closeAllSnackbars();
        }
      );
      await fetchSubscription(currency: '');
      Get.snackbar('Success', 'Subscription deleted successfully', backgroundColor: Colors.green);
    } catch (err) {
      showErrorAlertHelper(errorMessage: err.toString());
    } finally {
      Get.closeAllSnackbars();
    }
  }

  void clearForm() {
    debitedCurrency.value = Currency.USD;
    creditedCurrency.value = Currency.NGN;
    minRate.value = '';
    maxRate.value = '';
  }

  void resetBoolOnOutgoingRequests() {
    isCreatingSubscription.value = false;
    isFetchingSubscription.value = false;
  }

  void clearData() {
    subscriptions.clear();
  }
}