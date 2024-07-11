import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pouch/features/authentication/apis/api.dart';
import 'package:pouch/features/authentication/screens/reset_password/reset_password_otp.dart';
import 'package:pouch/utils/validators/validation.dart';

import '../../../../../common/widgets/buttons/elevated_button.dart';
import '../../../../../utils/constants/sizes.dart';

class ForgetPasswordForm extends StatelessWidget {
  const ForgetPasswordForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String? _email;

    return Form(
      key: formKey,
        child: Column(
          children: [
            /// Email
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Email', style: Theme.of(context).textTheme.labelMedium,),
                SizedBox(
                  child: TextFormField(
                    style: Theme.of(context).textTheme.labelMedium,
                    onChanged: (val) => _email = val,
                    validator: TValidator.validateEmail,
                    onSaved: (val) {
                      _email = val as String;
                    },
                  ),
                )
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            TElevatedButton(
                onTap: (){
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    AuthService.instance.generateOtp(
                        email: _email.toString(), onSuccess: (){
                          Get.to(() => ResetPasswordOtpScreen(email: _email as String,));
                        }
                        );
                  }
                  },
                buttonText: 'Submit')
          ],
        )
    );
  }
}