import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/authentication/controllers/forgot_password_controller.dart';
import 'package:pouch/utils/validators/validation.dart';

import '../../../../../common/widgets/buttons/elevated_button.dart';
import '../../../../../utils/constants/sizes.dart';

class ForgetPasswordForm extends StatelessWidget {
  const ForgetPasswordForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ForgotPasswordFormController forgotPasswordFormController = Get.put(ForgotPasswordFormController());
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Email', style: Theme.of(context).textTheme.labelMedium,),
                TextFormField(
                  onChanged: (val) => forgotPasswordFormController.email.value = val,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: Theme.of(context).textTheme.labelMedium,
                  validator: TValidator.validateEmail,
                  decoration: const InputDecoration(),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            Obx(() => TElevatedButton(
              onTap: forgotPasswordFormController.isForgotPasswordFormSubmitting.value ? null : () => forgotPasswordFormController.submitForgotPasswordForm(formKey: formKey),
              buttonText: forgotPasswordFormController.isForgotPasswordFormSubmitting.value ? 'Submitting' : 'Submit',
            )),
          ],
        )
    );
  }
}