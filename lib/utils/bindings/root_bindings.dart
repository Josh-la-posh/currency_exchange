import 'package:get/get.dart';
import 'package:pouch/features/all_offer/controllers/create_offer_controller.dart';
import 'package:pouch/features/all_offer/controllers/offer_controller.dart';
import 'package:pouch/features/home/controller/home_controller.dart';
import 'package:pouch/features/notification/controller/notification_controller.dart';
import 'package:pouch/features/splash/controller/splash_controller.dart';
import 'package:pouch/features/subscription/controller/subscription_controller.dart';
import 'package:pouch/features/transaction/controller/transaction_controller.dart';
import 'package:pouch/features/verification/controller/verification_controller.dart';
import 'package:pouch/features/wallet/controller/wallet_controller.dart';
import 'package:pouch/utils/helpers/controller/helper_function_controller.dart';

import '../layouts/navigation_menu.dart';

class RootBindings implements Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<NavigationController>(() => NavigationController());
    // Get.lazyPut<VerificationController>(() => VerificationController());
    // Get.lazyPut<NotificationController>(() => NotificationController());
    // Get.lazyPut<WalletController>(() => WalletController());
    // Get.lazyPut<OfferController>(() => OfferController());
    // Get.lazyPut<CreateOfferController>(() => CreateOfferController());
    Get.lazyPut<HelperFunctionsController>(() => HelperFunctionsController());
    Get.lazyPut<SplashAnimationController>(() => SplashAnimationController());
    // Get.lazyPut<SubscriptionController>(() => SubscriptionController());
    // Get.lazyPut<TransactionController>(() => TransactionController());
  }
}
