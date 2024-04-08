import 'package:flutter/material.dart';
import 'package:swappr/utils/constants/colors.dart';

import '../../constants/sizes.dart';
import '../../constants/texts.dart';

class TOutlinedButtonTheme {
  TOutlinedButtonTheme._();

  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          elevation: 0,
          foregroundColor: TColors.primary,
          backgroundColor: TColors.white,
          side: const BorderSide(color: TColors.primary),
          textStyle: const TextStyle(fontSize: TSizes.fontSize16, color: TColors.primary, fontWeight: TSizes.fontWeightMd, fontFamily: TTexts.fontFamily),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TSizes.borderRadiusSm))
      )
  );

  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          elevation: 0,
          foregroundColor: TColors.primary,
          backgroundColor: TColors.black,
          side: const BorderSide(color: TColors.primary),
          textStyle: const TextStyle(fontSize: TSizes.fontSize16, color: TColors.primary, fontWeight: TSizes.fontWeightMd, fontFamily: TTexts.fontFamily),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TSizes.borderRadiusSm))
      )
  );
}