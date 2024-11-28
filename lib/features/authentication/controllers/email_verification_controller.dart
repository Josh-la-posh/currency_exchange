import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/authentication/controllers/auth_form_controller.dart';
import 'package:pouch/utils/otp/otp.dart';

import '../../../utils/responses/handleApiError.dart';
import '../../../utils/shared/error_dialog_response.dart';
import '../apis/api.dart';

class EmailVerificationController extends GetxController {
  final AuthFormController authFormController = Get.put(AuthFormController());
  final formKey = GlobalKey<FormState>();
  final List<TextEditingController> otpControllers =
  List.generate(6, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());
  OtpTimer? otpTimer;
  var otpCode = ''.obs;
  var showEmailVerifiedSuccess = false.obs;
  var canResendOtp = false.obs;
  var formattedTime = '0'.obs;
  var isVerifying = false.obs;

  final bool sendEmailOtpOnBuild;
  final String email;
  final String password;
  final VoidCallback? onSuccess;

  EmailVerificationController(
      {required this.sendEmailOtpOnBuild, required this.email, required this.password, this.onSuccess}) {
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
    if (sendEmailOtpOnBuild) {
      handleSendEmailVerificationOTP();
    } else {
      otpTimer?.startTimer();
    }
  }

  @override
  void onInit() {
    super.onInit();
    _setupFocusListeners();
  }

  @override
  void onClose() {
    otpTimer?.stopTimer();
    otpControllers.forEach((controller) => controller.dispose());
    focusNodes.forEach((node) => node.dispose());
    super.onClose();
  }

  Future<void> emailVerificationOtp({
    required String email,
    required VoidCallback onSuccess,
    VoidCallback? onFailure
  }) async {
    try {
      Get.snackbar('Sending Otp', 'We are sending an a 6 digit code to $email');
      final response = await AuthService.instance.emailVerificationOtp({"email": email.toLowerCase().trim()});
      if (response.statusCode == 200 || response.statusCode == 201) {
        onSuccess();
      }
    } catch (err) {
      if (onFailure != null) {
        onFailure();
      }
      showErrorAlertHelper(errorMessage: handleApiFormatError(err));
    } finally {
      Get.closeAllSnackbars();
    }
  }

  Future<void> verifyEmailOtp({required String otpCode,required VoidCallback onSuccess}) async {
    final intOtp = int.parse(otpCode);
    try {
      final response = await AuthService.instance.confirmEmailOtp({"emailOtp": intOtp});
      if (response.statusCode == 200 || response.statusCode == 201) {
        onSuccess();
      }
    } catch (err) {
      showErrorAlertHelper(errorMessage: handleApiFormatError(err));
    }
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
    emailVerificationOtp(
      email: email,
      onSuccess: () {
        otpTimer?.startTimer();
        canResendOtp.value = false;
      },
      onFailure: () => canResendOtp.value = true,
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

  // void handleOtpChanged() {
  //   otpCode.value = otpControllers.map((controller) => controller.text).join();
  // }

  void handleOtpChanged(int index, String value) {
    if (value.length > 1) {
      print('The value is: $value');
      for (int i = 0; i < value.length && i < 6; i++) {
        otpControllers[i].text = value[i];
        if (i < focusNodes.length - 1) {
          focusNodes[i + 1].requestFocus();
        }
      }
      FocusScope.of(Get.context!).requestFocus(focusNodes[5]);
    } else {
      if (value.isEmpty && index > 0) {
        focusNodes[index - 1].requestFocus();
      }
    }
    otpCode.value = otpControllers.map((controller) => controller.text).join();
    print('the value is: ${otpCode.value}');
  }


  void handleEmailVerificationSuccess() {
    showEmailVerifiedSuccess.value = true;
    onSuccess?.call();
    Future.delayed(const Duration(seconds: 2), handleSuccess);
  }

  void handleVerifyOtp() {
    if (isVerifying.isTrue) {
      return;
    }
    if (validateForm(formKey)) {
      saveForm(formKey);
      try {
        isVerifying(true);
        verifyEmailOtp(
          otpCode: otpCode.value,
          onSuccess: handleEmailVerificationSuccess,
        );
      } catch (e) {
        Get.snackbar("Invalid OTP", e.toString(), snackPosition: SnackPosition.BOTTOM);
      } finally {
        isVerifying(false);
      }
    } else {
      Get.snackbar("Error", "Please fill in the form correctly", snackPosition: SnackPosition.BOTTOM);
    }
  }


  void handleSuccess() {
    if (showEmailVerifiedSuccess.isTrue) {
      authFormController.login(
          email: email.toLowerCase().trim(),
          password: password,
          rememberMe: true,
          handleEmailNotVerified: () {}
      );
    }
  }
}
