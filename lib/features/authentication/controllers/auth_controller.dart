import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pouch/data/firebase/firebase_api.dart';
import 'package:pouch/utils/layouts/navigation_menu.dart';
import 'package:pouch/utils/shared/error_dialog_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pouch/features/authentication/models/create_account_model.dart';
import 'package:pouch/features/authentication/models/user_model.dart';
import 'package:pouch/utils/constants/app.dart';
import 'package:pouch/utils/local_storage/local_storage.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';

import '../../../data/modules/storage_session_controller.dart';
import '../../../utils/responses/handleApiError.dart';
import '../apis/api.dart';
import '../screens/add_details/add_address_detail.dart';

class AuthController extends GetxController {
  final SharedPreferences _storage = LocalStorage.instance.storage;
  UserSessionController get userSessionController => Get.find<UserSessionController>();
  late StreamSubscription<void> _notificationSubscription;
  final LocalAuthentication _auth = LocalAuthentication();

  var user = UserModel().obs;
  var createAccountFormDetails = Rx<CreateAccountModel?>(null);
  var createAccountCanVerifyEmail = RxBool(false);
  var createAccountOtpId = Rx<String?>(null);
  var isLoggingIn = false.obs;
  var isPasswordResetting = false.obs;
  var isVerifiedDisplay = false.obs;

  @override
  void onInit() {
    super.onInit();
    _getUserSaveData();
    _notificationSubscription = Stream.periodic(const Duration(minutes: 5)).listen((event) {
    });
  }

  @override
  void onClose() {
    _notificationSubscription.cancel();
    super.onClose();
  }

  void getIsVerified() {
      isVerifiedDisplay.value = !user.value.isVerified!;
  }

  Future<void> _getUserSaveData() async {
    final userJson = _storage.getString(USER_DATA);
    if (userJson != null) {
      print('Checking if it got here');
      saveUser(UserModel.fromJson(json.decode(userJson)));
    }
  }

  void saveUser(UserModel? userInfo) {
    final userJson = json.encode(userInfo?.toJson());
    _storage.setString(USER_DATA, userJson);
    user.value = userInfo!;
    print('Userinfo data is ${userInfo.lastLoginDevice}');
    print('User data is ${user.value.lastLoginDevice}');
    handleCreateAccountCleanups();
  }

  void removeUser() {
    user.value = UserModel();
    _storage.remove(USER_DATA);
    handleCreateAccountCleanups();
  }

  void handleCreateUserEmailConfirmation({required CreateAccountModel formDetails, required String otpId}) {
    createAccountFormDetails.value = formDetails;
    createAccountCanVerifyEmail.value = true;
    createAccountOtpId.value = otpId;
  }

  void handleCreateAccountCleanups() {
    createAccountFormDetails.value = null;
    createAccountCanVerifyEmail.value = false;
    createAccountOtpId.value = null;
  }

  void setIsVerifiedDisplay(bool val) {
    isVerifiedDisplay.value = val;
  }

  Future<void> createAccount({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String password,
    required VoidCallback onSuccess
  }) async {
    try {
      final response = await AuthService.instance.createAccount({
        'firstName': firstName,
        'lastName': lastName,
        'email': email.toLowerCase().trim(),
        'phoneNumber': phoneNumber,
        'password': password,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        onSuccess();
      }
    } catch (err) {
      showErrorAlertHelper(errorMessage: handleApiFormatError(err));
    } finally {
    }
  }

  Future<void> updateAddress({
    required String postCode,
    required String address,
    required String email,
    required String password,
  }) async {
    try {
      final response = await AuthService.instance.updateAddress({
        'postCode': postCode,
        'address': address,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        await FirebaseApi().registerDeviceToken();
        await login(
            email: email.toLowerCase().trim(),
            password: password,
            rememberMe: true,
            handleEmailNotVerified: (){},
        );
      }
    } catch (err) {
      Get.snackbar('Error', handleApiFormatError(err), backgroundColor: Colors.red);
    } finally {
    }
  }

  // Future<void> changePassword({
  //   required String currentPassword,
  //   required String newPassword,
  //   required VoidCallback onSuccess
  // }) async {
  //   try {
  //     final response = await AuthService.instance.changePassword({
  //       'currentPassword': currentPassword,
  //       'newPassword': newPassword
  //     });
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       onSuccess();
  //     }
  //   } catch (err) {
  //     Get.snackbar('Error', handleApiFormatError(err), backgroundColor: Colors.red);
  //   } finally {
  //   }
  // }

  Future<void> fetchCurrentUser({
    required String email,
    required String password,
    required bool rememberMe,
    required VoidCallback handleEmailNotVerified,
  }) async {
    try {
      isLoggingIn(true);
      final responseData = await AuthService.instance.currentUserApi();
      user(UserModel(
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

      if (rememberMe) {
        userSessionController.setRememberMeHandler(
            email: email.toLowerCase().trim(),
            password: password,
            enabled: true
        );
      }
      if (user.value.isEmailVerified != true) {
        handleEmailNotVerified();
        removeUser();
      } else {
        saveUser(user.value);
        if (user.value.address == null) {
          Get.offAll(() => AddAddressDetail(
              email: email.toLowerCase().trim(),
              password: password,
              rememberMe: rememberMe
          ));
        } else {
          final useBiometrics = await userSessionController.getUserBiometrics();
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
                  Get.offAll(() => NavigationMenu());
                } else {
                  print('Authentication didn\'t work');
                }
              } on PlatformException catch (e) {
                print('Authentication error $e');
                canAuthWithBiometric = false;
              }
            }
          } else {
            Get.offAll(() => NavigationMenu());
          }
        }
      }
    } catch (err) {
      Get.snackbar('Error', handleApiFormatError(err), backgroundColor: Colors.red);
    } finally {
      isLoggingIn(false);
    }
  }

  // Future<void> confirmVerification() async {
  //   try {
  //     isConfirmingVerification(true);
  //     final response = await AuthService.instance.confirmVerification();
  //   } catch (err) {
  //     Get.snackbar('Error', handleApiFormatError(err), backgroundColor: Colors.red);
  //   } finally {
  //     isConfirmingVerification(false);
  //   }
  // }

  Future<void> generateOtp({
    required String email,
    required VoidCallback onSuccess,
    required VoidCallback onFailure
  }) async {
    try {
      final response = await AuthService.instance.sendEmailOtpCode({"email": email.toLowerCase().trim()});
      if (response.statusCode == 200 || response.statusCode == 201) {
        onSuccess();
      }
    } catch (err) {
      if (onFailure != null) {
        onFailure();
      }
      showErrorAlertHelper(errorMessage: handleApiFormatError(err));
    } finally {
    }
  }

  Future<void> emailVerificationOtp({
    required String email,
    required VoidCallback onSuccess,
    VoidCallback? onFailure
  }) async {
    try {
      Get.snackbar('Sending Otp', 'We are sending an a 6 digit code to $email');
      final response = await AuthService.instance.emailVerificationOtp({"email": email.toLowerCase().trim()});
      if (response.statusCode == 200 || response.statusCode == 201) {
        onSuccess();
      }
    } catch (err) {
      if (onFailure != null) {
        onFailure();
      }
      showErrorAlertHelper(errorMessage: handleApiFormatError(err));
    } finally {
      Get.closeAllSnackbars();
    }
  }

  Future<void> resetPassword({required String otp, required String newPassword, required VoidCallback onSuccess}) async {
    try {
      isPasswordResetting(true);
      final response = await AuthService.instance.resetPassword({
        'otp': int.parse(otp),
        'newPassword': newPassword
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        onSuccess();
        Get.snackbar('Success', 'Password reset successful', backgroundColor: Colors.green);
      }
    } catch (err) {
      showErrorAlertHelper(errorMessage: handleApiFormatError(err));
    } finally {
      isPasswordResetting(false);
    }
  }

  Future<void> verifyEmailOtp({required String otpCode,required VoidCallback onSuccess}) async {
    final intOtp = int.parse(otpCode);
    try {
      final response = await AuthService.instance.confirmEmailOtp({"emailOtp": intOtp});
      if (response.statusCode == 200 || response.statusCode == 201) {
        onSuccess();
      }
    } catch (err) {
      showErrorAlertHelper(errorMessage: handleApiFormatError(err));
    }
  }

  Future<void> login({
    required String email,
    required String password,
    required bool rememberMe,
    required VoidCallback handleEmailNotVerified,
}) async {
    try {
      final response = await AuthService.instance.loginApi(data: {
        'email': email.toLowerCase().trim(),
        'password': password,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {

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

          await FirebaseApi().updateDeviceToken();
        }
        return token;
      } else {
        Get.snackbar('Error', handleApiFormatError(response), backgroundColor: Colors.red);
      }
    } catch (err) {
      Get.snackbar('Error', handleApiFormatError(err), backgroundColor: Colors.red);
    }
  }
}
