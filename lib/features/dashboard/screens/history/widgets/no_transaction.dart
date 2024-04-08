import 'package:flutter/material.dart';

import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class NoTransactionScreen extends StatelessWidget {
  const NoTransactionScreen({super.key});

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
            Text('No Transaction', style: Theme.of(context).textTheme.titleMedium,),
            Text('There is no transaction done yet', style: Theme.of(context).textTheme.labelMedium,),
          ],
        ),
      ),
    );;
  }
}
