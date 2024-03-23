import 'package:flutter/material.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/constants/sizes.dart';
import 'package:swappr/utils/constants/texts.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: TColors.primaryButton,
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: TColors.primaryButton.withOpacity(0.4),
      textStyle: const TextStyle(fontSize: TSizes.fontSize16, color: TColors.textWhite, fontWeight: TSizes.fontWeightNm, fontFamily: TTexts.fontFamily),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TSizes.borderRadiusSm))
    )
  );

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: TColors.primaryButton,
          disabledForegroundColor: Colors.grey,
          disabledBackgroundColor: TColors.primaryButton.withOpacity(0.4),
          textStyle: const TextStyle(fontSize: TSizes.fontSize16, color: TColors.textWhite, fontWeight: TSizes.fontWeightNm, fontFamily: TTexts.fontFamily),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TSizes.borderRadiusSm))
      )
  );
}