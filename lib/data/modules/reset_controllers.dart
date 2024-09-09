import 'package:get/get.dart';
import 'package:pouch/features/all_offer/controllers/offer_controller.dart';
import 'package:pouch/features/authentication/controllers/auth_controller.dart';
import 'package:pouch/features/home/controller/home_controller.dart';
import 'package:pouch/features/notification/controller/notification_controller.dart';
import 'package:pouch/features/wallet/controller/wallet_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetControllers {
  void clearControllerData() {
    Get.find<HomeController>().clearData();
    Get.find<OfferController>().clearData();
    Get.find<NotificationController>().clearData();
    Get.find<WalletController>().clearData();
    Get.find<AuthController>().clearData();
  }

  Future<void> clearPersistenceStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> clearData() async {
    clearControllerData();
    await clearPersistenceStorage();
    Get.delete<HomeController>();
    Get.delete<OfferController>();
    Get.delete<NotificationController>();
    Get.delete<WalletController>();
    Get.delete<AuthController>();

    Get.closeAllSnackbars();
    Get.back(closeOverlays: true);
    Get.offAllNamed('auth/login');
  }
}