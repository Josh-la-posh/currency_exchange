import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:pouch/data/modules/dio.dart';
import '../../../utils/responses/handleApiError.dart';
import '../../../utils/shared/error_dialog_response.dart';

class SubscriptionService {
  static final SubscriptionService _instance = SubscriptionService._();

  SubscriptionService._();

  static SubscriptionService get instance => _instance;

  Future _createSubscription({required Object data}) {
    return apiService.post('/subscription/create', data: data);
  }

  Future _getSubscriptions({required Map<String, dynamic> queryParameters}) {
    return apiService.get('/subscription', queryParameters: queryParameters);
  }

  Future _deleteSubscriptions({required String id}) {
    return apiService.delete('/subscription/$id');
  }

  Future createSubscription({required Object data, required VoidCallback onFailure}) async{
    return _createSubscription(data: data).then((response) {
      return response;
    }).catchError((error) {
      onFailure();
      throw (handleApiFormatError(error));
    });
  }
  
  Future getSubscriptions({required String currency, required VoidCallback onFailure}) async {
    return _getSubscriptions(queryParameters: {'currency': currency}).then((response) {
      return response;
    }).catchError((error) {
      onFailure();
      throw (handleApiFormatError(error));
    });
  }

  Future deleteSubscriptions({required String id, required VoidCallback onFailure}) async{
    return _deleteSubscriptions(id: id).then((response) {
      return response;
    }).catchError((error) {
      onFailure();
      throw (handleApiFormatError(error));
    });
  }
}