import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/styles/spacing_styles.dart';
import '../../../common/widgets/buttons/elevated_button.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../utils/layouts/navigation_menu.dart';


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
    NavigationController controller = Get.find();
    final darkMode = THelperFunctions.isDarkMode(context);
    return SingleChildScrollView(
      padding: TSpacingStyle.homePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: THelperFunctions.screenHeight() * 0.05,),
              const Image(image: AssetImage(TImages.success)),
              const SizedBox(height: TSizes.spaceBtwElements,),
              SizedBox(
                width: THelperFunctions.screenWidth() * 0.8,
                child: Text(
                  textAlign: TextAlign.center,
                  text,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections * 2,),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: TSizes.lg, vertical: 15),
                  height: THelperFunctions.screenHeight() * 0.28,
                  color: darkMode ? Colors.grey.withOpacity(0.5) : TColors.primaryBackground,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        child,
                      ],
                    ),
                  )
              ),
              const SizedBox(height: TSizes.spaceBtwSections * 1.5,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                child: TElevatedButton(
                    onTap: onTap != null ? onTap : (){
                      controller.selectedIndex.value = 1;
                      Get.to(() => NavigationMenu());
                      // Get.offAll(() => NavigationMenu());
                      // AppNavigator.instance
                      //     .removeAllNavigateToNavHandler(DASHBOARD_SCREEN_ROUTE);
                      },
                    buttonText: 'Done'),
              )
            ],
          )
        ],
      ),
    );
  }
}