import 'package:flutter/material.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';
import '../../../data/modules/app_navigator.dart';

handleShowCustomToast({
  required String message,
  Color backgroundColor = TColors.primary,
  Color textColor = Colors.white,
  String key = 'app-snackbar',
  VoidCallback? onMessageTap,
}) {
  ScaffoldMessenger.of(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext)
      .removeCurrentSnackBar();
  ScaffoldMessenger.of(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext)
      .showSnackBar(
    SnackBar(
      key: Key(key),
      dismissDirection: DismissDirection.up,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      padding: const EdgeInsets.all(10),
      backgroundColor: backgroundColor,
      content: GestureDetector(
        onTap: () {
          if (onMessageTap != null) {
            onMessageTap();
          }
        },
        child: Center(
          child: Text(message,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto',
              )),
        ),
      ),
    ),
  );
}
