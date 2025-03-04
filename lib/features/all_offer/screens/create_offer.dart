import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swappr/common/styles/spacing_styles.dart';
import 'package:swappr/common/widgets/custom_shapes/currency_widget_with_back.dart';
import 'package:swappr/utils/constants/sizes.dart';

import '../widgets/create_offer_form.dart';

class CreateOfferScreen extends StatelessWidget {
  const CreateOfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: TSpacingStyle.homePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CurrencyWidgetWithBack(),
            Expanded(
              child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: TSizes.spaceBtwSections,),
                        Text('Create Offer', style: Theme.of(context).textTheme.headlineLarge,),
                        const SizedBox(height: TSizes.spaceBtwItems,),
                        Text('A brief explanation here on what users can do.', style: Theme.of(context).textTheme.labelMedium,),
                        const SizedBox(height: TSizes.spaceBtwElements,),
                        const CreateOfferForm()
                      ],
                    ),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
