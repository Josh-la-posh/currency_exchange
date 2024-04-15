import 'package:flutter/material.dart';
import 'package:swappr/common/styles/spacing_styles.dart';
import 'package:swappr/utils/constants/sizes.dart';
import 'package:swappr/utils/layouts/app_layout.dart';

class TransactionScreenLayout extends StatelessWidget {
  final Widget childWidget;
  const TransactionScreenLayout({
    super.key,
    required this.childWidget
  });

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      currentRoute: RouteType.Home,
      childWidget: Container(
        padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
        child: childWidget,
      ),
    );
  }
}
