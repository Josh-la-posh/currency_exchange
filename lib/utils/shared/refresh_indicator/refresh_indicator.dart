import 'package:flutter/material.dart';
import 'package:pouch/utils/constants/colors.dart';

class CustomRefreshIndicator extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  const CustomRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      // backgroundColor: TColors.primary,
      color: TColors.primary,
      displacement: 0,
      edgeOffset: 0,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
