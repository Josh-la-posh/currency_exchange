import 'package:flutter/material.dart';
import 'package:swappr/common/styles/spacing_styles.dart';
import 'package:swappr/utils/layouts/app_layout.dart';

class SubscribeScreenLayout extends StatelessWidget {
  final Widget childWidget;
  final Widget? floatingActionButton;
  const SubscribeScreenLayout({
    super.key,
    required this.childWidget, this.floatingActionButton
  });

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      currentRoute: RouteType.Subscribe,
      childWidget: Container(
        padding: TSpacingStyle.dashboardPadding,
        child: childWidget,
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
