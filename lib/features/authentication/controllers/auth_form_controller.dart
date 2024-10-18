import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/authentication/controllers/auth_controller.dart';
import '../screens/email_verify/email_verify.dart';

class AuthFormController extends GetxController {
  AuthController authController = Get.find();
  var isLoggingIn = false.obs;
  var rememberMe = false.obs;
  var obscurePassword = true.obs;

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void onInit() {
    email.clear();
    password.clear();
    super.onInit();
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }

  // Toggle password visibility
  void toggleObscurePassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  // Validate the form
  bool validateForm(formKey) {
    return formKey.currentState?.validate() ?? false;
  }

  // Save form data
  void saveForm(formKey) {
    formKey.currentState?.save();
  }

  // Submit the form and handle login
  Future<void> submitLoginForm({required GlobalKey<FormState> formKey}) async {
    if (validateForm(formKey)) {
      saveForm(formKey);
      try {
        isLoggingIn(true);
        await authController.login(
          email: email.text.toString(),
          password: password.text.toString(),
          rememberMe: true,
          handleEmailNotVerified: () {
            Get.to(EmailVerificationScreen(
              email: email.text.toString(),
              password: password.text.toString(),
            ));
          },
        );
      } catch (e) {
        Get.snackbar("Login Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
      } finally {
        isLoggingIn(false);
      }
    } else {
      Get.snackbar("Error", "Please fill in the form correctly", snackPosition: SnackPosition.BOTTOM);
    }
  }

  void clearData() {
    email.clear();
    password.clear();
  }
}
