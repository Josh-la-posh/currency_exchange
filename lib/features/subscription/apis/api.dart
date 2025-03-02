import 'dart:ui';
import '../../../data/modules/dio_service.dart';
import '../../../utils/responses/handleApiError.dart';

class SubscriptionService {
  static final SubscriptionService _instance = SubscriptionService._();

  SubscriptionService._();

  static SubscriptionService get instance => _instance;

  final DioService _dioService = DioService();

  Future<Map<String, dynamic>> createSubscription({
    required Map<String, dynamic> data,
    required VoidCallback onFailure,
  }) async {
    try {
      final response = await _dioService.postRequest(endpoint: '/subscription/create', data: data);
      return response;
    } catch (error) {
      onFailure();
      throw handleApiFormatError(error);
    }
  }

  Future<Map<String, dynamic>> getSubscriptions({
    required String currency,
    required VoidCallback onFailure,
  }) async {
    try {
      final response = await _dioService.getRequest(endpoint: '/subscription', queryParameters: {'currency': currency});
      return response;
    } catch (error) {
      onFailure();
      throw handleApiFormatError(error);
    }
  }

  Future<Map<String, dynamic>> deleteSubscriptions({
    required String id,
    required VoidCallback onFailure,
  }) async {
    try {
      final response = await _dioService.deleteRequest(endpoint: '/subscription/$id');
      return response;
    } catch (error) {
      onFailure();
      throw handleApiFormatError(error);
    }
  }
}



// class SubscriptionService {
//   static final SubscriptionService _instance = SubscriptionService._();
//
//   SubscriptionService._();
//
//   static SubscriptionService get instance => _instance;
//
//   Future _createSubscription({required Object data}) {
//     return apiService.post('/subscription/create', data: data);
//   }
//
//   Future _getSubscriptions({required Map<String, dynamic> queryParameters}) {
//     return apiService.get('/subscription', queryParameters: queryParameters);
//   }
//
//   Future _deleteSubscriptions({required String id}) {
//     return apiService.delete('/subscription/$id');
//   }
//
//   Future createSubscription({required Object data, required VoidCallback onFailure}) async{
//     return _createSubscription(data: data).then((response) {
//       return response;
//     }).catchError((error) {
//       onFailure();
//       throw (handleApiFormatError(error));
//     });
//   }
//
//   Future getSubscriptions({required String currency, required VoidCallback onFailure}) async {
//     return _getSubscriptions(queryParameters: {'currency': currency}).then((response) {
//       return response;
//     }).catchError((error) {
//       onFailure();
//       throw (handleApiFormatError(error));
//     });
//   }
//
//   Future deleteSubscriptions({required String id, required VoidCallback onFailure}) async{
//     return _deleteSubscriptions(id: id).then((response) {
//       return response;
//     }).catchError((error) {
//       onFailure();
//       throw (handleApiFormatError(error));
//     });
//   }
// }