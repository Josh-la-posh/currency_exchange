import 'package:flutter/material.dart';
import 'package:swappr/common/styles/spacing_styles.dart';
import 'package:swappr/utils/layouts/app_layout.dart';

class AllOfferScreenLayout extends StatelessWidget {
  final Widget childWidget;
  final Widget floatingActionButton;
  const AllOfferScreenLayout({
    super.key,
    required this.childWidget,
    required this.floatingActionButton
  });

  @override
  Widget build(BuildContext context) {
    return AppLayout(
        currentRoute: RouteType.Home,
        childWidget: Container(
          padding: TSpacingStyle.homePadding,
          child: childWidget,
        ),
      floatingActionButton: floatingActionButton,
    );
  }
}
