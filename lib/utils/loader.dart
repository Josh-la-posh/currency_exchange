import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../data/modules/app_navigator.dart';

void handleShowLoader() {
  BuildContext context =
  AppNavigator.instance.navigatorKey.currentContext as BuildContext;
  context.loaderOverlay.show();
}

void handleHideLoader() {
  BuildContext context =
  AppNavigator.instance.navigatorKey.currentContext as BuildContext;
  context.loaderOverlay.hide();
}
