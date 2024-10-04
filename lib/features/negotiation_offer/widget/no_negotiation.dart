import 'package:flutter/material.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class NoNegotiationScreen extends StatelessWidget {
  final String title;
  const NoNegotiationScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return SizedBox(
      height: 250,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.file_open_outlined, color: darkMode ? Colors.white.withOpacity(0.7) : Colors.black, size: 50,),
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
