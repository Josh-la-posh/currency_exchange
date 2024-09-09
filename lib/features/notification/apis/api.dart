

import 'dart:async';

import 'package:pouch/data/provider/notificaton_provider.dart';

import '../../../data/modules/dio.dart';
import '../../../data/modules/interceptor.dart';

final _apiService = AppInterceptor(showLoader: false).dio;

const NOTIFICATION_URL = '/notification';
const USER_NOTIFICATION_URL = '/notification/user/notifications';
const UPDATE_DELIVERED_NOTIFICATION = '/notification/update-delivered';
const UPDATE_DEVICE_TOKEN = '/notification/update-device-token';
const SEND_NOTIFICATION = '/notification/send';
const SEND_TOPIC = '/notification/send/topic';
const REGISTERED_DEVICE_TOKEN = '/notification/register-device-token';

class NotificationService {

  static final NotificationService _instance = NotificationService._();

  NotificationService._();

  static NotificationService get instance => _instance;

  Future fetchNotificationById({required String id}) async {
    try {
      final response = await _apiService.get('$NOTIFICATION_URL/$id');
      return response;
    } catch (err) {

    }
  }

  Future fetchNotification() async {
    try {
      final response = await _apiService.get(USER_NOTIFICATION_URL);
      return response;
    } catch (err) {

    }
  }

  Future updateNotification(Object data) async {
    try {
      final response = await _apiService.put(UPDATE_DELIVERED_NOTIFICATION, data: data);
      return response;
    } catch (err) {

    }
  }



















  Future _sendNotification() {
    return apiService.post('/notification/send');
  }

  Future _registerDeviceToken(Object data) {
    return apiService.post('/notification/register-device-token', data: data);
  }

  Future _sendTopic() {
    return apiService.post('/notification/send/topic');
  }

  Future _updateDeliveredNotifications(Object data) {
    return _apiService.put('/notification/update-delivered', data: data);
  }

  Future _updateDeviceToken(Object data) {
    return apiService.put('/notification/update-device-token');
  }


  sendNotification({
    required NotificationProvider notificationProvider,
  }) {
    _sendNotification().then((response) async {
      var data = response.data;
      print('send notification response $data');
    }).catchError((error) {
      print('new error ${error.toString()}');
      // handleShowCustomToast(message: handleApiFormatError(error));
    });
  }

  registerDeviceToken({
    required NotificationProvider notificationProvider,
    required String token,
    required String deviceId,
  }) {
    _registerDeviceToken({token, deviceId}).then((response) async {
      var data = response.data;
      print('register device response $data');
    }).catchError((error) {
      print('new error ${error.toString()}');
      // handleShowCustomToast(message: handleApiFormatError(error));
    });
  }

  sendTopic({
    required NotificationProvider notificationProvider,
  }) {
    _sendTopic().then((response) async {
      var data = response.data;
      print('send topic response $data');
    }).catchError((error) {
      print('new error ${error.toString()}');
      // handleShowCustomToast(message: handleApiFormatError(error));
    });
  }

  updateDeliveredNotifications({
    required NotificationProvider notificationProvider,
    required List<String> ids
  }) {
    Map<String, dynamic> requestData = {'ids': ids};
    _updateDeliveredNotifications(requestData).then((response) async {
      print('update notification response $response');
      notificationProvider.updateNotificationLength([]);
    }).catchError((error) {
      print('new error ${error.toString()}');
      // handleShowCustomToast(message: handleApiFormatError(error));
    });
  }

  updateDeviceToken({
    required NotificationProvider notificationProvider,
    required String token,
    required String deviceId,
  }) {
    _updateDeviceToken({token, deviceId}).then((response) async {
      var data = response.data;
      print('update device token response $data');
    }).catchError((error) {
      print('new error ${error.toString()}');
      // handleShowCustomToast(message: handleApiFormatError(error));
    });
  }

}