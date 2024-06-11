// import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:swappr/common/widgets/buttons/elevated_button.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:swappr/data/modules/app_navigator.dart';
import 'package:swappr/features/authentication/apis/api.dart';
import 'package:swappr/features/authentication/routes/names.dart';
import 'package:swappr/features/authentication/screens/email_verify/email_verify.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';
import 'package:swappr/utils/validators/validation.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../login/login.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final formKey = GlobalKey<FormState>();
  bool _obscurePasswordText = true;
  bool _obscureConPasswordText = true;

  // form input values
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _phoneNo = '';
  String _country = '';
  String _address = '';
  String _state = '';
  String _password = '';
  String _confirmPass = '';

  // user password score
  int? _userPasswordScore;

  // form validation for password
  bool? _passwordHasEightChars;
  bool? _passwordHasUppercaseChar;
  bool? _passwordHasLowercaseChar;
  bool? _passwordHasNumberChar;
  bool? _passwordHasSpecialChar;

  // Regex patterns for each requirement
  final lengthRegex = RegExp(r'.{8,}');
  final uppercaseRegex = RegExp(r'[A-Z]');
  final lowercaseRegex = RegExp(r'[a-z]');
  final numberRegex = RegExp(r'[0-9]');
  final specialCharRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

  void passwordValidatorOnChanged(String password) {
    final hasLength = lengthRegex.hasMatch(password);
    final hasUppercase = uppercaseRegex.hasMatch(password);
    final hasLowercase = lowercaseRegex.hasMatch(password);
    final hasNumber = numberRegex.hasMatch(password);
    final hasSpecialChar = specialCharRegex.hasMatch(password);
    final userPasswordScore = THelperFunctions.addUpBooleans([
      hasLength,
      hasUppercase,
      hasLowercase,
      hasNumber,
      hasSpecialChar,
    ]);

    setState(() {
      _passwordHasEightChars = hasLength;
      _passwordHasUppercaseChar = hasUppercase;
      _passwordHasLowercaseChar = hasLowercase;
      _passwordHasNumberChar = hasNumber;
      _passwordHasSpecialChar = hasSpecialChar;
      _userPasswordScore = userPasswordScore;
    });
  }

  String? passwordValidatorOnSaved(String? password) {
    final hasLength = lengthRegex.hasMatch(password ?? '');
    final hasUppercase = uppercaseRegex.hasMatch(password ?? '');
    final hasLowercase = lowercaseRegex.hasMatch(password ?? '');
    final hasNumber = numberRegex.hasMatch(password ?? '');
    final hasSpecialChar = specialCharRegex.hasMatch(password ?? '');
    final userPasswordScore = THelperFunctions.addUpBooleans([
      hasLength,
      hasUppercase,
      hasLowercase,
      hasNumber,
      hasSpecialChar,
    ]);

    setState(() {
      _passwordHasEightChars = hasLength;
      _passwordHasUppercaseChar = hasUppercase;
      _passwordHasLowercaseChar = hasLowercase;
      _passwordHasNumberChar = hasNumber;
      _passwordHasSpecialChar = hasSpecialChar;
      _userPasswordScore = userPasswordScore;
    });

    if (hasLength &&
        hasUppercase &&
        hasLowercase &&
        hasNumber &&
        hasSpecialChar) {
      return null;
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: formKey,
            child: Column(
              children: [
                /// First Name
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('First Name', style: Theme.of(context).textTheme.labelMedium,),
                    SizedBox(
                      child: TextFormField(
                        style: Theme.of(context).textTheme.labelMedium,
                        onChanged: (value) => _firstName = value,
                        validator: TValidator.validateName,
                        onSaved: (value) {
                          _firstName = value as String;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                /// Last Name
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Last Name', style: Theme.of(context).textTheme.labelMedium,),
                    SizedBox(
                      child: TextFormField(
                        style: Theme.of(context).textTheme.labelMedium,
                        onChanged: (value) => _lastName = value,
                        validator: TValidator.validateName,
                        onSaved: (value) {
                          _lastName = value as String;
                        },
                      ),
                    )
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                /// Email
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email', style: Theme.of(context).textTheme.labelMedium,),
                    SizedBox(
                      child: TextFormField(
                        style: Theme.of(context).textTheme.labelMedium,
                        onChanged: (value) => _email = value,
                        validator: TValidator.validateEmail,
                        onSaved: (email) {
                          _email = email as String;
                        },
                      ),
                    )
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                /// Phone No
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Phone Number', style: Theme.of(context).textTheme.labelMedium,),
                    IntlPhoneField(
                      initialCountryCode: 'NG',
                      style: Theme.of(context).textTheme.labelMedium,
                      onChanged: (value) => _phoneNo = value.completeNumber,
                      onSaved: (value) {
                        // print('I get $_phoneNo');
                        _phoneNo = value!.completeNumber;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                /// Country
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Country', style: Theme.of(context).textTheme.labelMedium,),
                    SizedBox(
                      height: TSizes.textInputFieldHeight,
                      child: TextFormField(
                        style: Theme.of(context).textTheme.labelMedium,
                        onChanged: (val) => _country = val,
                        onSaved: (val) {
                          _country = val as String;
                        },
                      ),
                    )
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                /// Address
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Address', style: Theme.of(context).textTheme.labelMedium,),
                    SizedBox(
                      child: TextFormField(
                        style: Theme.of(context).textTheme.labelMedium,
                        onChanged: (value) => _address = value,
                        onSaved: (value) {
                          _address = value as String;
                        },
                      ),
                    )
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                /// State
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('State', style: Theme.of(context).textTheme.labelMedium,),
                    SizedBox(
                      child: TextFormField(
                        style: Theme.of(context).textTheme.labelMedium,
                        onChanged: (value) => _state = value,
                        validator: TValidator.validateName,
                        onSaved: (value) {
                          _state = value as String;
                        },
                      ),
                    )
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                /// Password
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Password', style: Theme.of(context).textTheme.labelMedium,),
                    SizedBox(
                      child: TextFormField(
                        style: Theme.of(context).textTheme.labelMedium,
                        onChanged: (pass) => _password = pass,
                        validator: TValidator.validatePassword,
                        onSaved: (pass) {
                          _password = pass as String;
                        },
                        obscureText: _obscurePasswordText,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscurePasswordText = !_obscurePasswordText;
                                });
                              },
                              icon: Icon(_obscurePasswordText ? Iconsax.eye_slash : Iconsax.eye)
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Confirm Password', style: Theme.of(context).textTheme.labelMedium,),
                    SizedBox(
                      child: TextFormField(
                        style: Theme.of(context).textTheme.labelMedium,
                        onChanged: (pass) => _confirmPass = pass,
                        validator: (value) => TValidator.validateConfirmPassword(value, _password),
                        obscureText: _obscureConPasswordText,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureConPasswordText = !_obscureConPasswordText;
                                });
                              },
                              icon: Icon(_obscureConPasswordText ? Iconsax.eye_slash : Iconsax.eye)
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                SizedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(value: true, onChanged: (value){}),
                      Text(
                        'I understand Swappr Terms of Use',
                        style: Theme.of(context).textTheme.labelMedium,
                      )
                    ],
                  ),
                ),

                const SizedBox(height: TSizes.spaceBtwElements),

                TElevatedButton(onTap: (){
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();

                    AuthService.instance.createAccount(
                        firstName: _firstName,
                        lastName: _lastName,
                        email: _email,
                        phoneNumber: _phoneNo,
                        country: _country,
                        address: _address,
                        state: _state,
                        password: _password,
                        onSuccess: () {
                          Get.to(() => EmailVerificationScreen(email: _email));
                        });
                    // Get.to(() => EmailVerificationScreen(email: _email));
                  }
                }, buttonText: 'Sign Up')
              ],
            )
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),
        Center(
          child: TextButton(
              onPressed: (){
                AppNavigator.instance.navigateToHandler(AUTH_LOGIN_SCREEN_ROUTE);
                // Get.to(() => const LoginScreen());
                },
              child: Text('Already signed up? Log In', style: Theme.of(context).textTheme.labelMedium,)
          ),
        )
      ],
    );
  }
}