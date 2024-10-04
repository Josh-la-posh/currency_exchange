import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pouch/utils/validators/validation.dart';

import '../../../../../common/widgets/buttons/elevated_button.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/auth_form_controller.dart';

class ForgetPasswordForm extends StatelessWidget {
  const ForgetPasswordForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AuthFormController authFormController = Get.put(AuthFormController());
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
        child: Column(
          children: [
            /// Email
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Email', style: Theme.of(context).textTheme.labelMedium,),
                TextFormField(
                  controller: authFormController.email,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: Theme.of(context).textTheme.labelMedium,
                  validator: TValidator.validateEmail,
                  decoration: const InputDecoration(),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            Obx(() => TElevatedButton(
              onTap: authFormController.isForgotPasswordFormSubmitting.value ? null : () => authFormController.submitForgotPasswordForm(formKey: formKey),
              buttonText: authFormController.isForgotPasswordFormSubmitting.value ? 'Submitting' : 'Submit',
            )),
          ],
        )
    );
  }
}