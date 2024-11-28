import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pouch/common/widgets/buttons/elevated_button.dart';
import 'package:pouch/features/authentication/screens/reset_password/forgot_password.dart';
import 'package:pouch/features/authentication/screens/sign_up/sign_up.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/auth_form_controller.dart';

class LoginForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final AuthFormController authFormController = Get.put(AuthFormController());
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: Theme.of(context).textTheme.labelMedium,
                onChanged: (val) => authFormController.email.value = val,
                onSaved: (val) => authFormController.email.value = val.toString(),
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: Theme.of(context).textTheme.labelMedium,
                validator: TValidator.validateLoginPassword,
                obscureText: authFormController.obscurePassword.value,
                onChanged: (val) => authFormController.password.value = val,
                onSaved: (val) => authFormController.password.value = val.toString(),
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
          Row(
            children: [
              Expanded(
                child: Obx(() => TElevatedButton(
                  onTap: authFormController.isLoggingIn.value ? null : () => authFormController.submitLoginForm(formKey: formKey),
                  buttonText: authFormController.isLoggingIn.value ? 'Logging in' : 'Log In',
                )),
              ),
              SizedBox(width: 10,),
              SizedBox(
                height: 48,
                width: 70,
                child: ElevatedButton(
                  onPressed: authFormController.loginWithBiometric,
                  child: Icon(Icons.fingerprint_outlined, size:  30,),
                ),
              )
            ],
          ),
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
