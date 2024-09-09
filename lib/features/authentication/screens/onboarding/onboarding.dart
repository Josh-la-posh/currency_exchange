import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/common/widgets/buttons/outlined_button.dart';
import 'package:pouch/features/authentication/screens/login/login.dart';
import 'package:pouch/features/authentication/screens/sign_up/sign_up.dart';
import 'package:pouch/utils/constants/colors.dart';
import 'package:pouch/common/widgets/buttons/elevated_button.dart';
import 'package:pouch/utils/constants/image_strings.dart';
import 'package:pouch/utils/constants/sizes.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: darkMode ? Colors.black.withOpacity(0.5) : Colors.white,
      body: Container(
        height: THelperFunctions.screenHeight(),
        padding: const EdgeInsets.symmetric(
          horizontal: TSizes.defaultSpace,
          vertical: TSizes.defaultSpace * 3,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildLogoSection(textTheme),
            _buildActionSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoSection(TextTheme textTheme) {
    return Column(
      children: [
        Image.asset(TImages.appLogoPng, height: 80, width: 80),
        const SizedBox(height: TSizes.md),
        Text(
          'Welcome to pouch!',
          style: textTheme.headlineMedium?.copyWith(
            fontWeight: TSizes.fontWeightMd,
          ),
        ),
      ],
    );
  }

  Widget _buildActionSection(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Text(
          'Swap NGN for GBP',
          style: textTheme.headlineMedium,
        ),
        const SizedBox(height: TSizes.md),
        Text(
          'Cheap, Fast and Safe',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: TSizes.defaultSpace * 2),
        TElevatedButton(
          onTap: () => Get.to(() => const CreateAccountScreen()),
          buttonText: 'Sign Up',
        ),
        const SizedBox(height: TSizes.spaceBtwButtons),
        TOutlinedButton(
          onTap: () => Get.to(() => const LoginScreen()),
          buttonText: 'Log In',
        ),
      ],
    );
  }
}
