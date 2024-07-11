import 'package:flutter/material.dart';
import 'package:pouch/utils/constants/colors.dart';
import 'package:pouch/utils/constants/sizes.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import '../../../data/modules/app_navigator.dart';

handleShowCustomToast({
  required String message,
  Color? backgroundColor,
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
      margin: EdgeInsets.only(bottom: THelperFunctions.screenHeight() * 0.7, left: TSizes.defaultSpace, right: TSizes.defaultSpace),
      duration: const Duration(seconds: 6),
      padding: const EdgeInsets.all(0),
      backgroundColor: TColors.white,
      content: GestureDetector(
        onTap: () {
          if (onMessageTap != null) {
            onMessageTap();
          }
        },
        child: Container(
          width: double.infinity * 0.8,
          padding: EdgeInsets.all(8),
          color: TColors.primary.withOpacity(0.8),
          child: Center(
            child: FittedBox(
              fit: BoxFit.fill,
              child: Text(message,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Roboto',
                  )),
            ),
          ),
        ),
      ),
    ),
  );
}
