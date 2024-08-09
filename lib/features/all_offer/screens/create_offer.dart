import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pouch/common/styles/spacing_styles.dart';
import 'package:pouch/common/widgets/currencyWidget.dart';
import 'package:pouch/common/widgets/custom_shapes/currency_widget_with_back.dart';
import 'package:pouch/utils/constants/sizes.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../widgets/create_offer_form.dart';

class CreateOfferScreen extends StatelessWidget {
  const CreateOfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: darkMode ? TColors.textPrimaryO40 : Colors.white,
      appBar: AppBar(
        backgroundColor: darkMode ? TColors.textPrimary.withOpacity(0) : Colors.white,
        surfaceTintColor: darkMode ? TColors.textPrimary.withOpacity(0) : Colors.white,
        leading: IconButton(
          onPressed: (){Get.back();},
          icon: const Icon(Icons.arrow_back),
          style: IconButton.styleFrom(
              foregroundColor: Colors.grey,
              iconSize: TSizes.iconBackSize
          ),
          hoverColor: Colors.transparent,
        ),
        title: Text(
            'Create Offer',
            style: Theme.of(context).textTheme.titleMedium
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CurrencyWidget(),
          const SizedBox(height: TSizes.spaceBtwItems / 3,),
          Expanded(
            child: Container(
              padding: TSpacingStyle.horizontalPadding,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: darkMode ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1),
                  )
                )
              ),
              child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: TSizes.spaceBtwItems / 2),
                      // Text('A brief explanation here on what users can do.', style: Theme.of(context).textTheme.labelMedium,),
                      // const SizedBox(height: TSizes.spaceBtwElements,),
                      const CreateOfferForm()
                    ],
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
