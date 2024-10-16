import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pouch/features/authentication/controllers/auth_controller.dart';
import 'package:pouch/features/authentication/controllers/auth_form_controller.dart';
import 'package:pouch/common/widgets/buttons/elevated_button.dart';
import 'package:pouch/features/authentication/screens/reset_password/forgot_password.dart';
import 'package:pouch/features/authentication/screens/sign_up/sign_up.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/validators/validation.dart';

class LoginForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    AuthFormController authFormController = Get.put(AuthFormController());
    AuthController controller = Get.find();
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Column(
        children: [
          // Email
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Email', style: Theme.of(context).textTheme.labelMedium),
              TextFormField(
                controller: authFormController.email,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: Theme.of(context).textTheme.labelMedium,
                validator: TValidator.validateEmail,
                decoration: const InputDecoration(),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Password
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Password', style: Theme.of(context).textTheme.labelMedium),
              Obx(() => TextFormField(
                controller: authFormController.password,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: Theme.of(context).textTheme.labelMedium,
                validator: TValidator.validateLoginPassword,
                obscureText: authFormController.obscurePassword.value,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () => authFormController.toggleObscurePassword(),
                    icon: Icon(authFormController.obscurePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye),
                  ),
                ),
              )),
            ],
          ),
          const SizedBox(height: TSizes.xs),

          // Forgot Password
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Get.to(() => ForgotPasswordScreen());
              },
              child: Text('Forgot password?',
                  style: Theme.of(context).textTheme.labelMedium),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          // Sign In Button
          Obx(() => TElevatedButton(
            onTap: authFormController.isLoggingIn.value ? null : () => authFormController.submitLoginForm(formKey: formKey),
            // onTap: () => controller.fetchAddress(),
            buttonText: authFormController.isLoggingIn.value ? 'Logging in' : 'Log In',
          )),
          const SizedBox(height: TSizes.md),

          // Sign Up Option
          Center(
            child: TextButton(
              onPressed: () {
                Get.to(() => CreateAccountScreen());
              },
              child: Text('No account yet? Sign Up',
                  style: Theme.of(context).textTheme.labelMedium),
            ),
          ),
        ],
      ),
    );
  }
}
