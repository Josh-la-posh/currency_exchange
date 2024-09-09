import 'dart:convert';

import 'package:get/get.dart';
import 'package:pouch/features/authentication/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/constants/app.dart';
import '../../../utils/local_storage/local_storage.dart';

class AuthController extends GetxController {

  final isVerifiedDisplay = false.obs;

  final SharedPreferences _storage = LocalStorage.instance.storage;
  final user = UserModel().obs;

  @override
  void onInit() {
    getUserSaveData();
    super.onInit();
  }

  void getIsVerified() {
    if (user.value.isVerified == false) {
      isVerifiedDisplay.value = true;
    }
  }

  Future<void> getUserSaveData() async {
    final userJson = _storage.getString(USER_DATA);
    if (userJson != null) {
      if (user.value.email == null) {
        saveUser(UserModel.fromJson(json.decode(userJson)));
      }
    }
  }

  void saveUser(UserModel userInfo) {
    final userJson = json.encode(userInfo.toJson());
    _storage.setString(USER_DATA, userJson);
    print(userInfo);
    user.value = userInfo;
    // user(UserModel(
    //   id: userInfo.id,
    //   firstName: userInfo.firstName,
    //   lastName: userInfo.lastName,
    //   email: userInfo.email,
    //   password: userInfo.password,
    //   isVerified: userInfo.isVerified,
    //   nin: userInfo.nin,
    //   country: userInfo.country,
    //   address: userInfo.address,
    //   postCode: userInfo.postCode,
    //   state: userInfo.state,
    //   status: userInfo.status,
    //   phoneNumber: userInfo.phoneNumber,
    //   otp: userInfo.otp,
    //   emailOtp: userInfo.emailOtp,
    //   isEmailVerified: userInfo.isEmailVerified,
    //   otpExpiration: userInfo.otpExpiration,
    //   createdDate: userInfo.createdDate,
    //   lastModifiedDate: userInfo.lastModifiedDate,
    //   role: userInfo.role,
    // ));

    // handleCreateAccountCleanups();
  }

  void clearData() {
    user.value = UserModel();
  }
}