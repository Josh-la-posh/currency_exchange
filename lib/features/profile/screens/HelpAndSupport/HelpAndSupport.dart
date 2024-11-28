import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkMode ? TColors.textPrimaryO40 : Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
          style: IconButton.styleFrom(
            foregroundColor: Colors.grey,
            iconSize: TSizes.iconBackSize,
          ),
          hoverColor: Colors.transparent,
        ),
        title: Text(
          'Help and Support',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: Container(
        height: Get.size.height,
        child: Center(
            child: Text('No data available')
        ),
      ),
    );
  }
}
