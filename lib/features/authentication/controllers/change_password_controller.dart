import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/shared/error_dialog_response.dart';
import '../apis/api.dart';

class ChangePasswordController extends GetxController {
  final CancelToken requestCancelToken = CancelToken();
  var isPasswordChanging = false.obs;
  var obscureOldPassword = true.obs;
  var obscurePassword = true.obs;
  var obscureConPassword = true.obs;
  var password = ''.obs;
  var oldPassword = ''.obs;
  var confirmPass = ''.obs;

  @override
  void onInit() {
    password.value = '';
    oldPassword.value = '';
    confirmPass.value = '';
    super.onInit();
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

  // Submit the change password form
  Future<void> submitChangePasswordForm({required GlobalKey<FormState> formKey}) async {
    if (validateForm(formKey)) {
      saveForm(formKey);
      try {
        isPasswordChanging.value = true;
        await AuthService.instance.changePassword(
            data: {
              'currentPassword': oldPassword.value.trim(),
              'newPassword': password.value.trim(),
            },
          onFailure: () {
            isPasswordChanging(false);
          }
        );

        Get.snackbar('Success', 'Password Changed Successfully!!!', backgroundColor: Colors.green);
        clearData();
      } catch (e) {
        print('Failed to change password. Please try again.');
        showErrorAlertHelper(errorMessage: e.toString());
      } finally {
        isPasswordChanging.value = false;
      }
    } else {
      Get.snackbar("Error", "Please fill in the form correctly", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent);
    }
  }

  void clearData() {
    password.value = '';
    oldPassword.value = '';
    confirmPass.value = '';
  }

  @override
  void dispose() {
    requestCancelToken.cancel('Component disposed');
    super.dispose();
  }
}
