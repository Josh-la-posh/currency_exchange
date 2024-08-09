import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/utils/constants/sizes.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';

import '../../common/styles/spacing_styles.dart';
import '../../common/widgets/buttons/app_bar_widget.dart';
import '../../common/widgets/custom_shapes/curved_edges.dart';
import '../constants/colors.dart';

class AuthLayout extends StatelessWidget {
  final Widget child;
  final String title;
  final String heading;
  final VoidCallback? onTap;

  const AuthLayout({
    super.key,
    required this.child,
    required this.title,
    required this.heading,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: darkMode ? Colors.black.withOpacity(0.5) : Colors.white,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(bottom: TSizes.defaultSpace),
        child: Column(
          children: [
            _buildCurvedHeader(),
            AppBarWidget(
              heading: heading,
              onTap: onTap,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: TSpacingStyle.paddingWithAppBarHeight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: TSizes.defaultSpace),
                      if (title.isNotEmpty) _buildTitle(context),
                      if (title.isNotEmpty)
                        const SizedBox(height: TSizes.spaceBtwSections - 4),
                      child,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurvedHeader() {
    return ClipPath(
      clipper: TCustomCurvedEdges(),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: TColors.authTransBack,
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineLarge,
    );
  }
}
