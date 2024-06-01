import 'package:flutter/material.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/constants/sizes.dart';

class TTextFormFieldTheme {
  TTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
      borderSide: BorderSide(width: 1, color: TColors.secondaryBorder30),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(TSizes.buttonRadius),
      borderSide: BorderSide(width: 1, color: TColors.secondaryBorder30),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(TSizes.buttonRadius),
        borderSide: BorderSide(width: 1, color: TColors.secondaryBorder30)
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
    filled: true,
    fillColor: TColors.secondaryBorder30,
    errorMaxLines: 3,
    prefixIconColor: TColors.grey,
    suffixIconColor: TColors.grey,
    labelStyle: const TextStyle().copyWith(fontSize: TSizes.fontSize14, color: TColors.textSecondary),
    hintStyle: const TextStyle().copyWith(fontSize: TSizes.fontSize14, color: TColors.textSecondary),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(fontSize: TSizes.fontSize14, color: TColors.white.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(TSizes.buttonRadius),
      borderSide: BorderSide(width: 1, color: TColors.secondaryBorder30),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(TSizes.buttonRadius),
      borderSide: BorderSide(width: 1, color: TColors.secondaryBorder30),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(TSizes.buttonRadius),
        borderSide: BorderSide(width: 1, color: TColors.secondaryBorder30)
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