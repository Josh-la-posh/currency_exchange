import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/responses/handleApiError.dart';
import '../../../utils/shared/error_dialog_response.dart';
import '../apis/api.dart';
import '../screens/reset_password/reset_password_otp.dart';

class ForgotPasswordFormController extends GetxController {
  var isPasswordChanging = false.obs;
  var isForgotPasswordFormSubmitting = false.obs;
  var obscureOldPassword = true.obs;
  var obscurePassword = true.obs;
  var obscureConPassword = true.obs;

  final TextEditingController email = TextEditingController();

  @override
  void onInit() {
    email.clear();
    super.onInit();
  }

  @override
  void onClose() {
    email.dispose();
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

  // Submit the form and handle forgot password
  Future<void> submitForgotPasswordForm({required GlobalKey<FormState> formKey}) async {
    if (validateForm(formKey)) {
      saveForm(formKey);
      try {
        isForgotPasswordFormSubmitting(true);
        final response = await AuthService.instance.sendEmailOtpCode({"email": email.text.toLowerCase().trim()});
        if (response.statusCode == 200 || response.statusCode == 201) {
          Get.to(() => ResetPasswordOtpScreen(email: email.text));
        }
      } catch (e) {
        showErrorAlertHelper(errorMessage: handleApiFormatError(e));
      } finally {
        isForgotPasswordFormSubmitting(false);
      }
    } else {
      Get.snackbar("Error", "Please fill in the form correctly", snackPosition: SnackPosition.BOTTOM);
    }
  }

  void clearData() {
    email.clear();
  }
}
