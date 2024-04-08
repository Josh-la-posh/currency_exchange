import 'package:flutter/material.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/constants/sizes.dart';
import 'package:swappr/utils/constants/texts.dart';

class TTextTheme {
  TTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(fontSize: TSizes.fontSize22, fontWeight: TSizes.fontWeightMd, color: TColors.textPrimary, fontFamily: TTexts.fontFamily, letterSpacing: TSizes.letterSpacingSm, height: TSizes.lineHeight / TSizes.fontSize22),
    headlineMedium: const TextStyle().copyWith(fontSize: TSizes.fontSize22, fontWeight: TSizes.fontWeightNm, color: TColors.textSecondary, fontFamily: TTexts.fontFamily, letterSpacing: TSizes.letterSpacingSm),

    titleLarge: const TextStyle().copyWith(fontSize: TSizes.fontSize18, fontWeight: TSizes.fontWeightLg, color: TColors.textPrimaryO80, fontFamily: TTexts.fontFamily, letterSpacing: TSizes.letterSpacingSm, height: TSizes.lineHeight / TSizes.fontSize22),
    titleMedium: const TextStyle().copyWith(fontSize: TSizes.fontSize16, fontWeight: TSizes.fontWeightLg, color: TColors.textPrimary, fontFamily: TTexts.fontFamily, letterSpacing: TSizes.letterSpacingSm, height: TSizes.lineHeight / TSizes.fontSize16),
    titleSmall: const TextStyle().copyWith(fontSize: TSizes.fontSize16, fontWeight: TSizes.fontWeightNm, color: TColors.textPrimaryO80, fontFamily: TTexts.fontFamily, letterSpacing: TSizes.letterSpacingSm, height: TSizes.lineHeight / TSizes.fontSize16),

    bodyLarge: const TextStyle().copyWith(fontSize: TSizes.fontSize20, fontWeight: TSizes.fontWeightNm, color: TColors.textPrimaryO80, fontFamily: TTexts.fontFamily, letterSpacing :TSizes.letterSpacingSm),
    bodyMedium: const TextStyle().copyWith(fontSize: TSizes.fontSize14, fontWeight: TSizes.fontWeightNm, color: TColors.textSecondary, fontFamily: TTexts.fontFamily, letterSpacing: TSizes.letterSpacingSm),
    bodySmall: const TextStyle().copyWith(fontSize: TSizes.fontSize10, fontWeight: TSizes.fontWeightMd, color: TColors.textCurrency, fontFamily: TTexts.fontFamily, letterSpacing: TSizes.letterSpacingSm),

    // bodyText1: const TextStyle().copyWith(fontSize: TSizes.fontSize14, fontWeight: TSizes.fontWeightMd, color: TColors.textPrimaryO80, fontFamily: TTexts.fontFamily, letterSpacing: TSizes.letterSpacingSm),

    labelMedium: const TextStyle().copyWith(fontSize: TSizes.fontSize14, fontWeight: TSizes.fontWeightNm, color: TColors.textPrimaryO80, fontFamily: TTexts.fontFamily, letterSpacing: TSizes.letterSpacingSm, height: TSizes.lineHeight / TSizes.fontSize14),
    labelSmall: const TextStyle().copyWith(fontSize: TSizes.fontSize12, fontWeight: TSizes.fontWeightNm, color: TColors.textPrimaryO80, fontFamily: TTexts.fontFamily, letterSpacing: TSizes.letterSpacingSm, height: TSizes.lineHeight / TSizes.fontSize12),

  );

  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(fontSize: TSizes.fontSize22, fontWeight: TSizes.fontWeightMd, color: TColors.textSecondary, fontFamily: TTexts.fontFamily, letterSpacing: TSizes.letterSpacingSm, height: TSizes.lineHeight / TSizes.fontSize22),
    headlineMedium: const TextStyle().copyWith(fontSize: TSizes.fontSize22, fontWeight: TSizes.fontWeightNm, color: TColors.textSecondary, fontFamily: TTexts.fontFamily, letterSpacing: TSizes.letterSpacingSm),

    titleLarge: const TextStyle().copyWith(fontSize: TSizes.fontSize18, fontWeight: TSizes.fontWeightLg, color: TColors.white, fontFamily: TTexts.fontFamily, letterSpacing: TSizes.letterSpacingSm, height: TSizes.lineHeight / TSizes.fontSize22),
    titleMedium: const TextStyle().copyWith(fontSize: TSizes.fontSize16, fontWeight: TSizes.fontWeightLg, color: TColors.white, fontFamily: TTexts.fontFamily, letterSpacing: TSizes.letterSpacingSm, height: TSizes.lineHeight / TSizes.fontSize16),
    titleSmall: const TextStyle().copyWith(fontSize: TSizes.fontSize16, fontWeight: TSizes.fontWeightNm, color: TColors.textSecondary, fontFamily: TTexts.fontFamily, letterSpacing: TSizes.letterSpacingSm, height: TSizes.lineHeight / TSizes.fontSize16),

    bodyLarge: const TextStyle().copyWith(fontSize: TSizes.fontSize20, fontWeight: TSizes.fontWeightNm, color: TColors.textPrimaryO80, fontFamily: TTexts.fontFamily, letterSpacing: TSizes.letterSpacingSm),
    bodyMedium: const TextStyle().copyWith(fontSize: TSizes.fontSize16, fontWeight: TSizes.fontWeightNm, color: TColors.textSecondary, fontFamily: TTexts.fontFamily, letterSpacing: TSizes.letterSpacingSm),
    bodySmall: const TextStyle().copyWith(fontSize: TSizes.fontSize10, fontWeight: TSizes.fontWeightMd, color: TColors.white, fontFamily: TTexts.fontFamily, letterSpacing: TSizes.letterSpacingSm),

    // bodyText1: const TextStyle().copyWith(fontSize: TSizes.fontSize14, fontWeight: TSizes.fontWeightMd, color: TColors.textSecondary, fontFamily: TTexts.fontFamily, letterSpacing: TSizes.letterSpacingSm),

    labelMedium: const TextStyle().copyWith(fontSize: TSizes.fontSize14, fontWeight: TSizes.fontWeightNm, color: TColors.textSecondary, letterSpacing: TSizes.letterSpacingSm, height: TSizes.lineHeight / TSizes.fontSize14),
    labelSmall: const TextStyle().copyWith(fontSize: TSizes.fontSize12, fontWeight: TSizes.fontWeightNm, color: TColors.textSecondary.withOpacity(0.8), letterSpacing: TSizes.letterSpacingSm, height: TSizes.lineHeight / TSizes.fontSize12),
  );
}