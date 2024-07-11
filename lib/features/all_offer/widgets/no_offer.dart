import 'package:flutter/material.dart';
import 'package:pouch/common/styles/spacing_styles.dart';
import 'package:pouch/utils/constants/image_strings.dart';
import 'package:pouch/utils/constants/sizes.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';

class NoOfferScreen extends StatelessWidget {
  const NoOfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: THelperFunctions.screenHeight() * 0.7 - 65,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage(TImages.emptyScreen)),
            const SizedBox(height: TSizes.spaceBtwElements,),
            Text('No Offer', style: Theme.of(context).textTheme.titleMedium,),
            Text('There are no offers available', style: Theme.of(context).textTheme.labelMedium,),
          ],
        ),
      ),
    );
  }
}
