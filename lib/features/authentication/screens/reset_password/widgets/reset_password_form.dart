import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:pouch/features/authentication/apis/api.dart';
import 'package:pouch/features/authentication/models/password_model.dart';
import 'package:pouch/utils/constants/image_strings.dart';
import 'package:pouch/utils/validators/validation.dart';

import '../../../../../common/widgets/buttons/elevated_button.dart';
import '../../../../../data/modules/app_navigator.dart';
import '../../../../../data/provider/auth_provider.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/otp/otp.dart';
import '../../../routes/names.dart';
import '../../login/login.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final formKey = GlobalKey<FormState>();
  String? _email;

  var authProvider = Provider.of<AuthProvider>(
    AppNavigator.instance.navigatorKey.currentState as BuildContext);

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Please enter the email address associated to this account',
              style: Theme.of(context).textTheme.labelMedium,),

            const SizedBox(height: TSizes.lg),

            TextFormField(
              onChanged: (value) {
                _email = value;
              },
              validator: TValidator.validateEmail,
              onSaved: (value) {
                setState(() {
                  _email = value as String;
                });
              },
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: TSizes.lg),

            Padding(
              padding: const EdgeInsets.only(top: TSizes.spaceBtwSections - 4),
              child: Column(
                children: [

                  TElevatedButton(
                      onTap: (){
                        // if (formKey.currentState!.validate()) {
                        //   formKey.currentState!.save();
                        //   AuthService.instance.resetPassword(
                        //       email: _email as String,
                        //       onSuccess: () {
                        //         authProvider.saveResetPasswordDetails(
                        //           ResetPasswordModel(email: _email as String)
                        //         );
                        //         AppNavigator.instance.navigateToHandler(
                        //           AUTH_RESET_PASSWORD_OTP_SCREEN_ROUTE
                        //         );
                        //       }
                        //   );
                        // }
                        Get.to(() => const LoginScreen());
                      },
                      buttonText: 'Reset password'
                  ),
                  const SizedBox(height: TSizes.lg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'I remember now.',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      TextButton(
                          onPressed: () {
                            AppNavigator.instance.navigateToHandler(AUTH_LOGIN_SCREEN_ROUTE);
                          },
                          style: const ButtonStyle(
                            padding: MaterialStatePropertyAll(
                              EdgeInsets.fromLTRB(4, 0, 0, 0),),
                          ),
                          child: const Text(
                            'Sign me in',
                            style: TextStyle(fontSize: 13), )
                      )
                    ]
                  )
                ],
              ),
            )
          ],
        )
    );
  }
}