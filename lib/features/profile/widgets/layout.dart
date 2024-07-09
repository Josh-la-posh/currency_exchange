import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:swappr/common/styles/spacing_styles.dart';
import 'package:swappr/utils/layouts/app_layout.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

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
    final darkMode = THelperFunctions.isDarkMode(context);
    return AppLayout(
      appbar: AppBar(
        leading: IconButton(
          onPressed: (){Get.back();},
          icon: const Icon(Icons.arrow_back_ios_sharp),
          style: IconButton.styleFrom(
              foregroundColor: TColors.primary,
              iconSize: TSizes.iconBackSize
          ),
          hoverColor: Colors.transparent,
        ),
        title: RichText(
            text: TextSpan(
                style: Theme.of(context).textTheme.titleLarge,
                children: const <TextSpan> [
                  TextSpan(
                      text: 'Bank Accounts',
                      style: TextStyle(
                          fontSize: 22
                      )
                  )
                ]
            )
        ),
        centerTitle: true,
      ),
      currentRoute: RouteType.Profile,
      layoutBodyColor: darkMode ? TColors.black.withOpacity(0.8) : TColors.white,
      childWidget: Container(
        padding: TSpacingStyle.horizontalPadding,
        child: childWidget,
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
