import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pouch/common/widgets/buttons/elevated_button.dart';
import 'package:pouch/data/modules/app_navigator.dart';
import 'package:pouch/features/authentication/routes/names.dart';
import 'package:pouch/features/authentication/screens/login/login.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import 'package:pouch/utils/validators/validation.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/auth_form_controller.dart';

class SignUpForm extends StatelessWidget {
  AuthFormController authFormController = Get.put(AuthFormController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                _buildNameFields(context),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                _buildEmailField(context),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                _buildPhoneField(context),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                _buildPasswordField(context),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                _buildConfirmPasswordField(context),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                _buildTermsAndConditions(context),
                const SizedBox(height: TSizes.spaceBtwElements),
                _buildSubmitButton(context, formKey),
              ],
            ),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),
        _buildLoginLink(context),
      ],
    );
  }

  Widget _buildNameFields(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildTextField(
            context: context,
            label: 'First Name',
            controller: authFormController.firstName,
            validator: TValidator.emptyFieldValidator,
          ),
        ),
        const SizedBox(width: TSizes.lg),
        Expanded(
          child: _buildTextField(
            context: context,
            label: 'Last Name',
            controller: authFormController.lastName,
            validator: TValidator.emptyFieldValidator,
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return _buildTextField(
      context: context,
      label: 'Email',
      controller: authFormController.email,
      validator: TValidator.validateEmail,
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _buildPhoneField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Phone Number', style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: TSizes.sm),
        IntlPhoneField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          initialCountryCode: 'NG',
          style: Theme.of(context).textTheme.labelMedium,
          pickerDialogStyle: PickerDialogStyle(
            backgroundColor: TColors.secondaryBorder,
            countryNameStyle: Theme.of(context).textTheme.titleSmall,
            width: THelperFunctions.screenWidth(),
            padding: const EdgeInsets.symmetric(
              horizontal: TSizes.md,
              vertical: TSizes.defaultSpace * 2,
            ),
          ),
          onChanged: (value) {
            authFormController.phoneNo.text = value.completeNumber;
            print(authFormController.phoneNo.text);
          },
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return Obx(() => _buildTextField(
      context: context,
      label: 'Password',
      controller: authFormController.password,
      validator: TValidator.validatePassword,
      obscureText: authFormController.obscurePassword.value,
      suffixIcon: _buildToggleVisibilityIcon(
          obscureText: authFormController.obscurePassword.value,
          onPressed: () => authFormController.toggleObscurePassword()
      ),
    ));
  }

  Widget _buildConfirmPasswordField(BuildContext context) {
    return Obx(() => _buildTextField(
      controller: authFormController.confirmPass,
      context: context,
      label: 'Confirm Password',
      validator: (value) => TValidator.validateConfirmPassword(value, authFormController.password.text),
      obscureText: authFormController.obscureConPassword.value,
      suffixIcon: _buildToggleVisibilityIcon(
          obscureText: authFormController.obscureConPassword.value,
          onPressed: () => authFormController.toggleObscureConPassword()
      ),
    ));
  }

  Widget _buildTermsAndConditions(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(() => Checkbox(
          value: authFormController.acceptTerms.value,
          onChanged: (value) => authFormController.acceptTerms.value = !authFormController.acceptTerms.value,
        )),
        Expanded(
          child: Text(
            'I understand pouch Terms of Use',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context, GlobalKey<FormState> formKey) {
    return SizedBox(
      height: 48,
      child: Obx(() => TElevatedButton(
        onTap: authFormController.acceptTerms.value
            ? (authFormController.isCreatingAccount.value
            ? null
            : () => authFormController.submitSignUpForm(formKey: formKey))
            : null,
        buttonText: authFormController.isCreatingAccount.value
            ? 'Signing in ...'
            : 'Sign Up',
      )),
    );
  }

  Widget _buildLoginLink(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          Get.to(() => LoginScreen());
        },
        child: Text(
          'Already signed up? Log In',
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: TSizes.sm),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          style: Theme.of(context).textTheme.labelMedium,
          validator: validator,
          keyboardType: keyboardType,
          obscureText: obscureText,
          decoration: InputDecoration(suffixIcon: suffixIcon),
        ),
      ],
    );
  }

  Widget _buildToggleVisibilityIcon({
    required bool obscureText,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(obscureText ? Iconsax.eye_slash : Iconsax.eye),
    );
  }
}
