import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:swappr/utils/constants/colors.dart';

import '../../features/home/screens/home.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/constants/sizes.dart';
import '../styles/spacing_styles.dart';
import 'buttons/elevated_button.dart';
import 'custom_shapes/currency_widget_with_back.dart';


class SuccessScreenWidget extends StatelessWidget {
  SuccessScreenWidget({
    super.key,
    required this.child
  });
  Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: TSpacingStyle.homePadding,
        child: SizedBox(
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CurrencyWidgetWithBack(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Image(image: AssetImage(TImages.success)),
                  const SizedBox(height: TSizes.spaceBtwElements,),
                  Text(
                    'You have successfully created an offer',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections * 2,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace),
                    width: double.infinity,
                    color: TColors.primaryBackground,
                    child: child
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections * 2,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                    child: TElevatedButton(onTap: (){Get.to(() => const HomeScreen());}, buttonText: 'Done'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}