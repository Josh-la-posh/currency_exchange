import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/modules/storage_session_controller.dart';

class SplashAnimationController extends GetxController with SingleGetTickerProviderMixin {

  UserSessionController userSessionController = Get.find();
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

    animationController.forward();
  }

  void updateSplashCompletion() {
    userSessionController.routeUserToHomeIfLoggedIn();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
