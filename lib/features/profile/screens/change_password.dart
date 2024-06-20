import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swappr/common/styles/spacing_styles.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';

import '../../../common/widgets/buttons/elevated_button.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/validators/validation.dart';
import '../../authentication/apis/api.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final formKey = GlobalKey<FormState>();
  String? _oldPass;
  String? _password;
  String? _confirmPass;
  bool _obscureOldPasswordText = true;
  bool _obscurePasswordText = true;
  bool _obscureConPasswordText = true;
  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: darkMode ? TColors.black.withOpacity(0.8) : TColors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){Get.back();},
          icon: const Icon(Icons.arrow_back_ios_sharp),
          style: IconButton.styleFrom(
              foregroundColor: TColors.primary,
              iconSize: TSizes.iconBackSize
          ),
          hoverColor: Colors.transparent,
        ),
        title: Text(
            'Change Password',
            style: Theme.of(context).textTheme.headlineLarge
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: TSizes.lg,),
                  /// Old password
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Old Password', style: Theme.of(context).textTheme.labelMedium,),
                      SizedBox(height: 10,),
                      SizedBox(
                        child: TextFormField(
                          style: Theme.of(context).textTheme.labelMedium,
                          onChanged: (pass) => _oldPass = pass,
                          validator: TValidator.validatePassword,
                          onSaved: (pass) {
                            _oldPass = pass as String;
                          },
                          obscureText: _obscureOldPasswordText,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscureOldPasswordText = !_obscureOldPasswordText;
                                  });
                                },
                                icon: Icon(_obscureOldPasswordText ? Iconsax.eye_slash : Iconsax.eye)
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),

                  /// Password
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('New Password', style: Theme.of(context).textTheme.labelMedium,),
                      SizedBox(height: 10,),
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
                      SizedBox(height: 10,),
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

                  const SizedBox(height: TSizes.spaceBtwSections * 2),

                  Padding(
                    padding: const EdgeInsets.only(top: TSizes.spaceBtwSections - 4),
                    child: Column(
                      children: [

                        TElevatedButton(
                            onTap: (){
                              if (_password == _confirmPass) {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  AuthService.instance.changePassword(
                                      currentPassword: _oldPass.toString(),
                                      newPassword: _password.toString(),
                                      onSuccess: () {
                                        setState(() {
                                          _oldPass = '';
                                          _password = '';
                                          _confirmPass = '';
                                        });
                                      }
                                  );
                                }
                                // if (formKey.currentState!.validate()) {
                                // }
                              }
                            },
                            buttonText: 'Proceed'
                        ),
                      ],
                    ),
                  )
                ],
              )
          ),
        )
      ),
    );
  }
}


// Container(
// height: THelperFunctions.screenHeight() * 0.7,
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// const Image(image: AssetImage(TImages.success)),
// Container(
// margin: const EdgeInsets.only(top: 40, bottom: 116),
// alignment: Alignment.center,
// child: Text(
// 'You have successfully reset your password',
// textAlign: TextAlign.center,
// style: Theme.of(context).textTheme.bodySmall,
// ),
// ),
// SizedBox(
// width: double.infinity,
// height: 55,
// child: TElevatedButton(
// onTap: () {
// AppNavigator.instance
//     .navigateToHandler(AUTH_LOGIN_SCREEN_ROUTE);
// },
// buttonText: 'Please, Log in ',
// ),
// ),
// ],
// ),
// )