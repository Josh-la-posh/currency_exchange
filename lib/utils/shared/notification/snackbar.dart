import 'package:flutter/material.dart';

import '../../../data/modules/app_navigator.dart';

handleShowCustomToast({
  required String message,
  Color backgroundColor = const Color.fromRGBO(8, 105, 182, 1),
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
      dismissDirection: DismissDirection.endToStart,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 3),
      padding: EdgeInsets.all(10),
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
                fontFamily: 'Avenir',
              )),
        ),
      ),
    ),
  );
}
