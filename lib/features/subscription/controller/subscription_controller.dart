import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/utils/constants/enums.dart';

import '../apis/api.dart';
import '../models/subscribeEnity.dart';

class SubscriptionController extends GetxController {
  var isLoading = false.obs;
  var subscriptions = <SubscriptionEntity>[].obs;
  var currencies = Currency.values.obs;
  var debitedCurrency = Currency.USD.obs;
  var creditedCurrency = Currency.NGN.obs;
  var minRate = ''.obs;
  var maxRate = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSubscription(currency: '');
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
    required int minRate,
    required int maxRate,
    required VoidCallback onSuccess
  }) async {
    try {
      isLoading(true);
      final response = await SubscriptionService.instance.createSubscription({
            'debitedCurrency': debitedCurrency,
            'creditedCurrency': creditedCurrency,
            'minRate': minRate,
            'maxRate': maxRate
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        await fetchSubscription(currency: '');
        onSuccess();
        Get.snackbar('Success', 'Subscription created successfully', backgroundColor: Colors.green);
      } else {
        Get.snackbar('Error', 'Failed to create subscription: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      return null;
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchSubscription({required String currency}) async {
    try {
      isLoading(true);
      final response = await SubscriptionService.instance.getSubscriptions(currency);
      if (response.statusCode == 200) {
        final data = response.data['content'];
        List<SubscriptionEntity> fetchedSubscription = (data as List)
            .map((json) => SubscriptionEntity.fromJson(json)).toList();
        subscriptions.assignAll(fetchedSubscription);
      } else {
        Get.snackbar('Error', 'Failed to fetch subscriptions: ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      return null;
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteSubscription({required String id}) async {
    try {
      isLoading(true);
      final response = await SubscriptionService.instance.deleteSubscriptions(id);
      if (response.statusCode == 200) {
        await fetchSubscription(currency: '');
        Get.snackbar('Success', 'Subscription deleted successfully', backgroundColor: Colors.green);
      } else {
        Get.snackbar('Error', 'Failed to delete subscriptions ${response.data['message']}', backgroundColor: Colors.red);
      }
    } catch (err) {
      return null;
    } finally {
      isLoading(false);
    }
  }

  void clearForm() {
    debitedCurrency.value = Currency.USD;
    creditedCurrency.value = Currency.NGN;
    minRate.value = '';
    maxRate.value = '';
  }

  void clearData() {
    subscriptions.clear();
  }
}