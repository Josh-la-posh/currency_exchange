import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:swappr/features/authentication/apis/api.dart';
import 'package:swappr/utils/constants/image_strings.dart';
import 'package:swappr/utils/helpers/helper_functions.dart';
import 'package:swappr/utils/validators/validation.dart';

import '../../../../../common/widgets/buttons/elevated_button.dart';
import '../../../../../data/modules/app_navigator.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/otp/otp.dart';
import '../../../routes/names.dart';
import '../../login/login.dart';

class EmailVerificationForm extends StatefulWidget {
  final bool sendEmailOtpOnBuild;
  final String email;
  final VoidCallback? onSuccess;
  const EmailVerificationForm({
    super.key,
    this.sendEmailOtpOnBuild = false,
    required this.email,
    this.onSuccess = null
  });

  @override
  State<EmailVerificationForm> createState() => _EmailVerificationFormState();
}

class _EmailVerificationFormState extends State<EmailVerificationForm> {
  final formKey = GlobalKey<FormState>();
  String? _otpCode;
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
          RichText(
              text: TextSpan(
                  text: 'Enter the six digit pin sent to ',
                  style: Theme.of(context).textTheme.labelMedium,
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

          const SizedBox(height: TSizes.lg),

          Padding(
            padding: const EdgeInsets.only(top: TSizes.spaceBtwSections - 4),
            child: Column(
              children: [

                TElevatedButton(
                    onTap: (){
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        AuthService.instance.verifyEmailOtp(
                            otpCode: _otpCode as String,
                            onSuccess: handleEmailVerificationSuccess
                        );
                      }
                      // Get.to(() => const LoginScreen());
                      },
                    buttonText: 'Confirm'
                ),
                const SizedBox(height: TSizes.lg),
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
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: THelperFunctions.screenHeight() * 0.1),
          Image(image: AssetImage(TImages.success)),
          SizedBox(height: TSizes.spaceBtwElements,),
          Text(
            'Your email has been verified successfully',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          SizedBox(height: THelperFunctions.screenHeight() * 0.12),
          TElevatedButton(
            onTap: () {
              AppNavigator.instance
                  .navigateToHandler(AUTH_LOGIN_SCREEN_ROUTE);
            },
            buttonText: 'Please, Log in ',
          ),
        ],
      )
    );
  }
}