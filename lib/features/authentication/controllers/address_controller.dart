import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/authentication/controllers/auth_controller.dart';

import '../apis/address_service.dart';

class AddressFormController extends GetxController {
  AuthController authController = Get.find();
  final addressService = AddressService();
  var isAddressFetching = false.obs;
  var showErrorText = false.obs;
  var showAddressError = false.obs;
  var isUpdatingAddress = false.obs;
  var isAddressEdited = false.obs;

  final TextEditingController generatedAddress = TextEditingController();
  final TextEditingController postCode = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void onInit() {
    generatedAddress.clear();
    postCode.clear();
    email.clear();
    password.clear();
    super.onInit();
  }

  @override
  void onClose() {
    generatedAddress.dispose();
    postCode.dispose();
    email.dispose();
    password.dispose();
    super.onClose();
  }

  void fetchAddress(String postCode) async {
    final address = await addressService.getAddressFromPostalCode(postCode); // Example postal code
    if (address != null) {
      generatedAddress.text = address;
      showErrorText.value = false;
      print('Address: ${generatedAddress.text}');
    } else {
      generatedAddress.text = '';
    }
  }

  void showErrorMessage() {
    showErrorText.value = true;
    Timer(Duration(seconds: 3), () {
      showErrorText.value = false;
    });
  }



  // Validate the form
  bool validateForm(formKey) {
    return formKey.currentState?.validate() ?? false;
  }

  // Save form data
  void saveForm(formKey) {
    formKey.currentState?.save();
  }

  // Submit the address form
  Future<void> submitAddressForm({required GlobalKey<FormState> formKey}) async {
    if (validateForm(formKey)) {
      saveForm(formKey);
      try {
        isUpdatingAddress(true);
        await authController.updateAddress(
          postCode: postCode.text,
          address: generatedAddress.text,
          email: email.text,
          password: password.text,
        );
      } catch (e) {
        Get.snackbar("Sign Up Error", e.toString(), snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent);
      } finally {
        isUpdatingAddress(false);
      }
    } else {
      Get.snackbar("Error", "Please fill in the form correctly", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent);
    }
  }

  void clearData() {
    generatedAddress.clear();
    postCode.clear();
    email.clear();
    password.clear();
  }
}
