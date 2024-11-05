import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/common/widgets/buttons/elevated_button.dart';
import 'package:pouch/utils/constants/sizes.dart';

import '../../../controllers/email_verification_controller.dart';

class EmailVerificationForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    EmailVerificationController controller = Get.find();
    return Form(
      key: controller.formKey,
      child: Obx(() => controller.showEmailVerifiedSuccess.isTrue
          ? _buildSuccessView(context)
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Enter the six digit pin sent to ',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 16),
              children: [
                TextSpan(
                  text: controller.email,
                  style: const TextStyle(fontWeight: TSizes.fontWeightLg),
                ),
              ],
            ),
          ),
          const SizedBox(height: TSizes.defaultSpace),
          _buildOtpInputField(),
          _buildConfirmButton(context),
        ],
      )
      ),
    );
  }

  Widget _buildOtpInputField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (index) {
        return _buildOtpBox(index);
      }),
    );
  }

  Widget _buildOtpBox(int index) {
    EmailVerificationController controller = Get.find();
    return SizedBox(
      width: 40,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller.otpControllers[index],
        focusNode: controller.focusNodes[index],
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.zero,
          counterText: '',
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          controller.handleOtpChanged(index, value);
          if (value.isEmpty && index > 0) {
            controller.focusNodes[index - 1].requestFocus();
          }
          controller.formKey.currentState?.validate();
        },
        validator: (value) => value!.isEmpty ? '' : null,
      ),
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    EmailVerificationController controller = Get.find();
    return Padding(
      padding: const EdgeInsets.only(top: TSizes.spaceBtwSections - 4),
      child: Column(
        children: [
          TElevatedButton(
            onTap: controller.handleVerifyOtp,
            buttonText: controller.isVerifying.isTrue ? 'Verifying...' : 'Confirm',
          ),
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
          )
        ],
      ),
    );
  }

  Widget _buildSuccessView(BuildContext context) {
    EmailVerificationController controller = Get.find();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: TSizes.defaultSpace),
        Image.asset('assets/logos/success-icon.png'),
        const SizedBox(height: TSizes.spaceBtwElements),
        Text(
          'Your email has been verified successfully. \n You\'ll be redirected shortly',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(height: 40),
        Text(
          'If not redirected, please, click the button below',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        TElevatedButton(onTap: controller.handleLogin, buttonText: 'Proceed')
      ],
    );
  }
}
