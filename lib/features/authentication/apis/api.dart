import 'package:flutter/material.dart';
import 'package:swappr/data/modules/app_navigator.dart';
import 'package:swappr/data/modules/background_task.dart';
import 'package:swappr/data/modules/dio.dart';
import 'package:swappr/data/modules/session_manager.dart';
import 'package:swappr/data/provider/auth_provider.dart';
import 'package:swappr/features/authentication/models/user_model.dart';
import 'package:swappr/features/home/routes/names.dart';
import 'package:swappr/utils/shared/notification/snackbar.dart';
import '../../../utils/responses/error_dialog.dart';
import '../../../utils/responses/handleApiError.dart';
import '../../../utils/responses/success_dialog.dart';
import '../models/create_account_model.dart';

class AuthService {
  static final AuthService _instance = AuthService._();

  AuthService._();

  static AuthService get instance => _instance;

  // lofin flow

  Future _loginApi(Object data) {
    return apiService.post('path');
  }
  
  login({
    required String email,
    required String password,
    required AuthProvider authProvider,
    required bool rememberMe,
    required VoidCallback handleEmailNotVerified
  }) async {
    _loginApi({
      'email': email,
      'password': password,
    }).then((value) async {
      var responseData = value.data;
      
      UserModel user = UserModel(
          id: responseData['id'],
          firstName: responseData['firstName'],
          lastName: responseData['lastName'],
          email: responseData['email'],
          password: responseData['password'],
          isVerified: responseData['isVerified'],
          nin: responseData['nin'],
          country: responseData['country'],
          status: responseData['status'],
          phoneNumber: responseData['phoneNumber'],
          otp: responseData['otp'],
          emailOtp: responseData['emailOtp'],
          isEmailVerified: responseData['isEmailVerified'],
          otpExpiration: responseData['otpExpiration'],
          currentDate: responseData['currentDate'],
          lastModifiedDate: responseData['lastModifiedDate'],
          role: responseData['role']
      );

      if (rememberMe) {
        UserSession.instance.setRememberMeHandler(
            email: email,
            password: password,
          enabled: true
        );
      } else {
        UserSession.instance.setRememberMeHandler(
            email: email,
            password: password
        );
      }

      // if emailVerified' == false
      if (responseData['emailVerified'] == false) {
        handleEmailNotVerified();
        authProvider.removeUser();
      } else {
        authProvider.saveUser(user);

        AppNavigator.instance.removeAllNavigateToNavHandler(DASHBOARD_SCREEN_ROUTE);
        handleBackgroundAppRequest(
            user: user,
            authProvider: authProvider,
        );
        handleShowCustomToast(message: 'Authenticated successfully');
      }
    }).catchError((error) {
      showErrorAlertHelper(errorMessage: handleApiFormatError(error));
    });
  }

  // register user flow

  Future _createAccountValidateUserDetails(Object data) {
    return apiService.post('', data: data);
  }

  Future _createAccountSendEmailOtp(String email) {
    return apiService.post('');
  }

  Future _createAccountEmailOtpVerification(int otpCode, String id) {
    return apiService.post('');
  }

  Future _createAccount(Object data) {
    return apiService.post('', data: data);
  }

  confirmOtpThenRegister(
      AuthProvider authProvider, String otpCode, VoidCallback handleOnSuccess
      ){
    _createAccountEmailOtpVerification(
        int.parse(otpCode), authProvider.createAccountOtpId ?? ''
    ).then((value) async {
      _createAccount({
        'firstName': authProvider.createAccountFormDetails!.firstName,
        'lastName': authProvider.createAccountFormDetails!.lastName,
        'email': authProvider.createAccountFormDetails!.email,
        'phoneNumber': authProvider.createAccountFormDetails!.phoneNumber,
        'country': authProvider.createAccountFormDetails!.country,
        'password': authProvider.createAccountFormDetails!.password,
        'emailVerified': true,
        'phoneNumberVerified': true,
      }).then((data) {
        UserSession.instance.setRememberMeHandler(
            email: authProvider.createAccountFormDetails!.email,
            password: authProvider.createAccountFormDetails!.password,
          enabled: true
        );
        handleOnSuccess();
      }).catchError((error) {
        showErrorAlertHelper(errorMessage: handleApiFormatError(error));
      });
    }).catchError((error) {
      showErrorAlertHelper(errorMessage: handleApiFormatError(error));
      return error;
    });
  }

  resendCreateAccountEmailOtp(
      AuthProvider authProvider, VoidCallback handleOnSuccess
      ){
    _createAccountSendEmailOtp(authProvider.createAccountFormDetails!.email)
        .then((value) {
      handleOnSuccess();
      var responseData = value.data['id'].toString();
      authProvider.handleCreateUserEmailConfirmation(
          formDetails:
          authProvider.createAccountFormDetails as CreateAccountModel,
          otpId: responseData);
      showSuccessAlertHelperWithoutHeader(successMessage: 'OTP sent');
    }).catchError((error) {
      showErrorAlertHelper(errorMessage: handleApiFormatError(error));
    });
  }

  // reset password

  Future _resetPassword(String email) {
    return apiService.get('');
  }

  Future _verifyOTPAndChangePassword(Object data) {
    return apiService.post('');
  }

  resetPassword({required String email, required VoidCallback onSuccess}) {
    _resetPassword(email).then((value) {
      onSuccess();
      showSuccessAlertHelper(successMessage: 'OTP sent');
    }).catchError((error) {
      showErrorAlertHelper(errorMessage: handleApiFormatError(error));
    });
  }

  verifyOTPAndChangePassword(
      {required String email,
        required String otpCode,
        required String newPassword,
        required VoidCallback onSuccess}) {
    _verifyOTPAndChangePassword(
        {'email': email, 'password': newPassword, 'code': otpCode})
        .then((value) {
      onSuccess();
    }).catchError((error) {
      showErrorAlertHelper(errorMessage: handleApiFormatError(error));
    });
  }

  createAccount(
      {required String firstName,
        required String lastName,
        required String email,
        required String phoneNumber,
        required String country,
        required String password,
        required VoidCallback onSuccess}) async {
    _createAccount({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'country': country,
      'password': password,
      'emailVerified': false,
      'phoneNumberVerified': false,
    }).then((value) {
      var responseData = value.data;
      UserSession.instance.setToken(responseData['authToken']);
      UserSession.instance.setRememberMeHandler(
        email: email,
        password: password,
        enabled: true,
      );
      onSuccess();
    }).catchError((error) {
      showErrorAlertHelper(errorMessage: handleApiFormatError(error));
    });
  }

  Future _confirmEmailOtp(String otpCode, String email) {
    return apiService.post('');
  }

  Future _sendEmailOtpCode(String email) {
    return apiService.post('');
  }

  sendEmailOtp(
      {required String email,
        required VoidCallback onSuccess,
        VoidCallback? onFailure}) {
    _sendEmailOtpCode(email).then((value) {
      onSuccess();
    }).catchError((error) {
      if (onFailure != null) {
        onFailure();
      }

      showErrorAlertHelper(errorMessage: handleApiFormatError(error));
    });
  }

  verifyEmailOtp(String otpCode, String email, VoidCallback onSuccess) {
    _confirmEmailOtp(otpCode, email).then((value) {
      onSuccess();
    }).catchError((error) {
      showErrorAlertHelper(errorMessage: handleApiFormatError(error));
    });
  }

}