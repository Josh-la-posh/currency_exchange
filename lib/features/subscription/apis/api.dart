import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:swappr/data/modules/dio.dart';
import 'package:swappr/data/provider/subscription_provider.dart';
import 'package:swappr/features/subscription/models/subscribeEnity.dart';
import 'package:swappr/features/subscription/models/subscription_details.dart';
import 'package:swappr/utils/responses/error_dialog.dart';
import 'package:swappr/utils/responses/handleApiError.dart';
import 'package:swappr/utils/shared/notification/snackbar.dart';

class SubscriptionService {
  static final SubscriptionService _instance = SubscriptionService._();

  SubscriptionService._();

  static SubscriptionService get instance => _instance;

  Future _createSubscription(Object data){
    return apiService.post('/subscription/create', data: data);
  }
  
  Future _getSubscriptions(String currency) {
    return apiService.get(
        '/subscription',
        queryParameters: {'currenry': currency}
    );
  }

  Future _deleteSubscriptions(String id) {
    return apiService.delete('/subscription/$id');
  }

  createSubscription({
    required SubscriptionProvider subscriptionProvider,
    required String currency,
    required int minRate,
    required int maxRate
  }) {
    _createSubscription({
      'currency': currency,
      'minRate': minRate,
      'maxRate': maxRate
    }).then((response) async {
      await getSubscriptions(provider: subscriptionProvider, currency: currency);
      Get.back();
      print(response);
    }).catchError((error) {
      showErrorAlertHelper(errorMessage: handleApiFormatError(error));
    });
  }

  getSubscriptions({
    required SubscriptionProvider provider,
    required String currency
  }) {
    List<SubscriptionEntity> subscriptions = [];
    _getSubscriptions(currency)
        .then((response) {
          var data = response.data;

          SubscriptionDetailsEntity subscriptionDetails = SubscriptionDetailsEntity(
              currentPage: data['currentPage'],
              skippedRecords: data['skippedRecords'],
              totalPages: data['totalPages'],
              hasNext: data['hasNext'],
              content: data['content'],
              payloadSize: data['payloadSize'],
              totalRecords: data['totalRecords']
          );
          provider.saveSubscriptionDetails(subscriptionDetails);

          var content = subscriptionDetails.content;

          for (var item in content) {
            subscriptions.add(SubscriptionEntity(
                id: item['id'],
                currency: item['currency'],
                minRate: item['minRate'],
                maxRate: item['maxRate']
            ));
          }
          provider.saveSubscriptions(subscriptions);
    });
  }

  deleteSubscription({required String id, required SubscriptionProvider subscriptionProvider}) {
    _deleteSubscriptions(id).then((response) async {
      await getSubscriptions(provider: subscriptionProvider, currency: '');
      handleShowCustomToast(message: response.toString());
    }).catchError((error) {
      showErrorAlertHelper(errorMessage: handleApiFormatError(error));
    });
  }
}