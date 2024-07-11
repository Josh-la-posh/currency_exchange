import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pouch/utils/constants/colors.dart';
import 'loader.dart';

class GlobalAppLoader extends StatelessWidget {
  final Widget app;
  const GlobalAppLoader({super.key, required this.app});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: const Loader(),
      overlayColor: TColors.primary,
      overlayOpacity: 0.7,
      duration: const Duration(seconds: 1),
      child: app,
    );
  }
}
