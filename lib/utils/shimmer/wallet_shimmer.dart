import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/sizes.dart';

class WalletShimmer extends StatelessWidget {
  WalletShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace / 2),
      child: ListView.builder(
          itemCount: 2,
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (_, index) {
            return Shimmer.fromColors(
              baseColor: Get.isDarkMode ? Color(0xFF3E3E3E) : Colors.grey[300]!,
              highlightColor: Get.isDarkMode ? Colors.grey.withOpacity(0.2) : Colors.grey[100]!,
              child: Container(
                margin: EdgeInsets.only(bottom: 10),
                height: 80,
                child:
                Container(
                  height: 20,
                  // width: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Get.isDarkMode ? Color(0xFF3E3E3E) : Color(0xFFF6F6F6)
                  ),
                ),
              ),
            );
          }

      ),
    );
  }
}
