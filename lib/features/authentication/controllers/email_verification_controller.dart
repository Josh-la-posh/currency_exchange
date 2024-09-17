import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/utils/otp/otp.dart';

import 'auth_controller.dart';

class EmailVerificationController extends GetxController {
  final isLoading = false.obs;
  final authController = Get.find<AuthController>();
  final String email;
  final String password;
  final VoidCallback? onSuccess;
  final formKey = GlobalKey<FormState>();
  final List<TextEditingController> otpControllers =
  List.generate(6, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());
  RxString otpCode = ''.obs;
  RxBool showEmailVerifiedSuccess = false.obs;
  RxBool canResendOtp = false.obs;
  RxString formattedTime = '0'.obs;
  late OtpTimer otpTimer;

  EmailVerificationController(
      {required this.email, required this.password, this.onSuccess});

  @override
  void onInit() {
    super.onInit();
    otpTimer = OtpTimer(
      durationInSeconds: 120,
      onTimerFinish: () {
        formattedTime.value = '0';
        canResendOtp.value = true;
      },
      getTime: (time) {
        formattedTime.value = time;
      },
    );
    handleSendEmailVerificationOTP();
    _setupFocusListeners();
  }

  @override
  void onClose() {
    otpTimer.stopTimer();
    otpControllers.forEach((controller) => controller.dispose());
    focusNodes.forEach((node) => node.dispose());
    super.onClose();
  }

  // Validate the form
  bool validateForm(formKey) {
    return formKey.currentState?.validate() ?? false;
  }

  // Save form data
  void saveForm(formKey) {
    formKey.currentState?.save();
  }

  void handleSendEmailVerificationOTP() {
    authController.emailVerificationOtp(
      email: email,
      onSuccess: () {
        otpTimer.startTimer();
        canResendOtp.value = false;
      },
      onFailure: () {
        canResendOtp.value = true;
      },
    );
  }

  void _setupFocusListeners() {
    for (int i = 0; i < focusNodes.length - 1; i++) {
      otpControllers[i].addListener(() {
        if (otpControllers[i].text.length == 1) {
          focusNodes[i + 1].requestFocus();
        }
      });
    }
  }

  void handleOtpChanged() {
    otpCode.value = otpControllers.map((controller) => controller.text).join();
  }

  void handleEmailVerificationSuccess() {
    showEmailVerifiedSuccess.value = true;
    onSuccess?.call();
    Future.delayed(const Duration(seconds: 2), handleLogin);
  }

  void handleVerifyOtp() {
    if (validateForm(formKey)) {
      saveForm(formKey);
      try {
        isLoading(true);
        authController.verifyEmailOtp(
          otpCode: otpCode.value,
          onSuccess: handleEmailVerificationSuccess,
        );
      } catch (e) {
        Get.snackbar("Invalid OTP", e.toString(), snackPosition: SnackPosition.BOTTOM);
      } finally {
        isLoading(false);
      }
    } else {
      Get.snackbar("Error", "Please fill in the form correctly", snackPosition: SnackPosition.BOTTOM);
    }
  }

  void handleLogin() {
    if (showEmailVerifiedSuccess.isTrue) {
      authController.login(
          email: email,
          password: password,
          rememberMe: true,
          handleEmailNotVerified: (){}
      );
    }
  }
}
