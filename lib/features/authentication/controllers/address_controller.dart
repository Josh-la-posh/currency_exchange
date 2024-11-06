import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/authentication/controllers/auth_controller.dart';

import '../../../data/firebase/firebase_api.dart';
import '../../../utils/responses/handleApiError.dart';
import '../apis/address_service.dart';
import '../apis/api.dart';

class AddressFormController extends GetxController {
  AuthController authController = Get.find();
  final addressService = AddressService();
  var isAddressFetching = false.obs;
  var showErrorText = false.obs;
  var showAddressError = false.obs;
  var isUpdatingAddress = false.obs;
  var isAddressEdited = false.obs;
  List<String> countryList = ['Nigeria', 'America', 'Europe', 'Others'];
  var selectedRegion = 'America'.obs;

  final TextEditingController address = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController country = TextEditingController();
  final TextEditingController postCode = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void onInit() {
    address.clear();
    city.clear();
    state.clear();
    country.clear();
    postCode.clear();
    email.clear();
    password.clear();
    super.onInit();
  }

  @override
  void onClose() {
    city.dispose();
    state.dispose();
    country.dispose();
    address.dispose();
    postCode.dispose();
    email.dispose();
    password.dispose();
    super.onClose();
  }

  void fetchAddress(String postCode) async {
    List? address = await addressService.getAddressFromPostalCode(postCode);
    if (address != null) {
      print('Thew resulted: $address');
      address.forEach((val) {
        if ((val['types'].contains('locality') && val['types'].contains('political')) || val['types'].contains('postal_town')) {
          city.text = val['long_name'];
        } else if (val['types'].contains('administrative_area_level_1') && val['types'].contains('political')) {
          state.text = val['long_name'];
        } else if (val['types'].contains('country') && val['types'].contains('political')) {
          country.text = val['long_name'];
        }
      });
      showErrorText.value = false;
      print('Address: ${city.text} and ${state.text}');
    } else {
      city.text = '';
      state.text = '';
    }
  }

  void updateSelectedRegion(val) {
    selectedRegion.value = val;
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
        final response = await AuthService.instance.updateAddress({
          'postCode': postCode.text,
          'address':
              '${address.text}, ${city.text}, ${state.text}. ${country.text}',
          'email': email.text,
          'password': password.text,
        });
        if (response.statusCode == 200 || response.statusCode == 201) {
          await FirebaseApi().registerDeviceToken();
          await authController.login(
            email: email.text.toLowerCase().trim(),
            password: password.text,
            rememberMe: true,
            handleEmailNotVerified: (){},
          );
        }
      } catch (e) {
        Get.snackbar('Error', handleApiFormatError(e), backgroundColor: Colors.red);
      } finally {
        isUpdatingAddress(false);
      }
    } else {
      Get.snackbar("Error", "Please fill in the form correctly", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent);
    }
  }

  void clearData() {
    address.clear();
    city.clear();
    state.clear();
    country.clear();
    postCode.clear();
    email.clear();
    password.clear();
  }
}
