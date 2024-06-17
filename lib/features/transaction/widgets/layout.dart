import 'package:flutter/material.dart';
import 'package:swappr/common/styles/spacing_styles.dart';
import 'package:swappr/utils/constants/sizes.dart';
import 'package:swappr/utils/layouts/app_layout.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';

class TransactionScreenLayout extends StatelessWidget {
  final Widget childWidget;
  const TransactionScreenLayout({
    super.key,
    required this.childWidget
  });

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return AppLayout(
      currentRoute: RouteType.History,
      layoutBodyColor: darkMode ? TColors.black.withOpacity(0.8) : TColors.white,
      childWidget: Container(
        padding: TSpacingStyle.homePadding,
        child: childWidget,
      ),
    );
  }
}
