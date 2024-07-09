import 'package:flutter/material.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class NoNegotiationScreen extends StatelessWidget {
  final String title;
  const NoNegotiationScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: THelperFunctions.screenHeight() * 0.5,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage(TImages.emptyScreen)),
            const SizedBox(height: TSizes.spaceBtwItems,),
            Text('No $title', style: Theme.of(context).textTheme.titleMedium,),
            SizedBox(height: THelperFunctions.screenHeight() * 0.02),
            Text('There are no pending ${title.toLowerCase()}', style: Theme.of(context).textTheme.labelMedium,),
          ],
        ),
      ),
    );;
  }
}
