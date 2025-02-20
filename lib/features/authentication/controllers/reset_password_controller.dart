import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/otp/otp.dart';
import '../../../utils/responses/handleApiError.dart';
import '../../../utils/shared/error_dialog_response.dart';
import '../apis/api.dart';

class ResetPasswordOtpFormController extends GetxController {
  final CancelToken requestCancelToken = CancelToken();
  var otpCode = ''.obs;
  var password = ''.obs;
  var confirmPass = ''.obs;
  var obscurePasswordText = true.obs;
  var obscureConPasswordText = true.obs;
  var canSendOtp = false.obs;
  var showEmailVerifiedSuccess = false.obs;
  OtpTimer? otpTimer;
  var formattedTime = '0'.obs;
  var canResendOtp = false.obs;
  var isPasswordResetting = false.obs;

  final bool sendEmailOtpOnBuild;
  final String email;
  final VoidCallback? onSuccess;

  ResetPasswordOtpFormController({required this.sendEmailOtpOnBuild, required this.email, this.onSuccess}) {
    otpTimer = OtpTimer(
        durationInSeconds: 120,
        onTimerFinish: () {
          formattedTime.value = '0';
          canResendOtp.value = true;
        },
        getTime: (time) {
          formattedTime.value = time;
        }
    );
    if (sendEmailOtpOnBuild) {
      handleSendEmailVerificationOTP();
    } else {
      otpTimer?.startTimer();
    }
  }

  Future<void> generateOtp({
    required String email,
    required VoidCallback onSuccess,
    required VoidCallback onFailure
  }) async {
    try {
      final response = await AuthService.instance.sendEmailOtpCode(
          data: {"email": email.toLowerCase().trim()},
          onFailure: () {});
      if (response != null) {
        onSuccess();
      }
    } catch (err) {
      showErrorAlertHelper(errorMessage: err.toString());
    } finally {
    }
  }

  Future<void> resetPassword({required String otp, required String newPassword, required VoidCallback onSuccess}) async {
    try {
      isPasswordResetting(true);
      final response = await AuthService.instance.resetPassword(
          data: {
            'otp': int.parse(otp),
            'newPassword': newPassword
          },
          onFailure: () {isPasswordResetting(false);}
      );
      if (response != null) {
        onSuccess();
        Get.snackbar('Success', 'Password reset successful', backgroundColor: Colors.green);
      }
    } catch (err) {
      showErrorAlertHelper(errorMessage: err.toString());
    } finally {
      isPasswordResetting(false);
    }
  }

  void handleSendEmailVerificationOTP() {
    generateOtp(
        email: email,
        onSuccess: () {
          Get.snackbar('', 'Otp sent', backgroundColor: Colors.green);
          otpTimer?.startTimer();
          canResendOtp.value = false;
        },
        onFailure: () => canResendOtp.value = true
    );
  }

  void handleEmailVerificationSuccess() {
    if (onSuccess == null) {
      showEmailVerifiedSuccess.value = true;
    } else {
      onSuccess!();
    }
  }

  void togglePasswordVisibility() {
    obscurePasswordText.value = !obscurePasswordText.value;
  }

  void toggleConfirmPasswordVisibility() {
    obscureConPasswordText.value = !obscureConPasswordText.value;
  }

  @override
  void onClose() {
    otpTimer?.stopTimer();
    super.onClose();
  }

  @override
  void dispose() {
    requestCancelToken.cancel('Component disposed');
    super.dispose();
  }
}