import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/responses/handleApiError.dart';
import '../../../utils/shared/error_dialog_response.dart';
import '../apis/api.dart';
import '../screens/reset_password/reset_password_otp.dart';

class ForgotPasswordFormController extends GetxController {
  final CancelToken requestCancelToken = CancelToken();
  var isPasswordChanging = false.obs;
  var isForgotPasswordFormSubmitting = false.obs;
  var obscureOldPassword = true.obs;
  var obscurePassword = true.obs;
  var obscureConPassword = true.obs;
  var email = ''.obs;

  @override
  void onInit() {
    email.value = '';
    super.onInit();
  }

  // Validate the form
  bool validateForm(formKey) {
    return formKey.currentState?.validate() ?? false;
  }

  // Save form data
  void saveForm(formKey) {
    formKey.currentState?.save();
  }

  // Submit the form and handle forgot password
  Future<void> submitForgotPasswordForm({required GlobalKey<FormState> formKey}) async {
    if (validateForm(formKey)) {
      saveForm(formKey);
      try {
        isForgotPasswordFormSubmitting(true);
        final response = await AuthService.instance.sendEmailOtpCode(
            data: {"email": email.value.toLowerCase().trim()},
            onFailure: () {
              isForgotPasswordFormSubmitting(false);
            }
        );
        if (response != null) {
          Get.to(() => ResetPasswordOtpScreen(email: email.value));
        }
      } catch (e) {
        showErrorAlertHelper(errorMessage: e.toString());
      } finally {
        isForgotPasswordFormSubmitting(false);
      }
    } else {
      Get.snackbar("Error", "Please fill in the form correctly", snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void dispose() {
    requestCancelToken.cancel('Component disposed');
    super.dispose();
  }
}
