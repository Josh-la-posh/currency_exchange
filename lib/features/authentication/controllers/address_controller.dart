import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/authentication/controllers/auth_form_controller.dart';
import 'package:pouch/utils/layouts/navigation_menu.dart';

import '../../../data/firebase/firebase_api.dart';
import '../../../data/modules/storage_session_controller.dart';
import '../../../utils/responses/handleApiError.dart';
import '../apis/address_service.dart';
import '../apis/api.dart';

class AddressFormController extends GetxController {
  UserSessionController userSessionController = Get.find<UserSessionController>();
  final AuthFormController authFormController = Get.put(AuthFormController());
  final addressService = AddressService();

  var isAddressFetching = false.obs;
  var showErrorText = false.obs;
  var showAddressError = false.obs;
  var isUpdatingAddress = false.obs;
  var isAddressEdited = false.obs;
  var isCountrySelected = false.obs;
  var cityIsEmpty = false.obs;

  List<String> countryList = ['Africa', 'America', 'Europe', 'Others'];
  var selectedRegion = 'America'.obs;

  var email = ''.obs;
  var password = ''.obs;
  var country = ''.obs;
  var postCode = ''.obs;
  var city = ''.obs;
  var state = ''.obs;

  // final TextEditingController address = TextEditingController();
  late TextEditingController address;


  @override
  void onInit() {
    postCode.value = '';
    address = TextEditingController();
    country.value = '';
    city.value = '';
    state.value = '';
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    address.dispose();
  }

  void fetchAddress(String postCode) async {

    List? address = await addressService.getAddressFromPostalCode(postCode);
    if (address != null) {
      address.forEach((val) {
        if ((val['types'].contains('locality') && val['types'].contains('political')) || val['types'].contains('postal_town')) {
          city.value = val['long_name'];
        } else if (val['types'].contains('administrative_area_level_1') && val['types'].contains('political')) {
          state.value = val['long_name'];
        } else if (val['types'].contains('country') && val['types'].contains('political')) {
          country.value = val['long_name'];
        }
      });
      cityIsEmpty.value = false;
      showErrorText.value = false;
    } else {
      showErrorText.value = false;
      Get.snackbar("Error", "Unable to fetch address details.");
    }
  }

  void updateSelectedRegion(val) {
    selectedRegion.value = val;
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
      if (country.value != '') {
        try {
          isUpdatingAddress(true);
          final responseData = await AuthService.instance.updateAddress({
            'postCode': postCode.value.trim(),
            'address':
            '${address.text.trim()}, ${city.value.trim()}, ${state.value.trim()}. ${country.value.trim()}'
          });
          authFormController.login(
              email: email.value,
              password: password.value,
              rememberMe: true,
              handleEmailNotVerified: () {}
          );
          await FirebaseApi().registerDeviceToken();
          Get.offAll(NavigationMenu());
        } catch (e) {
          print('The error $e');
          Get.snackbar('Error', handleApiFormatError(e), backgroundColor: Colors.red);
        } finally {
          isUpdatingAddress(false);
        }
      } else {
        throw Exception('Form validation failed');
      }
    } else {
      cityIsEmpty.value = true;
      Get.snackbar("Error", "Please fill in the form correctly", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent);
    }
  }

  void clearData() {
    postCode.value = '';
    address.clear();
    city.value = '';
    state.value = '';
    country.value = '';
  }
}
