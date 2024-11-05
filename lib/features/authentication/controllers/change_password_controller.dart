import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/utils/responses/handleApiError.dart';

import '../../../utils/shared/error_dialog_response.dart';
import '../apis/api.dart';

class ChangePasswordController extends GetxController {
  var isPasswordChanging = false.obs;
  var obscureOldPassword = true.obs;
  var obscurePassword = true.obs;
  var obscureConPassword = true.obs;

  final TextEditingController password = TextEditingController();
  final TextEditingController oldPassword = TextEditingController();
  final TextEditingController confirmPass = TextEditingController();

  // @override
  // void onInit() {
  //   password.clear();
  //   oldPassword.clear();
  //   confirmPass.clear();
  //   super.onInit();
  // }

  @override
  void onClose() {
    password.dispose();
    oldPassword.dispose();
    confirmPass.dispose();
    super.onClose();
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
        // isPasswordChanging.value = true;
        final response = await AuthService.instance.changePassword({
          'currentPassword': oldPassword.text,
          'newPassword': password.text,
        });

        if (response?.statusCode == 200 || response?.statusCode == 201) {
          Get.snackbar('Success', 'Password Changed Successfully!!!', backgroundColor: Colors.green);
        } else {
          print('Failed to change password. Please try again.');
        }
      } catch (e) {
        print('Failed to change password. Please try again.');
        showErrorAlertHelper(errorMessage: handleApiFormatError(e));
      } finally {
        isPasswordChanging.value = false;
      }
    } else {
      Get.snackbar("Error", "Please fill in the form correctly", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent);
    }
  }


  void clearData() {
    password.clear();
    oldPassword.clear();
    confirmPass.clear();
  }
}
