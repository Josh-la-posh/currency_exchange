import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../common/widgets/buttons/elevated_button.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../email_verify/email_verify.dart';

class ForgetPasswordForm extends StatelessWidget {
  const ForgetPasswordForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
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
                      // suffixIcon: Icon(Icons.)
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            TElevatedButton(onTap: (){Get.to(() => const EmailVerificationScreen());}, buttonText: 'Submit')
          ],
        )
    );
  }
}