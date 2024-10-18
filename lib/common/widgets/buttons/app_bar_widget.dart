import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/utils/constants/sizes.dart';

import '../../../data/modules/interceptor.dart';
import '../../../utils/constants/colors.dart';


class AppBarWidget extends StatelessWidget {
  AppBarWidget({
    super.key,
    required this.heading,
    this.onTap
  });

  final String heading;
  VoidCallback? onTap;
  final AppInterceptor appInterceptor = AppInterceptor();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onTap != null ? onTap : (){
            Get.back();
            },
          icon: const Icon(Icons.arrow_back_ios_sharp),
          style: IconButton.styleFrom(
              foregroundColor: TColors.primary,
              iconSize: TSizes.iconBackSize
          ),
        ),
        Text(
          heading,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }
}