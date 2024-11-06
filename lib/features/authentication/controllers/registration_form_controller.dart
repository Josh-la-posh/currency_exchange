import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/data/modules/storage_session_controller.dart';
import '../../../utils/responses/handleApiError.dart';
import '../../../utils/shared/error_dialog_response.dart';
import '../apis/api.dart';
import '../screens/email_verify/email_verify.dart';

class RegistrationFormController extends GetxController {
  UserSessionController userSessionController = Get.find();
  var isCreatingAccount = false.obs;
  var rememberMe = false.obs;
  var obscurePassword = true.obs;
  var obscureConPassword = true.obs;
  var acceptTerms = false.obs;

  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNo = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPass = TextEditingController();

  @override
  void onInit() {
    userSessionController.clearRememberMeHandler();
    clearData();
    super.onInit();
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    firstName.dispose();
    lastName.dispose();
    phoneNo.dispose();
    confirmPass.dispose();
    super.onClose();
  }

  // Toggle password visibility
  void toggleObscurePassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  // Toggle confirm password visibility
  void toggleObscureConPassword() {
    obscureConPassword.value = !obscureConPassword.value;
  }

  // Validate the form
  bool validateForm(formKey) {
    return formKey.currentState?.validate() ?? false;
  }

  // Save form data
  void saveForm(formKey) {
    formKey.currentState?.save();
  }

  // Submit the sign up form
  Future<void> submitSignUpForm({required GlobalKey<FormState> formKey}) async {
    if (validateForm(formKey)) {
      saveForm(formKey);
      try {
        isCreatingAccount(true);
        final response = await AuthService.instance.createAccount({
          'firstName': firstName.text.toString(),
          'lastName': lastName.text.toString(),
          'email': email.text.toString(),
          'phoneNumber': phoneNo.text.toString(),
          'password': password.text.toString(),
        });
        if (response.statusCode == 200 || response.statusCode == 201) {
          Get.to(() => EmailVerificationScreen(
            email: email.text.toString(),
            password: password.text.toString(),
          ));
        }
      } catch (e) {
        showErrorAlertHelper(errorMessage: handleApiFormatError(e));
      } finally {
        isCreatingAccount(false);
      }
    } else {
      Get.snackbar("Error", "Please fill in the form correctly", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent);
    }
  }

  void clearData() {
    email.clear();
    password.clear();
    firstName.clear();
    lastName.clear();
    phoneNo.clear();
    confirmPass.clear();
  }
}
