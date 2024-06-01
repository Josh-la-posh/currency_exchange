import 'package:flutter/material.dart';
import 'package:swappr/utils/constants/sizes.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';

class TSpacingStyle {
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: TSizes.sm,
    left: TSizes.defaultSpace,
    bottom: TSizes.defaultSpace,
    right: TSizes.defaultSpace,
  );

  static const EdgeInsetsGeometry dashboardPadding = EdgeInsets.only(
    top: 50,
    left: TSizes.defaultSpace / 1.5,
    bottom: 0,
    right: TSizes.defaultSpace / 1.5,
  );

  static const EdgeInsetsGeometry homePadding = EdgeInsets.only(
    bottom: TSizes.defaultSpace,
  );

  static const EdgeInsetsGeometry bottomSheetPadding = EdgeInsets.only(
    top: TSizes.defaultSpace * 1.5,
    bottom: TSizes.defaultSpace * 2,
    left: TSizes.xl,
    right: TSizes.xl,
  );
}