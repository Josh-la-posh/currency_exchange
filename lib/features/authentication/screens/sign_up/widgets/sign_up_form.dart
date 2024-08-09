import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:pouch/common/widgets/buttons/elevated_button.dart';
import 'package:pouch/data/modules/app_navigator.dart';
import 'package:pouch/features/authentication/routes/names.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import 'package:pouch/utils/validators/validation.dart';
import '../../../../../common/widgets/country_picker/country_picker.dart';
import '../../../../../data/provider/auth_provider.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../apis/api.dart';
import '../../email_verify/email_verify.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final formKey = GlobalKey<FormState>();
  bool obscurePasswordText = true;
  bool obscureConPasswordText = true;

  // Form input values
  String firstName = '';
  String lastName = '';
  String email = '';
  String phoneNo = '';
  String password = '';
  String confirmPass = '';
  bool acceptTerms = false;

  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthProvider>(
        AppNavigator.instance.navigatorKey.currentContext as BuildContext,
        listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);

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
                _buildTermsAndConditions(),
                const SizedBox(height: TSizes.spaceBtwElements),
                _buildSubmitButton(context),
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
            onChanged: (value) => firstName = value,
            validator: TValidator.validateName,
          ),
        ),
        const SizedBox(width: TSizes.lg),
        Expanded(
          child: _buildTextField(
            context: context,
            label: 'Last Name',
            onChanged: (value) => lastName = value,
            validator: TValidator.validateName,
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return _buildTextField(
      context: context,
      label: 'Email',
      onChanged: (value) => email = value,
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
          onChanged: (value) => phoneNo = value.completeNumber,
          onSaved: (value) => phoneNo = value?.completeNumber ?? '',
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return _buildTextField(
      context: context,
      label: 'Password',
      onChanged: (value) => password = value,
      validator: TValidator.validatePassword,
      obscureText: obscurePasswordText,
      suffixIcon: _buildToggleVisibilityIcon(
        obscureText: obscurePasswordText,
        onPressed: () {
          setState(() {
            obscurePasswordText = !obscurePasswordText;
          });
        },
      ),
    );
  }

  Widget _buildConfirmPasswordField(BuildContext context) {
    return _buildTextField(
      context: context,
      label: 'Confirm Password',
      onChanged: (value) => confirmPass = value,
      validator: (value) => TValidator.validateConfirmPassword(value, password),
      obscureText: obscureConPasswordText,
      suffixIcon: _buildToggleVisibilityIcon(
        obscureText: obscureConPasswordText,
        onPressed: () {
          setState(() {
            obscureConPasswordText = !obscureConPasswordText;
          });
        },
      ),
    );
  }

  Widget _buildTermsAndConditions() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          value: acceptTerms,
          onChanged: (value) {
            setState(() {
              acceptTerms = value ?? false;
            });
          },
        ),
        Expanded(
          child: Text(
            'I understand pouch Terms of Use',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return SizedBox(
      height: 48,
      child: acceptTerms
          ? TElevatedButton(
        onTap: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            AuthService.instance.createAccount(
              firstName: firstName,
              lastName: lastName,
              email: email,
              phoneNumber: phoneNo,
              password: password,
              onSuccess: () {
                Get.to(() => EmailVerificationScreen(
                  email: email,
                  password: password,
                ));
              },
            );
          }
        },
        buttonText: 'Sign Up',
      )
          : ElevatedButton(
        onPressed: null,
        child: Center(child: Text('Sign Up')),
      ),
    );
  }

  Widget _buildLoginLink(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          AppNavigator.instance.navigateToHandler(AUTH_LOGIN_SCREEN_ROUTE);
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
        SizedBox(
          child: TextFormField(
            style: Theme.of(context).textTheme.labelMedium,
            onChanged: onChanged,
            validator: validator,
            keyboardType: keyboardType,
            obscureText: obscureText,
            decoration: InputDecoration(suffixIcon: suffixIcon),
          ),
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
