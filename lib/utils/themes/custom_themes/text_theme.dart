import 'package:flutter/material.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/constants/sizes.dart';
import 'package:swappr/utils/constants/texts.dart';

class TTextTheme {
  TTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(fontSize: TSizes.fontSize22, fontWeight: TSizes.fontWeightMd, color: TColors.textPrimary, fontFamily: TTexts.fontFamily),
    headlineMedium: const TextStyle().copyWith(fontSize: TSizes.fontSize22, fontWeight: TSizes.fontWeightNm, color: TColors.textSecondary, fontFamily: TTexts.fontFamily),

    titleLarge: const TextStyle().copyWith(fontSize: TSizes.fontSize22, fontWeight: TSizes.fontWeightMd, color: TColors.textPrimary, fontFamily: TTexts.fontFamily),
    titleSmall: const TextStyle().copyWith(fontSize: TSizes.fontSize16, fontWeight: TSizes.fontWeightNm, color: TColors.textPrimary.withOpacity(0.8), fontFamily: TTexts.fontFamily),

    bodyMedium: const TextStyle().copyWith(fontSize: TSizes.fontSize16, fontWeight: TSizes.fontWeightNm, color: TColors.textSecondary, fontFamily: TTexts.fontFamily),

    labelMedium: const TextStyle().copyWith(fontSize: TSizes.fontSize14, fontWeight: TSizes.fontWeightNm, color: TColors.textPrimary.withOpacity(0.8), fontFamily: TTexts.fontFamily),
    labelSmall: const TextStyle().copyWith(fontSize: TSizes.fontSize12, fontWeight: TSizes.fontWeightNm, color: TColors.textPrimary.withOpacity(0.6), fontFamily: TTexts.fontFamily),

  );

  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(fontSize: TSizes.fontSize22, fontWeight: TSizes.fontWeightMd, color: TColors.textWhite, fontFamily: TTexts.fontFamily),
    headlineMedium: const TextStyle().copyWith(fontSize: TSizes.fontSize22, fontWeight: TSizes.fontWeightNm, color: TColors.textWhite, fontFamily: TTexts.fontFamily),

    titleLarge: const TextStyle().copyWith(fontSize: TSizes.fontSize22, fontWeight: TSizes.fontWeightMd, color: TColors.textWhite, fontFamily: TTexts.fontFamily),
    titleSmall: const TextStyle().copyWith(fontSize: TSizes.fontSize16, fontWeight: TSizes.fontWeightNm, color: TColors.textWhite, fontFamily: TTexts.fontFamily),

    bodyMedium: const TextStyle().copyWith(fontSize: TSizes.fontSize16, fontWeight: TSizes.fontWeightNm, color: TColors.textWhite, fontFamily: TTexts.fontFamily),

    labelMedium: const TextStyle().copyWith(fontSize: TSizes.fontSize14, fontWeight: TSizes.fontWeightNm, color: TColors.textWhite),
    labelSmall: const TextStyle().copyWith(fontSize: TSizes.fontSize12, fontWeight: TSizes.fontWeightNm, color: TColors.textWhite.withOpacity(0.6)),
  );
}