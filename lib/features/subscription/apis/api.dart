import 'package:pouch/data/modules/dio.dart';

class SubscriptionService {
  static final SubscriptionService _instance = SubscriptionService._();

  SubscriptionService._();

  static SubscriptionService get instance => _instance;

  Future createSubscription(Object data){
    return apiService.post('/subscription/create', data: data);
  }
  
  Future getSubscriptions(String currency) {
    return apiService.get(
        '/subscription',
        queryParameters: {'currency': currency}
    );
  }

  Future deleteSubscriptions(String id) {
    return apiService.delete('/subscription/$id');
  }





  // createSubscription({
  //   required SubscriptionProvider subscriptionProvider,
  //   required String debitedCurrency,
  //   required String creditedCurrency,
  //   required int minRate,
  //   required int maxRate
  // }) {
  //   _createSubscription({
  //     'debitedCurrency': debitedCurrency,
  //     'creditedCurrency': creditedCurrency,
  //     'minRate': minRate,
  //     'maxRate': maxRate
  //   }).then((response) async {
  //     await NoLoaderService.instance.getSubscriptions(
  //         provider: subscriptionProvider,
  //         currency : '',
  //         onSuccess: (){}
  //     );
  //     handleShowCustomToast(message: 'Subscription created successfully');
  //     Get.back();
  //   }).catchError((error) {
  //     print(error.toString());
  //     showErrorAlertHelper(errorMessage: handleApiFormatError(error));
  //   });
  // }
  //
  // getSubscriptions({
  //   required SubscriptionProvider provider,
  //   required String currency,
  //   required VoidCallback onSuccess,
  //   // required VoidCallback onFailure,
  // }) {
  //   List<SubscriptionEntity> subscriptions = [];
  //   _getSubscriptions(currency)
  //       .then((response) {
  //         var data = response.data;
  //
  //         SubscriptionDetailsEntity subscriptionDetails = SubscriptionDetailsEntity(
  //           totalPages: data['totalPages'],
  //           payloadSize: data['payloadSize'],
  //           hasNext: data['hasNext'],
  //           content: data['content'],
  //           currentPage: data['currentPage'],
  //           skippedRecords: data['skippedRecords'],
  //           totalRecords: data['totalRecords'],
  //         );
  //         provider.saveSubscriptionDetails(subscriptionDetails);
  //
  //         var content = subscriptionDetails.content;
  //
  //         for (var item in content) {
  //           subscriptions.add(SubscriptionEntity(
  //             id: item['id'],
  //             debitedCurrency: item['debitedCurrency'],
  //             creditedCurrency: item['creditedCurrency'],
  //             createdDate: item['createdDate'],
  //             minRate: item['minRate'],
  //             maxRate: item['maxRate'],
  //             lastModifiedDate: item['lastModifiedDate'],
  //           ));
  //           provider.saveSubscriptions(subscriptions);
  //         }
  //         onSuccess();
  //   });
  // }
  //
  // deleteSubscription({required String id, required SubscriptionProvider subscriptionProvider}) {
  //   _deleteSubscriptions(id).then((response) async {
  //     await NoLoaderService.instance.getSubscriptions(provider: subscriptionProvider, currency: '', onSuccess: (){});
  //     handleShowCustomToast(message: response.data['message']);
  //   }).catchError((error) {
  //     print(error.toString());
  //     showErrorAlertHelper(errorMessage: handleApiFormatError(error));
  //   });
  // }
}