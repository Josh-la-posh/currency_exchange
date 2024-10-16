import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/common/widgets/buttons/elevated_button.dart';
import 'package:pouch/utils/constants/sizes.dart';

import '../../../controllers/email_verification_controller.dart';

class EmailVerificationForm extends StatelessWidget {
  final String email;
  final String password;

  EmailVerificationForm({
    Key? key,
    required this.email,
    required this.password,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EmailVerificationController controller = Get.put(EmailVerificationController(
      email: email,
      password: password,
    ));

    return Obx(
          () => Form(
        key: controller.formKey,
        child: controller.showEmailVerifiedSuccess.isTrue
            ? _buildSuccessView(context, controller)
            : _buildOtpForm(context, controller),
      ),
    );
  }

  Widget _buildOtpForm(BuildContext context, EmailVerificationController controller) {
    return Column(
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
        _buildOtpInputField(controller),
        _buildConfirmButton(context, controller),
        _buildResendOtpButton(controller),
      ],
    );
  }

  Widget _buildOtpInputField(EmailVerificationController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (index) {
        return _buildOtpBox(index, controller);
      }),
    );
  }

  Widget _buildOtpBox(int index, EmailVerificationController controller) {
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
          controller.handleOtpChanged();
          if (value.isEmpty && index > 0) {
            controller.focusNodes[index - 1].requestFocus();
          }
          controller.formKey.currentState?.validate();
        },
        validator: (value) => value!.isEmpty ? '' : null,
      ),
    );
  }

  Widget _buildConfirmButton(BuildContext context, EmailVerificationController controller) {
    return Obx(() => Padding(
      padding: const EdgeInsets.only(top: TSizes.spaceBtwSections - 4),
      child: TElevatedButton(
        onTap: controller.otpControllers.length == 6
            ? (controller.isVerifying.value
            ? null
            : controller.handleVerifyOtp)
            : null,
        buttonText: controller.isVerifying.value ? 'Verifying...' : 'Confirm',
      ),
    ));
  }

  Widget _buildResendOtpButton(EmailVerificationController controller) {
    return Center(
      child: TextButton(
        onPressed: controller.canResendOtp.isTrue
            ? controller.handleSendEmailVerificationOTP
            : null,
        style: const ButtonStyle(
          padding: MaterialStatePropertyAll(EdgeInsets.fromLTRB(4, 0, 0, 0)),
        ),
        child: Text(
          controller.canResendOtp.isTrue
              ? 'Resend OTP'
              : 'Resend OTP in ${controller.formattedTime.value}s',
          style: const TextStyle(fontSize: 13),
        ),
      ),
    );
  }

  Widget _buildSuccessView(
      BuildContext context, EmailVerificationController controller) {
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
      ],
    );
  }
}
