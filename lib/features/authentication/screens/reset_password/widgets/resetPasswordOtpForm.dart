import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pouch/features/authentication/screens/login/login.dart';

import '../../../../../common/widgets/buttons/elevated_button.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/reset_password_controller.dart';

class ResetPasswordOtpForm extends StatelessWidget {
  String email;
  ResetPasswordOtpForm({Key? key, required this.email}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
  final ResetPasswordOtpFormController controller = Get.find();
    return Form(
      key: formKey,
      child: Obx(() => controller.showEmailVerifiedSuccess.isFalse
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Enter a new password', style: Theme.of(context).textTheme.labelMedium),
          SizedBox(height: TSizes.spaceBtwElements),
          buildPasswordField(),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          buildConfirmPasswordField(),
          if (controller.canSendOtp.isTrue) buildOtpInput(),
          const SizedBox(height: TSizes.lg),
          buildActionButton(context),
        ],
      )
          : buildSuccessContent(context),
      ),
    );
  }

  Widget buildPasswordField() {
  final ResetPasswordOtpFormController controller = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Password', style: Get.textTheme.labelMedium),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: Get.textTheme.labelMedium,
          onChanged: (pass) => controller.password.value = pass,
          validator: TValidator.validatePassword,
          obscureText: controller.obscurePasswordText.value,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: controller.togglePasswordVisibility,
              icon: Icon(controller.obscurePasswordText.value ? Iconsax.eye_slash : Iconsax.eye),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildConfirmPasswordField() {
  final ResetPasswordOtpFormController controller = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Confirm Password', style: Get.textTheme.labelMedium),
        TextFormField(
          style: Get.textTheme.labelMedium,
          onChanged: (pass) {
            controller.confirmPass.value = pass;
            if (formKey.currentState!.validate() && controller.confirmPass.value == controller.password.value) {
              controller.canSendOtp.value = true;
            }
          },
          validator: (value) => TValidator.validateConfirmPassword(value, controller.password.value),
          obscureText: controller.obscureConPasswordText.value,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: controller.toggleConfirmPasswordVisibility,
              icon: Icon(controller.obscureConPasswordText.value ? Iconsax.eye_slash : Iconsax.eye),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildOtpInput() {
  final ResetPasswordOtpFormController controller = Get.find();
    return Column(
      children: [
        const SizedBox(height: TSizes.spaceBtwSections),
        RichText(
          text: TextSpan(
            text: 'Enter the six digit pin sent to ',
            style: Get.textTheme.labelSmall,
            children: <TextSpan>[
              TextSpan(text: controller.email, style: const TextStyle(fontWeight: TSizes.fontWeightLg)),
            ],
          ),
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
          onChanged: (val) => controller.otpCode.value = val,
          validator: TValidator.otpValidator,
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  Widget buildActionButton(BuildContext context) {
  final ResetPasswordOtpFormController controller = Get.find();
    return Padding(
      padding: const EdgeInsets.only(top: TSizes.spaceBtwSections - 4),
      child: Column(
        children: [
          TElevatedButton(
            onTap: controller.isPasswordResetting.value
                ? null
                : () {
              if (controller.password.value == controller.confirmPass.value) {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  controller.canSendOtp.value = true;
                  if (controller.otpCode.isNotEmpty) {
                    controller.resetPassword(
                        otp: controller.otpCode.value,
                        newPassword: controller.password.value,
                        onSuccess: () => controller.handleEmailVerificationSuccess(),
                    );
                  }
                }
              } else {
                controller.canSendOtp.value = false;
              }
            },
            buttonText: controller.isPasswordResetting.isTrue ? 'Confirming ...' : 'Confirm',
          ),
          const SizedBox(height: TSizes.lg),
          if (controller.canSendOtp.isTrue)
            Center(
              child: TextButton(
                onPressed: controller.canResendOtp.isFalse
                    ? null
                    : controller.handleSendEmailVerificationOTP,
                style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.fromLTRB(4, 0, 0, 0)),
                ),
                child: Text(
                  controller.canResendOtp.isFalse
                      ? 'Resend OTP in ${controller.formattedTime.value}s'
                      : 'Resend OTP',
                  style: const TextStyle(fontSize: 13),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildSuccessContent(BuildContext context) {
    return SizedBox(
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
              style: Get.textTheme.bodyMedium,
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: TElevatedButton(
              onTap: () {
                Get.to(() => LoginScreen());
              },
              buttonText: 'Please, Log in ',
            ),
          ),
        ],
      ),
    );
  }
}