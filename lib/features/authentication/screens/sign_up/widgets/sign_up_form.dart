import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:provider/provider.dart';
import 'package:swappr/common/widgets/buttons/elevated_button.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:swappr/data/modules/app_navigator.dart';
import 'package:swappr/features/authentication/routes/names.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';
import 'package:swappr/utils/validators/validation.dart';
import '../../../../../common/widgets/country_picker/country_picker.dart';
import '../../../../../data/provider/auth_provider.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../apis/api.dart';
import '../../email_verify/email_verify.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {

  var authProvider = Provider.of<AuthProvider>(
      AppNavigator.instance.navigatorKey.currentContext as BuildContext,
      listen: false);

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
  bool _acceptTerms = false;



  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Form(
          key: formKey,
            child: Column(
              children: [
                Row(
                  children: [

                    /// First Name
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('First Name', style: Theme.of(context).textTheme.labelMedium,),
                          const SizedBox(height: TSizes.sm,),
                          SizedBox(
                            child: TextFormField(
                              style: Theme.of(context).textTheme.labelMedium,
                              onChanged: (value) => _firstName = value,
                              validator: TValidator.validateName,
                              onSaved: (value) {
                                _firstName = value as String;
                              },
                              keyboardType: TextInputType.name,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: TSizes.md),

                    /// Last Name
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Last Name', style: Theme.of(context).textTheme.labelMedium,),
                          const SizedBox(height: TSizes.sm,),
                          SizedBox(
                            child: TextFormField(
                              style: Theme.of(context).textTheme.labelMedium,
                              onChanged: (value) => _lastName = value,
                              validator: TValidator.validateName,
                              onSaved: (value) {
                                _lastName = value as String;
                              },
                              keyboardType: TextInputType.name,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                /// Email
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email', style: Theme.of(context).textTheme.labelMedium,),
                    const SizedBox(height: TSizes.sm,),
                    SizedBox(
                      child: TextFormField(
                        style: Theme.of(context).textTheme.labelMedium,
                        onChanged: (value) => _email = value,
                        validator: TValidator.validateEmail,
                        onSaved: (email) {
                          _email = email as String;
                        },
                        keyboardType: TextInputType.emailAddress,
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
                    const SizedBox(height: TSizes.sm,),
                    IntlPhoneField(
                      initialCountryCode: 'NG',
                      style: Theme.of(context).textTheme.labelMedium,
                      pickerDialogStyle: PickerDialogStyle(
                        backgroundColor: TColors.secondaryBorder,
                        countryNameStyle: Theme.of(context).textTheme.titleSmall,
                        width: THelperFunctions.screenWidth(),
                        padding: const EdgeInsets.symmetric(horizontal: TSizes.md, vertical: TSizes.defaultSpace * 2),
                      ),
                      onChanged: (value) => _phoneNo = value.completeNumber,
                      onSaved: (value) {
                        // print('I get $_phoneNo');
                        _phoneNo = value!.completeNumber;
                      },
                      keyboardType: TextInputType.phone,
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                // CountryStateCityPicker(
                //   country: countryCont,
                //   state: stateCont,
                //   city: cityCont,
                //   dialogColor: TColors.secondaryBorder,
                //   textFieldDecoration: InputDecoration(
                //     contentPadding: const EdgeInsets.all(15),
                //     fillColor: darkMode ? TColors.timeLineBorder : TColors.textFieldBackground,
                //     hintStyle: Theme.of(context).textTheme.labelMedium,
                //     suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                //     suffixIconColor: darkMode ? Colors.white: TColors.textPrimary.withOpacity(0.8),
                //     // isDense: true,
                //   ),
                // ),
                // const SizedBox(height: TSizes.spaceBtwInputFields),
                //
                // /// Address
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Text('Address', style: Theme.of(context).textTheme.labelMedium,),
                //     const SizedBox(height: TSizes.sm,),
                //     SizedBox(
                //       child: TextFormField(
                //         validator: TValidator.emptyFieldValidator,
                //         style: Theme.of(context).textTheme.labelMedium,
                //         onChanged: (value) => _address = value,
                //         onSaved: (value) {
                //           _address = value as String;
                //         },
                //       ),
                //     )
                //   ],
                // ),
                // const SizedBox(height: TSizes.spaceBtwInputFields),

                /// Password
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Password', style: Theme.of(context).textTheme.labelMedium,),
                    const SizedBox(height: TSizes.sm,),
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
                    const SizedBox(height: TSizes.sm,),
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
                      Checkbox(
                          value: _acceptTerms,
                          onChanged: (value){
                            setState(() {
                              _acceptTerms = !_acceptTerms!;
                            });
                          }
                      ),
                      Text(
                        'I understand Swappr Terms of Use',
                        style: Theme.of(context).textTheme.labelMedium,
                      )
                    ],
                  ),
                ),

                const SizedBox(height: TSizes.spaceBtwElements),
                _acceptTerms == false
                    ? SizedBox(
                  height: 48,
                  child: ElevatedButton(
                      onPressed: null,
                    child: Center(child: Text('Sign Up'),),
                  ),
                )
                    : TElevatedButton(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        AuthService.instance.createAccount(
                            firstName: _firstName,
                            lastName: _lastName,
                            email: _email,
                            phoneNumber: _phoneNo,
                            country: '',
                            address: '',
                            state: '',
                            password: _password,
                            onSuccess: () {
                              Get.to(() => EmailVerificationScreen(email: _email, password: _password,));
                            });
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