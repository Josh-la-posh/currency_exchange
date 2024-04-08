import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../common/widgets/buttons/elevated_button.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../login/login.dart';

class EmailVerificationForm extends StatelessWidget {
  const EmailVerificationForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(
                text: 'A verification link has been sent to ',
                style: Theme.of(context).textTheme.labelMedium,
                children: const <TextSpan> [
                  TextSpan(
                      text: 'ol****@gmail.com',
                      style: TextStyle(fontWeight: TSizes.fontWeightLg)
                  ),
                  TextSpan(
                    text: '. Please click the verification link in your email.',
                  ),
                ]
            )
        ),

        const SizedBox(height: TSizes.lg),

        /// Form
        Form(
            child: Padding(
              padding: const EdgeInsets.only(top: TSizes.spaceBtwSections - 4),
              child: Column(
                children: [

                  TElevatedButton(onTap: (){Get.to(() => const LoginScreen());}, buttonText: 'Open Email'),
                  const SizedBox(height: TSizes.lg),
                  Center(
                    child: TextButton(
                        onPressed: (){},
                        child: const Text('Resend verification link', style: TextStyle(fontSize: 13), )
                    ),
                  )
                ],
              ),
            )
        )
      ],
    );
  }
}