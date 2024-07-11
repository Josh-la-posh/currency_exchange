import 'package:flutter/material.dart';
import 'package:pouch/common/widgets/custom_shapes/currency_widget_with_back.dart';
import 'package:pouch/features/subscription/widgets/subscription_form.dart';
import '../../../common/styles/spacing_styles.dart';
import '../../../utils/constants/sizes.dart';

class AddSubscriptionScreen extends StatelessWidget {
  const AddSubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.homePadding,
          child: Column(
            children: [
              CurrencyWidgetWithBack(),
              Padding(
                padding: TSpacingStyle.paddingWithAppBarHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: TSizes.spaceBtwSections,),
                    Text('Subscribe', style: Theme.of(context).textTheme.titleMedium,),
                    const SizedBox(height: TSizes.sm,),
                    Text('Notify me when an offer is created that matches this criteria:', style: Theme.of(context).textTheme.labelMedium,),
                    const SizedBox(height: TSizes.spaceBtwItems,),
                    const SubscriptionForm()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
