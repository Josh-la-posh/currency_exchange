import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../common/styles/spacing_styles.dart';
import '../constants/sizes.dart';

class HalfBottomSheetWidget extends StatelessWidget {
  HalfBottomSheetWidget({
    super.key,
    required this.title,
    required this.child
  });
  String title;
  Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: TSpacingStyle.bottomSheetPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium,),
                InkWell(
                  onTap: (){
                    Get.back();
                  },
                  child: const Icon(Icons.close, ),
                )
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections,),
            child
          ],
        ),
      ),
    );
  }
}
