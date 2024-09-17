import 'package:get/get.dart';
import 'package:pouch/features/all_offer/controllers/create_offer_controller.dart';
import 'package:pouch/features/all_offer/controllers/offer_controller.dart';
import 'package:pouch/features/authentication/controllers/auth_controller.dart';
import 'package:pouch/features/authentication/controllers/auth_form_controller.dart';
import 'package:pouch/features/home/controller/home_controller.dart';
import 'package:pouch/features/notification/controller/notification_controller.dart';
import 'package:pouch/features/verification/controller/verification_controller.dart';
import 'package:pouch/features/wallet/controller/wallet_controller.dart';
import 'package:pouch/utils/helpers/controller/helper_function_controller.dart';
import 'package:pouch/utils/layouts/navigation_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetControllers {
  // void _clearControllerData() {
    // Get.lazyPut<AuthFormController>(() => AuthFormController());

  //   final controllers = [
  //     Get.find<HomeController>(),
  //     Get.find<OfferController>(),
  //     Get.find<NotificationController>(),
  //     Get.find<WalletController>(),
  //     Get.find<AuthController>(),
  //     Get.find<AuthFormController>(),
  //     Get.find<NavigationController>(),
  //     Get.find<VerificationController>(),
  //     Get.find<CreateOfferController>(),
  //     Get.find<HelperFunctionsController>(),
  //   ];
  //
  //   for (var controller in controllers) {
  //     if (controller is HomeController) controller.clearData();
  //     if (controller is OfferController) controller.clearData();
  //     if (controller is NotificationController) controller.clearData();
  //     if (controller is WalletController) controller.clearData();
  //     if (controller is AuthController) controller.removeUser();
  //     if (controller is VerificationController) controller.clearData();
  //     if (controller is CreateOfferController) controller.clearForm();
  //     if (controller is AuthFormController) controller.clearData();
  //   }
  // }

  Future<void> _clearPersistenceStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> clearData() async {
    try {
      // _clearControllerData();
      await _clearPersistenceStorage();

      Get.delete<NavigationController>(force: true);
      Get.delete<HomeController>(force: true);
      Get.delete<OfferController>(force: true);
      Get.delete<NotificationController>(force: true);
      Get.delete<WalletController>(force: true);
      Get.delete<VerificationController>(force: true);
      Get.delete<CreateOfferController>(force: true);
      Get.delete<AuthFormController>(force: true);
      Get.delete<HelperFunctionsController>(force: true);

      Get.closeAllSnackbars();
      Get.back(closeOverlays: true);
      Get.offAllNamed('auth/login');
    } catch (e) {
      print('Error during reset: $e');
    }
  }
}
