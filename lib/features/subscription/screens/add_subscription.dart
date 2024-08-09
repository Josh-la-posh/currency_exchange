import 'package:flutter/material.dart';
import 'package:pouch/common/widgets/custom_shapes/currency_widget_with_back.dart';
import 'package:pouch/features/subscription/widgets/subscription_form.dart';
import 'package:pouch/utils/constants/colors.dart';
import '../../../common/styles/spacing_styles.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class AddSubscriptionScreen extends StatelessWidget {
  const AddSubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(

      appBar: AppBar(
        backgroundColor: darkMode ? TColors.textPrimaryO40 : Colors.white,
        shadowColor: darkMode ? TColors.textPrimaryO40 : Colors.white,
        title: Text('Add Subscription', style: Theme.of(context).textTheme.titleMedium),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: TSpacingStyle.horizontalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: TSizes.sm),
                Text(
                  'Notify me when an offer is created that matches this criteria:',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                const SubscriptionForm(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
