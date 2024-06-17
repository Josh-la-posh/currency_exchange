import 'package:flutter/material.dart';
import 'package:swappr/common/styles/spacing_styles.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/layouts/app_layout.dart';

import '../../../utils/helpers/helper_functions.dart';

class DashboardScreenLayout extends StatelessWidget {
  final Widget childWidget;
  const DashboardScreenLayout({
    super.key,
    required this.childWidget
  });

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return AppLayout(
        currentRoute: RouteType.Home,
        layoutBodyColor: darkMode ? TColors.black.withOpacity(0.8) : TColors.secondaryBorder,
        childWidget: Container(
          padding: TSpacingStyle.homePadding,
          // color: darkMode ? TColors.black.withOpacity(0.8) : TColors.secondaryBorder,
          child: childWidget,
        ),
    );
  }
}
