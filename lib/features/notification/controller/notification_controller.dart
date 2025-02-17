import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pouch/features/notification/apis/api.dart';
import 'package:pouch/features/notification/model/get_user_notification.dart';

class NotificationController extends GetxController {
  var userNotifications = <GetUserNotification>[].obs;
  final CancelToken requestCancelToken = CancelToken();
  var idsArray = [].obs;
  var isLoading = false.obs;

  @override
  void onClose() {
    userNotifications.clear();
    idsArray.clear();
    super.onClose();
  }

  Future<void> fetchNotification() async {
    try {
      userNotifications.isEmpty && isLoading(true);
      final response = await NotificationService.instance.fetchNotification(
          onFailure: () {
            isLoading(false);
          }
      );
      List<GetUserNotification> fetchNotification = (response.data as List)
        .map((json) => GetUserNotification.fromJson(json)).toList();
      userNotifications.assignAll(fetchNotification);

      if (idsArray.isNotEmpty) {
        updateNotification();
      }
    } catch (err) {
      print('Wahala getting notifications');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchNotificationById({required String id}) async {
    try {
      final response = await NotificationService.instance.fetchNotificationById(
          id: id,
          onFailure: () {}
      );
      await fetchNotification();
    } catch (err) {
      print('Wahala getting notification by id');
    } finally {
    }
  }

  Future<void> updateNotification() async {
    try {
      Map<String, dynamic> requestData = {'ids': idsArray};
      final response = NotificationService.instance.updateNotification(
          data: requestData,
          onFailure: () {}
      );
      idsArray.clear();
    } catch (e) {
      print('I don update nonsense notification ooooooo');
    }
  }

  void notificationLength(val) {
    List fetchedData = val.map((item) => item['id'].toString()).toList();
    idsArray.assignAll(fetchedData);
  }

  void saveUserNotifications(val) {
  }

  @override
  void dispose() {
    requestCancelToken.cancel('Component disposed');
    super.dispose();
  }
}