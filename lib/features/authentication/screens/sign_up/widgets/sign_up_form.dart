import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pouch/common/widgets/buttons/elevated_button.dart';
import 'package:pouch/features/authentication/controllers/registration_form_controller.dart';
import 'package:pouch/features/authentication/screens/login/login.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import 'package:pouch/utils/validators/validation.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class SignUpForm extends StatelessWidget {
  final RegistrationFormController registrationFormController = Get.put(RegistrationFormController());
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
            onChanged: (val) => registrationFormController.firstName.value = val,
            validator: TValidator.emptyFieldValidator,
          ),
        ),
        const SizedBox(width: TSizes.lg),
        Expanded(
          child: _buildTextField(
            context: context,
            label: 'Last Name',
            onChanged: (val) => registrationFormController.lastName.value = val,
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
      onChanged: (val) => registrationFormController.email.value = val,
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
            registrationFormController.phoneNo.value = value.completeNumber;
            print('The v: ${value.number.length}');
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
      onChanged: (val) => registrationFormController.password.value = val,
      validator: TValidator.validatePassword,
      obscureText: registrationFormController.obscurePassword.value,
      suffixIcon: _buildToggleVisibilityIcon(
          obscureText: registrationFormController.obscurePassword.value,
          onPressed: () => registrationFormController.toggleObscurePassword()
      ),
    ));
  }

  Widget _buildConfirmPasswordField(BuildContext context) {
    return Obx(() => _buildTextField(
      onChanged: (val) => registrationFormController.confirmPass.value = val,
      context: context,
      label: 'Confirm Password',
      validator: (value) => TValidator.validateConfirmPassword(value, registrationFormController.password.value),
      obscureText: registrationFormController.obscureConPassword.value,
      suffixIcon: _buildToggleVisibilityIcon(
          obscureText: registrationFormController.obscureConPassword.value,
          onPressed: () => registrationFormController.toggleObscureConPassword()
      ),
    ));
  }

  Widget _buildTermsAndConditions(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(() => Transform.scale(
          scale: 1.2,
          child: Checkbox(
            value: registrationFormController.acceptTerms.value,
            onChanged: (value) => registrationFormController.acceptTerms.value = !registrationFormController.acceptTerms.value,
          ),
        )),
        Expanded(
          child: InkWell(
            splashColor: Colors.transparent,
            onTap: () => registrationFormController.acceptTerms.value = !registrationFormController.acceptTerms.value,
            child: Text(
              'I understand pouch Terms of Use',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context, GlobalKey<FormState> formKey) {
    return SizedBox(
      height: 48,
      child: Obx(() => TElevatedButton(
        onTap: registrationFormController.acceptTerms.value
            ? (registrationFormController.isCreatingAccount.value
            ? null
            : () => registrationFormController.submitSignUpForm(formKey: formKey))
            : null,
        buttonText: registrationFormController.isCreatingAccount.value
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
    required Function(String) onChanged,
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
          onChanged: onChanged,
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
