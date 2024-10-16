import 'package:get/get.dart';
import 'package:pouch/features/splash/controller/splash_controller.dart';
import 'package:pouch/utils/helpers/controller/helper_function_controller.dart';

import '../layouts/navigation_menu.dart';

class RootBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigationController>(() => NavigationController());
    Get.lazyPut<HelperFunctionsController>(() => HelperFunctionsController());
    Get.lazyPut<SplashAnimationController>(() => SplashAnimationController());
  }
}
