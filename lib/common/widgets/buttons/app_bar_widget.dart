import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:swappr/utils/constants/sizes.dart';

import '../../../utils/constants/colors.dart';


class AppBarWidget extends StatelessWidget {
  AppBarWidget({
    super.key,
    required this.heading,
    this.onTap
  });

  final String heading;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onTap != null ? onTap : (){Get.back();},
          icon: const Icon(Icons.arrow_back_ios_sharp),
          style: IconButton.styleFrom(
              foregroundColor: TColors.primary,
              iconSize: TSizes.iconBackSize
          ),
          // hoverColor: Colors.transparent,
        ),
        Text(
          heading,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }
}