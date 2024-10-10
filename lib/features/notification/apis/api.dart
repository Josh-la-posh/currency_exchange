import 'dart:async';
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
      final response = await _apiService.put(
          UPDATE_DELIVERED_NOTIFICATION, data: data);
      return response;
    } catch (err) {

    }
  }

  Future registerDeviceToken(Object data) async {
    try {
      final response = await _apiService.post(REGISTERED_DEVICE_TOKEN, data: data);
      print('the token sent is ${response.data}');
    } catch (e) {
      print('register token error $e');
    }
  }

  Future updateDeviceToken(Object data) async {
    try {
      final response = await _apiService.put(UPDATE_DEVICE_TOKEN, data: data);
      print('the token sent is ${response.data}');
    } catch (e) {
      print('register token error $e');
    }
  }

}