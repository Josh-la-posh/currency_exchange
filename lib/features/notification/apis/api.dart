import 'dart:async';
import 'dart:ui';
import 'package:dio/dio.dart';

import '../../../data/modules/interceptor.dart';
import '../../../utils/responses/handleApiError.dart';
import '../../../utils/shared/error_dialog_response.dart';

final _apiService = AppInterceptor(showLoader: false).dio;

class NotificationService {

  static final NotificationService _instance = NotificationService._();

  NotificationService._();

  static NotificationService get instance => _instance;

  Future _fetchNotificationById({required String id}) {
    return _apiService.get('/notification/$id');
  }

  Future _fetchNotification() {
    return _apiService.get('/notification/user/notifications');
  }

  Future _updateNotification({required Object data}) {
    return _apiService.put('/notification/update-delivered', data: data);
  }

  Future _updateDeviceToken({required Object data}) {
    return _apiService.put('/notification/update-device-token', data: data);
  }

  Future _registerDeviceToken({required Object data}) {
    return _apiService.post('/notification/register-device-token', data: data);
  }

  Future fetchNotificationById({required String id, required VoidCallback onFailure}) async {
    return _fetchNotificationById(id: id).then((response) {
      return response;
    }).catchError((error) {
      onFailure();
      throw (handleApiFormatError(error));
    });
  }

  Future fetchNotification({required VoidCallback onFailure}) async {
    return _fetchNotification().then((response) {
      return response;
    }).catchError((error) {
      onFailure();
      throw (handleApiFormatError(error));
    });
  }

  Future updateNotification({required Object data, required VoidCallback onFailure}) async {
    return _updateNotification(data: data).then((response) {
      return response;
    }).catchError((error) {
      onFailure();
      throw (handleApiFormatError(error));
    });
  }

  Future registerDeviceToken({required Object data}) async {
    return _registerDeviceToken(data: data).then((response) {
      print(response);
      return;
    }).catchError((error) {
      print('register token error $error');
    });
  }

  Future updateDeviceToken(Object data) async {
    return _updateDeviceToken(data: data).then((response) {
      print(response.data);
      return;
    }).catchError((error) {
      print('register token error $error');
    });
  }

  Future swappingOffer({required String id, CancelToken? cancelToken}) async {
    try {
      final response = await _apiService.post(
          '/offer/swap/$id',
          cancelToken: cancelToken
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw(response.data['message'] ?? 'Failed to swap offer');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout
      ) {
        throw TimeoutException('The request timed out');
      }
      throw (e.response?.data['message']);
    } catch (e) {
      showErrorAlertHelper(errorMessage: e.toString());
      rethrow;
    } finally {
      cancelToken = CancelToken(); // Reset token
    }
  }

}