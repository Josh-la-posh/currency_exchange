import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:swappr/common/widgets/currencyWidget.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/layouts/app_layout.dart';
import '../../../common/styles/spacing_styles.dart';
import '../../../common/widgets/buttons/elevated_button.dart';
import '../../../common/widgets/custom_shapes/currency_widget_with_back.dart';
import '../../../data/modules/app_navigator.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../screens/all_offer.dart';


class SuccessScreenWidget extends StatelessWidget {
  SuccessScreenWidget({
    super.key,
    required this.text,
    required this.child,
  });
  String text;
  Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: TSpacingStyle.homePadding,
        child: SizedBox(
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CurrencyWidget(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Image(image: AssetImage(TImages.success)),
                  const SizedBox(height: TSizes.spaceBtwElements,),
                  Text(
                    text,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections * 2,),
                  Container(
                      height: THelperFunctions.screenHeight() * 0.25,
                      padding: const EdgeInsets.symmetric(vertical: TSizes.xl, horizontal: TSizes.lg),
                      // color: TColors.primaryBackground,
                      // child: child
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections * 1.5,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                    child: TElevatedButton(
                        onTap: (){
                          AppNavigator.instance
                              .removeAllNavigateToNavHandler(HOME_INDEX_SCREEN_ROUTE);
                          },
                        buttonText: 'Done'),
                  )
                ],
              )
            ],
          ),
        ),
      );
  }
}