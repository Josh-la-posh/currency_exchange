import 'package:flutter/material.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/constants/sizes.dart';

class TTextFormFieldTheme {
  TTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: TColors.textFieldBackground,
    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    suffixIconColor: TColors.black,
    labelStyle: const TextStyle().copyWith(fontSize: TSizes.fontSize14, color: TColors.textPrimary),
    hintStyle: const TextStyle().copyWith(fontSize: TSizes.fontSize14, color: TColors.textPrimary),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(fontSize: TSizes.fontSize14, color: TColors.textPrimary.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(TSizes.buttonRadius),
      borderSide: BorderSide(width: 1, color: TColors.secondaryBorder),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(TSizes.buttonRadius),
      borderSide: BorderSide(width: 1, color: TColors.secondaryBorder),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(TSizes.buttonRadius),
        borderSide: BorderSide(width: 1, color: TColors.secondaryBorder)
    ),
    errorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(TSizes.buttonRadius),
        borderSide: const BorderSide(width: 1, color: TColors.danger)
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(TSizes.buttonRadius),
        borderSide: const BorderSide(width: 2, color: TColors.danger)
    ),

  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    fillColor: TColors.textFieldBackground,
    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    suffixIconColor: TColors.white,
    labelStyle: const TextStyle().copyWith(fontSize: TSizes.fontSize14, color: TColors.textPrimary),
    hintStyle: const TextStyle().copyWith(fontSize: TSizes.fontSize14, color: TColors.textPrimary),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(fontSize: TSizes.fontSize14, color: TColors.white.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(TSizes.buttonRadius),
      borderSide: const BorderSide(width: 1, color: TColors.white),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(TSizes.buttonRadius),
      borderSide: const BorderSide(width: 1, color: TColors.white),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(TSizes.buttonRadius),
        borderSide: const BorderSide(width: 1, color: TColors.white)
    ),
    errorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(TSizes.buttonRadius),
        borderSide: const BorderSide(width: 1, color: TColors.danger)
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(TSizes.buttonRadius),
        borderSide: const BorderSide(width: 2, color: TColors.danger)
    ),

  );
}