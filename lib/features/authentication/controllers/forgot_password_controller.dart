import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/authentication/controllers/auth_controller.dart';
import '../screens/reset_password/reset_password_otp.dart';

class ForgotPasswordFormController extends GetxController {
  AuthController authController = Get.find();
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
        await authController.generateOtp(
            email: email.text.toString(),
            onSuccess: () {
              Get.to(() => ResetPasswordOtpScreen(email: email.text));
            },
            onFailure: (){}
        );
      } catch (e) {
        Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
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
