import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/utils/constants/colors.dart';
import '../controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SplashAnimationController controller = Get.put(SplashAnimationController());

    return Obx(() {
      if (controller.isSplashCompleted.value) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.navigateToNextScreen();
        });
      }

      return Scaffold(
        backgroundColor: TColors.primary,
        body: Center(
          child: FadeTransition(
            opacity: controller.animation,
            child: Image.asset(
              'assets/logos/swappr-splash-logo.png',
              fit: BoxFit.contain,
              width: 150,
              height: 150,
            ),
          ),
        ),
      );
    });
  }
}
