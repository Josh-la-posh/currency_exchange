import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/data/modules/storage_session_controller.dart';
import '../../../utils/shared/error_dialog_response.dart';
import '../apis/api.dart';
import '../screens/email_verify/email_verify.dart';

class RegistrationFormController extends GetxController {
final UserSessionController userSessionController = Get.find();
final CancelToken requestCancelToken = CancelToken();
  var isCreatingAccount = false.obs;
  var rememberMe = false.obs;
  var obscurePassword = true.obs;
  var obscureConPassword = true.obs;
  var acceptTerms = false.obs;
  var firstName = ''.obs;
  var lastName = ''.obs;
  var email = ''.obs;
  var phoneNo = ''.obs;
  var password = ''.obs;
  var confirmPass = ''.obs;

  @override
  void onInit() {
    clearData();
    super.onInit();
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
      if (phoneNo.value.length > 7) {
        try {
          isCreatingAccount(true);
          userSessionController.clearRememberMeHandler();
          final response = await AuthService.instance.createAccount(
            data: {
              'firstName': firstName.value.trim().toString(),
              'lastName': lastName.value.trim().toString(),
              'email': email.value.trim().toString(),
              'phoneNumber': phoneNo.value.trim().toString(),
              'password': password.value.trim().toString(),
            },
            onFailure: () {
              isCreatingAccount(false);
            }
          );
          print('The response is coming as: $response');
          if (response != null) {
            Get.to(() => EmailVerificationScreen(
              email: email.value.trim().toString(),
              password: password.value.trim().toString(),
            ));
          }
        } catch (e) {
          showErrorAlertHelper(errorMessage: e.toString());
          isCreatingAccount(false);
        } finally {
          isCreatingAccount(false);
        }
      } else {
        Get.snackbar("Error", "Please fill in the phone number field correctly", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent);
      }
    } else {
      Get.snackbar("Error", "Please fill in the form correctly", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent);
    }
  }

  void clearData() {
    firstName.value = '';
    lastName.value = '';
    email.value = '';
    phoneNo.value = '';
    password.value = '';
    confirmPass.value = '';
  }

  @override
  void dispose() {
    requestCancelToken.cancel('Component disposed');
    super.dispose();
  }
}
