import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swappr/common/widgets/buttons/elevated_button.dart';
import 'package:swappr/features/authentication/screens/forgot_poassword/forgot_password.dart';
import 'package:swappr/utils/layouts/navigation_menu.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/constants/texts.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../sign_up/sign_up.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
            child: Column(
              children: [
                /// Email
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email', style: Theme.of(context).textTheme.labelMedium,),
                    SizedBox(
                      height: TSizes.textInputFieldHeight,
                      child: TextFormField(
                        decoration: const InputDecoration(
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                /// Password
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Password', style: Theme.of(context).textTheme.labelMedium,),
                    SizedBox(
                      height: TSizes.textInputFieldHeight,
                      child: TextFormField(
                        // obscureText: ,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Iconsax.eye_slash),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: TSizes.xs),

                // Forgot password
                Align(
                  alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: (){Get.to(() => const ForgotPasswordScreen());},
                      child: RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.labelMedium,
                              children: const <TextSpan> [
                                TextSpan(
                                    text: 'Forgot password?',
                                    style: TextStyle(color: TColors.textPrimary)
                                )
                              ]
                          )
                      ),
                    )
                ),
                const SizedBox(height: TSizes.spaceBtwItems),

                TElevatedButton(onTap: () => Get.to(() => const NavigationMenu()), buttonText: 'Sign In')
              ],
            )
        ),
        const SizedBox(height: TSizes.md),
        Center(
          child: TextButton(
              onPressed: (){Get.to(() => const SignUpScreen());},
              child: Text('No account yet? Sign Up', style: Theme.of(context).textTheme.labelMedium,)
          ),
        )
      ],
    );
  }
}