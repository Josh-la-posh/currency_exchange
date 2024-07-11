import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/utils/constants/sizes.dart';

import '../../../utils/constants/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(TSizes.appBarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: TSizes.appBarHeight,
      leadingWidth: 35,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(Icons.keyboard_arrow_left_outlined),
        style: IconButton.styleFrom(
          foregroundColor: TColors.primary,
          iconSize: 35
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      centerTitle: true,
    );
  }
}