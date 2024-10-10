import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

void handleShowLoader() {
  BuildContext? context = Get.context;

  if (context != null) {
    context.loaderOverlay.show();
  }
}

void handleHideLoader() {
  BuildContext? context = Get.context;

  if (context != null) {
    context.loaderOverlay.hide();
  }
}

// void handleShowLoader() {
//   BuildContext context =
//   AppNavigator.instance.navigatorKey.currentContext as BuildContext;
//   context.loaderOverlay.show();
// }

// void handleHideLoader() {
//   BuildContext context =
//   AppNavigator.instance.navigatorKey.currentContext as BuildContext;
//   context.loaderOverlay.hide();
// }
