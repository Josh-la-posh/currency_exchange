import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/profile/screens/profile.dart';
import 'package:pouch/utils/constants/colors.dart';

import '../../../utils/constants/sizes.dart';

class AppDrawerWidget extends StatelessWidget {
  final bool darkMode;
  const AppDrawerWidget({super.key, required this.darkMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Container(
              color: darkMode ? TColors.textPrimaryO40 : Colors.white,
              height: 70,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace * 0.4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: 27,
                      color: darkMode ? Colors.grey : Colors.black,
                    ),
                    hoverColor: Colors.transparent,

                  )
                ],
              ),
            ),
            Expanded(child: ProfileScreen()),
          ],
        ),
      ),
    );
  }
}
