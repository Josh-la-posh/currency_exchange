import 'package:flutter/material.dart';
import 'package:swappr/common/styles/spacing_styles.dart';
import 'package:swappr/utils/layouts/app_layout.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';

class ProfileScreenLayout extends StatelessWidget {
  final Widget childWidget;
  final Widget? floatingActionButton;
  const ProfileScreenLayout({
    super.key,
    required this.childWidget,
    this.floatingActionButton
  });

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return AppLayout(
      currentRoute: RouteType.Profile,
      layoutBodyColor: darkMode ? TColors.black.withOpacity(0.8) : TColors.white,
      childWidget: Container(
        padding: TSpacingStyle.dashboardPadding,
        child: childWidget,
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
