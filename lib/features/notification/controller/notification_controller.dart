import 'package:get/get.dart';
import 'package:pouch/features/notification/apis/api.dart';
import 'package:pouch/features/notification/model/get_user_notification.dart';

import '../../all_offer/controllers/offer_controller.dart';

class NotificationController extends GetxController {
  final offerController = Get.find<OfferController>();
  var userNotifications = <GetUserNotification>[].obs;
  var idsArray = [].obs;
  var isLoading = false.obs;

  Future<void> fetchNotification() async {
    try {
      userNotifications.isEmpty && isLoading(true);
      final response = await NotificationService.instance.fetchNotification();
      List<GetUserNotification> fetchNotification = (response.data as List)
        .map((json) => GetUserNotification.fromJson(json)).toList();
      userNotifications.assignAll(fetchNotification);

      if (idsArray.isNotEmpty) {
        updateNotification();
      }
    } catch (err) {
      print('Wahala dey toun');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchNotificationById({required String id}) async {
    try {
      final response = await NotificationService.instance.fetchNotificationById(id: id);
      await fetchNotification();
    } catch (err) {
      print('Wahala dey toun');
    } finally {
    }
  }

  Future<void> updateNotification() async {
    try {
      Map<String, dynamic> requestData = {'ids': idsArray};
      final response = NotificationService.instance.updateNotification(requestData);
      notificationLength([]);
    } catch (e) {
      print('I don do nonsense ooooooo');
    }
  }

  void notificationLength(val) {
    List fetchedData = val.map((item) => item['id'].toString()).toList();
    idsArray.assignAll(fetchedData);
    print('Lookinf good $idsArray');
  }

  void saveUserNotifications(val) {
    // userNotification.add
  }

  void clearData() {
    userNotifications.clear();
    idsArray.clear();
  }
}