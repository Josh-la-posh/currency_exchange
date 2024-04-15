import 'package:flutter/material.dart';
import 'package:swappr/common/styles/spacing_styles.dart';
import 'package:swappr/utils/constants/image_strings.dart';
import 'package:swappr/utils/constants/sizes.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';

class NoSubscriptionScreen extends StatelessWidget {
  const NoSubscriptionScreen({super.key});

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
            const SizedBox(height: TSizes.spaceBtwItems,),
            Text('No Subscription', style: Theme.of(context).textTheme.titleMedium,),
            Text('You have not subscribed to any offer yet', style: Theme.of(context).textTheme.labelMedium,),
          ],
        ),
      ),
    );
  }
}
