import 'package:flutter/material.dart';
import 'package:swappr/common/styles/spacing_styles.dart';
import 'package:swappr/common/widgets/currencyWidget.dart';
import 'package:swappr/features/dashboard/screens/subscribe/widgets/subscription_form.dart';

import '../../../../../utils/constants/sizes.dart';

class AddSubscriptionScreen extends StatelessWidget {
  const AddSubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.dashboardPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CurrencyWidget(),
              const SizedBox(height: TSizes.spaceBtwSections,),
              Text('Subscribe', style: Theme.of(context).textTheme.titleMedium,),
              const SizedBox(height: TSizes.sm,),
              Text('Notify me when an offer is created that matches this criteria:', style: Theme.of(context).textTheme.labelMedium,),
              const SizedBox(height: TSizes.spaceBtwItems,),
              const SubscriptionForm()
            ],
          ),
        ),
      ),
    );
  }
}
