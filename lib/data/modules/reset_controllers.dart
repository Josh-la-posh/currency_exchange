import 'package:get/get.dart';
import 'package:pouch/common/controller/exchange_rate_controller.dart';
import 'package:pouch/features/all_offer/controllers/create_offer_controller.dart';
import 'package:pouch/features/all_offer/controllers/offer_controller.dart';
import 'package:pouch/features/authentication/controllers/address_controller.dart';
import 'package:pouch/features/authentication/controllers/auth_form_controller.dart';
import 'package:pouch/features/authentication/screens/login/login.dart';
import 'package:pouch/features/home/controller/home_controller.dart';
import 'package:pouch/features/notification/controller/notification_controller.dart';
import 'package:pouch/features/payment_method/controller/payment_controller.dart';
import 'package:pouch/features/subscription/controller/subscription_controller.dart';
import 'package:pouch/features/verification/controller/verification_controller.dart';
import 'package:pouch/features/wallet/controller/bank_controller.dart';
import 'package:pouch/features/wallet/controller/wallet_controller.dart';
import 'package:pouch/utils/helpers/controller/helper_function_controller.dart';
import 'package:pouch/utils/layouts/navigation_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/all_offer/controllers/tradingOfferController.dart';
import '../../features/authentication/controllers/change_password_controller.dart';
import '../../features/authentication/controllers/forgot_password_controller.dart';
import 'inactivity_service.dart';

class ResetControllers {

  Future<void> _clearPersistenceStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> clearData() async {
    try {
      // await _clearPersistenceStorage();

      Get.delete<TradingOfferController>(force: true);
      Get.delete<NotificationController>(force: true);
      Get.delete<VerificationController>(force: true);
      Get.delete<CreateOfferController>(force: true);
      Get.delete<AuthFormController>(force: true);
      Get.delete<ForgotPasswordFormController>(force: true);
      Get.delete<ChangePasswordController>(force: true);
      Get.delete<SubscriptionController>(force: true);
      Get.delete<HelperFunctionsController>(force: true);
      Get.delete<AddressFormController>(force: true);
      Get.delete<PaymentController>(force: true);
      Get.delete<BankController>(force: true);
      Get.delete<HomeController>(force: true);
      Get.delete<ExchangeRateController>(force: true);
      Get.delete<WalletController>(force: true);
      Get.delete<OfferController>(force: true);
      Get.delete<NavigationController>(force: true);

      Get.closeAllSnackbars();
      Get.back(closeOverlays: true);
      InactivityService.instance.stopMonitoring();
      Get.offAll(LoginScreen());
    } catch (e) {
      print('Error during reset: $e');
    }
  }
}
