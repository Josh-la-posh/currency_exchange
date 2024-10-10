import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:pouch/data/modules/userAgent.dart';
import 'package:pouch/utils/constants/colors.dart';
import '../controller/splash_controller.dart';

class SplashScreen extends GetView<SplashAnimationController> {
  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 3), () {
        controller.isSplashCompleted.value = true;
      });
      // String userAgent = await getUserAgent();
      // print('user agent: $userAgent');
    });

    return Obx(() {
      if (controller.isSplashCompleted.value) {
        controller.updateSplashCompletion();
      }

      return Scaffold(
        backgroundColor: TColors.primary,
        body: Center(
          child: FadeTransition(
            opacity: controller.animation,
            child: Image.asset(
              'assets/logos/swappr-splash-logo.png',
              fit: BoxFit.contain,
              width: 90,
              height: 90,
            ),
          ),
        ),
      );
    });
  }
}
