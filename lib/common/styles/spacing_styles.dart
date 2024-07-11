import 'package:flutter/material.dart';
import 'package:pouch/utils/constants/sizes.dart';

class TSpacingStyle {
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: TSizes.md,
    left: TSizes.defaultSpace,
    bottom: TSizes.defaultSpace,
    right: TSizes.defaultSpace,
  );
  static const EdgeInsetsGeometry horizontalPadding = EdgeInsets.only(
    left: TSizes.defaultSpace,
    right: TSizes.defaultSpace,
  );

  static const EdgeInsetsGeometry dashboardPadding = EdgeInsets.only(
    top: TSizes.appBarHeight,
    left: TSizes.defaultSpace / 1.5,
    bottom: 0,
    right: TSizes.defaultSpace / 1.5,
  );

  static const EdgeInsetsGeometry homePadding = EdgeInsets.only(
    top: TSizes.appBarHeight,
    bottom: TSizes.defaultSpace,
  );

  static const EdgeInsetsGeometry bottomSheetPadding = EdgeInsets.only(
    top: TSizes.appBarHeight,
    bottom: TSizes.defaultSpace * 2,
    left: TSizes.xl,
    right: TSizes.xl,
  );
}