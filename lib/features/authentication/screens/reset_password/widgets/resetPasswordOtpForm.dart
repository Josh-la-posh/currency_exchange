import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pouch/features/authentication/apis/api.dart';
import 'package:pouch/utils/constants/image_strings.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import 'package:pouch/utils/validators/validation.dart';

import '../../../../../common/widgets/buttons/elevated_button.dart';
import '../../../../../data/modules/app_navigator.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/otp/otp.dart';
import '../../../routes/names.dart';
import '../../login/login.dart';

class ResetPasswordOtpForm extends StatefulWidget {
  final bool sendEmailOtpOnBuild;
  final String email;
  final VoidCallback? onSuccess;
  const ResetPasswordOtpForm({
    super.key,
    this.sendEmailOtpOnBuild = false,
    required this.email,
    this.onSuccess = null
  });

  @override
  State<ResetPasswordOtpForm> createState() => _ResetPasswordOtpFormState();
}

class _ResetPasswordOtpFormState extends State<ResetPasswordOtpForm> {
  final formKey = GlobalKey<FormState>();
  String? _otpCode;
  String? _password;
  String? _confirmPass;
  bool _obscurePasswordText = true;
  bool _obscureConPasswordText = true;
  bool _canSendOtp = false;
  bool showEmailVerifiedSuccess = false;
  OtpTimer? _otpTimer;
  String _formattedTime = '0';
  bool canResendOtp = false;
  void handleEmailVerificationSuccess() {
    if (widget.onSuccess == null) {
      setState(() {
        showEmailVerifiedSuccess = true;
      });
    } else {
      widget.onSuccess!();
    }
  }

  @override
  void initState() {
    super.initState();
    _otpTimer = OtpTimer(
        durationInSeconds: 120,
        onTimerFinish: () {
          setState(() {
            _formattedTime = '0';
            canResendOtp = true;
          });
        },
        getTime: (time) {
          setState(() {
            _formattedTime = time;
          });
        }
    );
    if (widget.sendEmailOtpOnBuild) {
      handleSendEmailVerificationOTP();
    } else {
      _otpTimer!.startTimer();
    }
  }

  @override
  void dispose() {
    _otpTimer!.stopTimer();
    super.dispose();
  }

  void handleSendEmailVerificationOTP() {
    AuthService.instance.generateOtp(
        email: widget.email,
        onSuccess: () {
          _otpTimer!.startTimer();
          setState(() {
            canResendOtp = false;
          });
        },
        onFailure: () {
          setState(() {
            canResendOtp = true;
          });
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: showEmailVerifiedSuccess == false
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Password
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter a new password',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                SizedBox(height: TSizes.spaceBtwElements,),
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
            if (_canSendOtp == true)
            Column(
              children: [
                const SizedBox(height: TSizes.spaceBtwSections),
                RichText(
                    text: TextSpan(
                        text: 'Enter the six digit pin sent to ',
                        style: Theme.of(context).textTheme.labelSmall,
                        children: <TextSpan> [
                          TextSpan(
                              text: widget.email,
                              style: TextStyle(fontWeight: TSizes.fontWeightLg)
                          ),
                        ]
                    )
                ),
                const SizedBox(height: TSizes.lg),
                TextFormField(
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    letterSpacing: 20,
                    color: Color(0xFF6B6F80),
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none,
                  ),
                  onChanged: (val) => _otpCode = val,
                  validator: TValidator.otpValidator,
                  onSaved: (value) {
                    setState(() {
                      _otpCode = value as String;
                    });
                  },
                  keyboardType: TextInputType.number,
                ),
              ],
            ),

            const SizedBox(height: TSizes.lg),

            Padding(
              padding: const EdgeInsets.only(top: TSizes.spaceBtwSections - 4),
              child: Column(
                children: [

                  TElevatedButton(
                      onTap: (){
                        if (_password == _confirmPass) {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            canResendOtp == false ? null : handleSendEmailVerificationOTP;
                            setState(() {
                              _canSendOtp = true;
                            });
                            if ( _otpCode != '') {
                              AuthService.instance.resetPassword(
                                  otp: int.parse(_otpCode!),
                                  newPassword: _password.toString(),
                                  onSuccess: handleEmailVerificationSuccess
                              );
                            }
                          }
                          // if (formKey.currentState!.validate()) {
                          // }
                        } else {
                          formKey.currentState!.validate();
                          setState(() {
                            _canSendOtp = false;
                          });
                        }
                      },
                      buttonText: _canSendOtp ? 'Confirm' : 'Proceed'
                  ),
                  const SizedBox(height: TSizes.lg),
                  if (_canSendOtp)
                  Center(
                    child: TextButton(
                        onPressed: canResendOtp == false ? null : handleSendEmailVerificationOTP,
                        style: const ButtonStyle(
                          padding: MaterialStatePropertyAll(
                            EdgeInsets.fromLTRB(4, 0, 0, 0),),
                        ),
                        child: Text(
                          canResendOtp == false
                              ? 'Resend OTP in ${_formattedTime}s'
                              : 'Resend OTP',
                          style: const TextStyle(fontSize: 13), )
                    ),
                  )
                ],
              ),
            )
          ],
        )
            : Container(
          height: THelperFunctions.screenHeight() * 0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: AssetImage(TImages.success)),
              Container(
                margin: const EdgeInsets.only(top: 40, bottom: 116),
                alignment: Alignment.center,
                child: Text(
                  'You have successfully reset your password',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: TElevatedButton(
                  onTap: () {
                    AppNavigator.instance
                        .navigateToHandler(AUTH_LOGIN_SCREEN_ROUTE);
                  },
                  buttonText: 'Please, Log in ',
                ),
              ),
                        ],
                      ),
            )
    );
  }
}