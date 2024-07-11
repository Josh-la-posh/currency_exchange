import 'package:flutter/material.dart';
import 'package:pouch/utils/constants/colors.dart';

class TFloatingButtonTheme {
  TFloatingButtonTheme._();

  static const lightFloatingButtonTheme = FloatingActionButtonThemeData(
    foregroundColor: TColors.white,
    backgroundColor: TColors.primary,
    elevation: 0,
    iconSize: 22,
    shape: CircleBorder(
      side: BorderSide(
        color: Colors.transparent,
      )
    ),

  );

  static const darkFloatingButtonTheme = FloatingActionButtonThemeData(
    foregroundColor: TColors.white,
    backgroundColor: TColors.primary,
    elevation: 0,
    iconSize: 22,
    shape: CircleBorder(
        side: BorderSide(
          color: Colors.transparent,
        )
    ),

  );
}