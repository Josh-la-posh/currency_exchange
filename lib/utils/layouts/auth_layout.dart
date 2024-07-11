import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/utils/constants/sizes.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';

import '../../common/styles/spacing_styles.dart';
import '../../common/widgets/buttons/app_bar_widget.dart';
import '../../common/widgets/custom_shapes/curved_edges.dart';
import '../constants/colors.dart';

class AuthLayout extends StatelessWidget {
  AuthLayout({
    super.key,
    required this.child,
    required this.title,
    required this.heading,
    this.onTap
  });
  Widget child;
  String title;
  String heading;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(bottom: TSizes.defaultSpace),
        child: Column(
          children: [
            ClipPath(
              clipper: TCustomCurvedEdges(),
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                    color: TColors.authTransBack
                ),
              ),
            ),
            AppBarWidget(heading: heading, onTap: onTap,),
            SizedBox(
              height: THelperFunctions.screenHeight() - 126 - TSizes.defaultSpace,
              child: SingleChildScrollView(
                child: Padding(
                  padding: TSpacingStyle.paddingWithAppBarHeight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: TSizes.defaultSpace,),
                      if (title.length > 0)
                      Text(
                        title,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      if (title.length > 0)
                        SizedBox(height: TSizes.spaceBtwSections - 4,),
                      child
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

