import 'package:flutter/material.dart';
import 'package:swappr/common/widgets/currencyWidget.dart';
import '../../../common/styles/spacing_styles.dart';
import '../../../common/widgets/buttons/elevated_button.dart';
import '../../../data/modules/app_navigator.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../routes/names.dart';


class SuccessScreenWidget extends StatelessWidget {
  SuccessScreenWidget({
    super.key,
    required this.text,
    required this.child,
    this.onTap
  });
  String text;
  Widget child;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: TSpacingStyle.homePadding,
        child: SizedBox(
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CurrencyWidget(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: THelperFunctions.screenHeight() * 0.05,),
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
                      color: TColors.primaryBackground,
                      child: child
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections * 1.5,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                    child: TElevatedButton(
                        onTap: onTap != null ? onTap : (){
                          AppNavigator.instance
                              .removeAllNavigateToNavHandler(ALL_OFFER_SCREEN_ROUTE);
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