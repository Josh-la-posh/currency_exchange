import 'package:flutter/material.dart';
import 'package:swappr/common/styles/spacing_styles.dart';
import 'package:swappr/utils/layouts/app_layout.dart';

class DashboardScreenLayout extends StatelessWidget {
  final Widget childWidget;
  const DashboardScreenLayout({
    super.key,
    required this.childWidget
  });

  @override
  Widget build(BuildContext context) {
    return AppLayout(
        currentRoute: RouteType.Home,
        childWidget: Container(
          padding: TSpacingStyle.homePadding,
          child: childWidget,
        ),
    );
  }
}
