import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swappr/common/widgets/buttons/elevated_button.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/constants/texts.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';

import '../../../../../utils/constants/sizes.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Padding(
          padding: const EdgeInsets.only(top: TSizes.spaceBtwSections - 4),
          child: Column(
            children: [
              /// Email
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email', style: Theme.of(context).textTheme.labelMedium,),
                  SizedBox(height: TSizes.sm),
                  SizedBox(
                    height: 48,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        // suffixIcon: Icon(Icons.)
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
                  SizedBox(height: TSizes.sm),
                  SizedBox(
                    height: 48,
                    child: TextFormField(
                      // obscureText: ,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Iconsax.eye_slash),
                      ),
                    ),
                  )
                ],
              ),

              const SizedBox(height: TSizes.spaceBtwInputFields / 3,),

              // Forgot password
              Align(
                alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: (){},
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: THelperFunctions.isDarkMode(context) ? TColors.textWhite : TColors.textPrimary,
                          fontSize: TSizes.fontSize14,
                          fontFamily: TTexts.fontFamily,
                          fontWeight: TSizes.fontWeightNm
                        ),
                      ),
                  )
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              TElevatedButton(onTap: (){}, buttonText: 'Sign In')
            ],
          ),
        )
    );
  }
}