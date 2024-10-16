import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/modules/interceptor.dart';
import '../../../utils/constants/sizes.dart';
import '../currencyWidget.dart';

class CurrencyWidgetWithBack extends StatelessWidget {
  VoidCallback? onTap;
  final AppInterceptor appInterceptor = AppInterceptor();
  CurrencyWidgetWithBack({
    super.key,
    this.onTap
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
                onPressed: onTap != null ? onTap : (){
                  appInterceptor.cancelOngoingRequest();
                  Get.back();
                  },
                icon: const Icon(Icons.arrow_back_ios_rounded)
            ),
          ),
          // const SizedBox(width: TSizes.spaceBtwElements,),
          Expanded(child: CurrencyWidget()),
        ],
      ),
    );
  }
}