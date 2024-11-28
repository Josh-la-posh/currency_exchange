import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/modules/storage_session_controller.dart';
import '../../authentication/screens/login/login.dart';

class SplashAnimationController extends GetxController with GetSingleTickerProviderStateMixin {
  final UserSessionController userSessionController = Get.find();

  late AnimationController animationController;
  late Animation<double> animation;
  var isSplashCompleted = false.obs;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    animation = Tween<double>(begin: 0.0, end: 1.0).animate(animationController);
    animationController.forward().whenComplete(() {
      isSplashCompleted.value = true;
    });
  }

  void navigateToNextScreen() {
    Get.off(() => LoginScreen());
    Get.delete<SplashAnimationController>();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
