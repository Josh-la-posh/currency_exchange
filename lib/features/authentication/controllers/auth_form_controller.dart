import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/authentication/controllers/auth_controller.dart';

import '../screens/email_verify/email_verify.dart';

class AuthFormController extends GetxController {
  final authController = Get.find<AuthController>();
  var isLoading = false.obs;
  var rememberMe = false.obs;
  var obscureOldPassword = true.obs;
  var obscurePassword = true.obs;
  var obscureConPassword = true.obs;
  var showErrorText = false.obs;
  var acceptTerms = false.obs;

  final postCode = ''.obs;
  final address = ''.obs;

  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNo = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController oldPassword = TextEditingController();
  final TextEditingController confirmPass = TextEditingController();

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    firstName.dispose();
    lastName.dispose();
    phoneNo.dispose();
    oldPassword.dispose();
    confirmPass.dispose();
    super.onClose();
  }

  Future<void> fetchAddressFromPostCode(String postCode) async {
    isLoading.value = true;
    try {
      final apiKey = 'AIzaSyBECoO_1MmoGnwVN5zXmjIbaFCIME11fRQ'; // Replace with your Google Maps API key
      final url = 'https://maps.googleapis.com/maps/api/geocode/json?address=$postCode&key=$apiKey';
      final response = await Dio().get(url);

      if (response.statusCode == 200) {
        final results = response.data['results'];
        if (results.isNotEmpty) {
          address.value = results[0]['formatted_address'];
        } else {
          address.value = 'No address found';
        }
      } else {
        address.value = 'Error: ${response.statusCode}';
      }
    } catch (error) {
      address.value = 'Failed to fetch address';
    } finally {
      isLoading.value = false;
    }
  }

  void showErrorMessage() {
    showErrorText.value = true;
    Timer(Duration(seconds: 3), () {
      showErrorText.value = false;
    });
  }

  // Toggle password visibility
  void toggleObscurePassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  // Toggle password visibility
  void toggleObscureOldPassword() {
    obscureOldPassword.value = !obscureOldPassword.value;
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

  // Submit the form and handle login
  Future<void> submitLoginForm({required GlobalKey<FormState> formKey}) async {
    if (validateForm(formKey)) {
      saveForm(formKey);
      try {
        isLoading(true);
        await authController.login(
          email: email.text.toString(),
          password: password.text.toString(),
          rememberMe: rememberMe.value,
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
        isLoading(false);
      }
    } else {
      Get.snackbar("Error", "Please fill in the form correctly", snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Submit the sign up form
  Future<void> submitSignUpForm({required GlobalKey<FormState> formKey}) async {
    if (validateForm(formKey)) {
      saveForm(formKey);
      try {
        isLoading(true);
        await authController.createAccount(
            firstName: firstName.text.toString(),
            lastName: lastName.text.toString(),
            email: email.text.toString(),
            phoneNumber: phoneNo.text.toString(),
            password: password.text.toString(),
            onSuccess: () {
              Get.to(() => EmailVerificationScreen(
                email: email.text.toString(),
                password: password.text.toString(),
              ));
            },
        );
      } catch (e) {
        Get.snackbar("Sign Up Error", e.toString(), snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent);
      } finally {
        isLoading(false);
      }
    } else {
      Get.snackbar("Error", "Please fill in the form correctly", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent);
    }
  }

  // Submit the address form
  Future<void> submitAddressForm({required GlobalKey<FormState> formKey}) async {
    if (validateForm(formKey)) {
      saveForm(formKey);
      try {
        isLoading(true);
        await authController.updateAddress(
          postCode: postCode.value,
          address: address.value,
          email: email.text.toString(),
          password: password.text.toString(),
        );
      } catch (e) {
        Get.snackbar("Sign Up Error", e.toString(), snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent);
      } finally {
        isLoading(false);
      }
    } else {
      Get.snackbar("Error", "Please fill in the form correctly", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent);
    }
  }

  // Submit the change password form
  Future<void> submitChangePasswordForm({required GlobalKey<FormState> formKey}) async {
    if (validateForm(formKey)) {
      saveForm(formKey);
      try {
        isLoading(true);
        await authController.changePassword(
            currentPassword: oldPassword.text,
            newPassword: password.text,
            onSuccess: () {
              Get.snackbar('Success', 'Password Changed Successfully!!!', backgroundColor: Colors.green);
              clearData();
            }
        );
      } catch (e) {
        Get.snackbar("Sign Up Error", e.toString(), snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent);
      } finally {
        isLoading(false);
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
    oldPassword.clear();
    confirmPass.clear();
  }
}
