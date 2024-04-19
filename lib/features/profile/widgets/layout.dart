import 'package:flutter/material.dart';
import 'package:swappr/common/styles/spacing_styles.dart';
import 'package:swappr/utils/layouts/app_layout.dart';

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
    return AppLayout(
      currentRoute: RouteType.Profile,
      childWidget: Container(
        padding: TSpacingStyle.dashboardPadding,
        child: childWidget,
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
