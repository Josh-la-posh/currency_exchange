import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/constants/sizes.dart';
import '../currencyWidget.dart';

class CurrencyWidgetWithBack extends StatelessWidget {
  const CurrencyWidgetWithBack({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace / 1.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: IconButton(
                onPressed: (){Get.back();},
                icon: const Icon(Icons.arrow_back_ios_rounded)
            ),
          ),
          const SizedBox(width: TSizes.spaceBtwElements,),
          const Expanded(child: CurrencyWidget()),
        ],
      ),
    );
  }
}