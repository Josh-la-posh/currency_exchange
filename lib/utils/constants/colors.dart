import 'package:flutter/material.dart';

class TColors {
  TColors._();

  // App Basic Colors
  static const Color primary = Color(0xFF664C89);
  static const Color danger = Color(0xFFF5450D);
  static const Color golden = Color(0xFFFF9D00);

  // Text Colors
  static const Color textPrimary = Color(0xFF303030);
  static Color textPrimaryO80 = TColors.textPrimary.withOpacity(0.8);
  static Color textPrimaryO40 = TColors.textPrimary.withOpacity(0.4);
  static const Color textSecondary = Color(0xFF595959);
  static const Color textCurrency = Color(0xFF111E32);
  static const Color textProgress = Color(0xFFFF9D00);
  static const Color textWhite = Colors.white;
  static const Color textBlack = Colors.black;

  // Background Container Colors
  static const Color primaryBackground = Color(0xFFFDF6FF);
  static const Color textFieldBackground = Color(0xFFFDFAFE);
  static Color authTransBack = const Color(0xFF111E32).withOpacity(0.2);

  //Button Colors
  static const Color primaryButton = TColors.primary;

  // Border Colors
  static const Color primaryBorder = TColors.primary;
  static Color secondaryBorder = const Color(0xFFD0CDE1).withOpacity(0.3);
  static Color timeLineBorder = const Color(0xFF303030).withOpacity(0.4);

  // Error and Validation Colors


  // Neutral Shades
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey = Colors.grey;

}