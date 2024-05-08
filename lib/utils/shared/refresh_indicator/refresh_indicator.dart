import 'package:flutter/material.dart';
import 'package:swappr/utils/constants/colors.dart';

class CustomRefreshIndicator extends StatelessWidget {
  final Widget childWidget;
  final Future<void> Function() onRefresh;
  final RefreshIndicatorTriggerMode triggerMode;
  const CustomRefreshIndicator({
    super.key,
    required this.childWidget,
    required this.onRefresh,
    this.triggerMode = RefreshIndicatorTriggerMode.anywhere,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      backgroundColor: TColors.primary,
      color: TColors.primary,
      displacement: screenHeight / 3,
      strokeWidth: 3,
      triggerMode: triggerMode,
      onRefresh: onRefresh,
      child: childWidget,
    );
  }
}
