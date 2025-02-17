import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pouch/data/modules/inactivity_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/modules/storage_session_controller.dart';
import '../../../utils/constants/app.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';
import '../../../utils/layouts/navigation_menu.dart';
import '../../../utils/local_storage/local_storage.dart';
import '../../../utils/responses/handleApiError.dart';
import '../apis/api.dart';
import '../models/user_model.dart';
import '../screens/add_details/add_address_detail.dart';
import '../screens/email_verify/email_verify.dart';

class AuthFormController extends GetxController {
  UserSessionController userSessionController = Get.find<UserSessionController>();
  final SharedPreferences _storage = LocalStorage.instance.storage;
  final LocalAuthentication _auth = LocalAuthentication();
  final CancelToken requestCancelToken = CancelToken();
  var isLoggingIn = false.obs;
  var rememberMe = false.obs;
  var obscurePassword = true.obs;
  var email = ''.obs;
  var password = ''.obs;

  @override
  void onInit() {
    _getUserSaveData();
    email.value = '';
    password.value = '';
    super.onInit();
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

  Future<void> _getUserSaveData() async {
    final userJson = _storage.getString(USER_DATA);
    if (userJson != null) {
      saveUser(UserModel.fromJson(json.decode(userJson)));
    }
  }

  void saveUser(UserModel? userInfo) {
    final userJson = json.encode(userInfo?.toJson());
    _storage.setString(USER_DATA, userJson);
    userSessionController.user.value = userInfo!;
  }

  // Submit the form and handle login
  Future<void> submitLoginForm({required GlobalKey<FormState> formKey}) async {
    if (validateForm(formKey)) {
      saveForm(formKey);
      try {
        isLoggingIn(true);
        userSessionController.removeUser();
        await login(
          email: email.value.toString(),
          password: password.value.toString(),
          rememberMe: true,
          handleEmailNotVerified: () {
            Get.to(EmailVerificationScreen(
              email: email.value.toString(),
              password: password.value.toString(),
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

  Future<void> login({
    required String email,
    required String password,
    required bool rememberMe,
    required VoidCallback handleEmailNotVerified,
  }) async {
    try {
      isLoggingIn(true);
      final response = await AuthService.instance.loginApi(data: {
        'email': email.toLowerCase().trim(),
        'password': password,
      },
        onFailure: () {isLoggingIn(false);}
      );
      var token = response.data['access_token'];
      var refreshToken = response.data['refresh_token'];
      if (response != null && token != '') {
        userSessionController.setToken(token);
        userSessionController.setRefreshToken(refreshToken);
        await fetchCurrentUser(
          email: email.toLowerCase().trim(),
          password: password,
          rememberMe: rememberMe,
          handleEmailNotVerified: handleEmailNotVerified,
        );

        // await FirebaseApi().updateDeviceToken();
      }
      return token;
    } catch (err) {
      Get.snackbar('Error', err.toString(), backgroundColor: Colors.red);
    } finally {
    isLoggingIn(false);
    }
  }

  Future<void> loginWithBiometric() async {
    final email = _storage.getString(USER_REMEMBER_ME_EMAIL);
    final password = _storage.getString(USER_REMEMBER_ME_PASS);
    print('The new email is ${email} $password');
    final useBiometrics = await userSessionController.getUserBiometrics();
    if (email != null) {
      if (useBiometrics == true) {
        bool canAuthWithBiometric = await _auth.canCheckBiometrics;
        if (canAuthWithBiometric == true) {
          try {
            final bool didAuthenticate = await _auth.authenticate(
                authMessages: const <AuthMessages>[
                  AndroidAuthMessages(
                      signInTitle: 'Authentication required',
                      cancelButton: 'No thanks'
                  ),
                  IOSAuthMessages(
                      cancelButton: 'No thanks'
                  )
                ],
                localizedReason: 'Please authenticate to login',
                options: const AuthenticationOptions(
                    biometricOnly: false
                )
            );
            if (didAuthenticate) {
              login(
                email: email.toString(),
                password: password.toString(),
                rememberMe: true,
                handleEmailNotVerified: (){},
              );
            } else {
              print('Authentication didn\'t work');
            }
          } on PlatformException catch (e) {
            print('Authentication error $e');
            canAuthWithBiometric = false;
          }
        }
      } else {
        Get.snackbar('Error', 'Biometric has not been set');
      }
    } else {
      Get.snackbar('', 'Login to continue');
    }
  }

  Future<void> fetchCurrentUser({
    required String email,
    required String password,
    required bool rememberMe,
    required VoidCallback handleEmailNotVerified,
  }) async {
    try {
      isLoggingIn(true);
      final responseData = await AuthService.instance.currentUserApi(
        onFailure: () {
          isLoggingIn(false);
        }
      );
      userSessionController.user(UserModel(
          id: responseData['id'],
          firstName: responseData['firstName'],
          lastName: responseData['lastName'],
          email: responseData['email'],
          password: responseData['password'],
          isVerified: responseData['isVerified'],
          nin: responseData['nin'],
          country: responseData['country'],
          address: responseData['address'],
          postCode: responseData['postCode'],
          state: responseData['state'],
          status: responseData['status'],
          phoneNumber: responseData['phoneNumber'],
          otp: responseData['otp'],
          emailOtp: responseData['emailOtp'],
          isEmailVerified: responseData['isEmailVerified'],
          otpExpiration: responseData['otpExpiration'],
          lastLogin: responseData['lastLogin'],
          lastLoginDevice: responseData['lastLoginDevice'],
          createdDate: responseData['createdDate'],
          lastModifiedDate: responseData['lastModifiedDate'],
          role: responseData['role']
      ));
      userSessionController.setRememberMeHandler(
          email: email.toLowerCase().trim(),
          password: password,
          enabled: true
      );
      saveUser(userSessionController.user.value);
      if (userSessionController.user.value.isEmailVerified != true) {
        handleEmailNotVerified();
      } else if (userSessionController.user.value.address == null) {
        Get.offAll(() => AddAddressDetail(
            email: email.toLowerCase().trim(),
            password: password
        ));
      } else {
        Get.offAll(() => NavigationMenu());
        InactivityService.instance.startMonitoring();
      }
    } catch (err) {

      print('the error is from here $err');
      Get.snackbar('Error', err.toString(), backgroundColor: Colors.red);
    } finally {
      isLoggingIn(false);
    }
  }
  
  @override
  void dispose() {
    requestCancelToken.cancel('Component disposed');
    super.dispose();
  }
}
