import 'package:flutter/material.dart';
import 'package:swappr/data/modules/app_navigator.dart';
import 'package:swappr/data/modules/background_task.dart';
import 'package:swappr/data/modules/dio.dart';
import 'package:swappr/data/modules/session_manager.dart';
import 'package:swappr/data/provider/auth_provider.dart';
import 'package:swappr/data/provider/offer_provider.dart';
import 'package:swappr/data/provider/subscription_provider.dart';
import 'package:swappr/data/provider/transaction_provider.dart';
import 'package:swappr/data/provider/wallet_provider.dart';
import 'package:swappr/features/authentication/models/user_model.dart';
import 'package:swappr/features/home/routes/names.dart';
import 'package:swappr/utils/shared/notification/snackbar.dart';
import '../../../utils/loader.dart';
import '../../../utils/responses/error_dialog.dart';
import '../../../utils/responses/handleApiError.dart';
import '../../../utils/responses/success_dialog.dart';
import '../models/create_account_model.dart';

class AuthService {
  static final AuthService _instance = AuthService._();

  AuthService._();

  static AuthService get instance => _instance;

  // Post requests

  Future _createAccount(Object data) async{
    return apiService.post('/users/create', data: data);
  }

  Future _changePassword(Object data) async{
    return apiService.post('/users/change-password', data: data);
  }

  Future _sendEmailOtpCode(Object data) {
    return apiService.post('/users/generate-otp', data: data);
  }

  Future _resetPassword(Object data) {
    return apiService.post('/users/reset-password', data: data);
  }

  Future _confirmEmailOtp(Object data) {
    return apiService.post('/users/email-verification', data: data);
  }

  Future _loginApi(Object data) async {
    final response = await apiService.post('/auth/login', data: data);
    return response.data;
  }


  // Get requests

  Future _currentUserApi() async {
    final response = await apiService.get('/users/current-user');
    return response.data;
  }

  Future _confirmVerification() async {
    final response = await apiService.get('/users/confirm-verification');
    return response.data;
  }



  // creating an account

  createAccount(
      {required String firstName,
        required String lastName,
        required String email,
        required String phoneNumber,
        required String password,
        required VoidCallback onSuccess}) async {
    _createAccount({
      'firstName': firstName,
      'lastName': lastName,
      'email': email.toLowerCase(),
      'phoneNumber': phoneNumber,
      'password': password,
    }).then((responseData) {
      print(responseData.data);
      onSuccess();
    }).catchError((error) {
      handleShowCustomToast(message: handleApiFormatError(error));
      // showErrorAlertHelper(errorMessage: handleApiFormatError(error));
    });
  }

  // change password

  changePassword({
    required String currentPassword,
    required String newPassword,
    required VoidCallback onSuccess
  }) {
    _changePassword({
      'currentPassword': currentPassword,
      'newPassword': newPassword
    }).then((response) {
      print('change password $response');
      onSuccess();
      handleShowCustomToast(message: 'Password changed successfully');
      // showSuccessAlertHelper(successMessage: 'Password changed successfully');
    }).catchError((error){
      print(error.toString());
      handleShowCustomToast(message: handleApiFormatError(error));
      // showErrorAlertHelper(errorMessage: handleApiFormatError(error));
    });
  }

  // current user

  currentUser({
    required String email,
    required String password,
    required AuthProvider authProvider,
    required WalletProvider walletProvider,
    required TransactionProvider transactionProvider,
    required OfferProvider offerProvider,
    required SubscriptionProvider subscriptionProvider,
    required bool rememberMe,
    required VoidCallback handleEmailNotVerified
  }) async {
    _currentUserApi()
        .then((responseData) async {
      UserModel user = UserModel(
          id: responseData['id'],
          firstName: responseData['firstName'],
          lastName: responseData['lastName'],
          email: responseData['email'],
          password: responseData['password'],
          isVerified: responseData['isVerified'],
          nin: responseData['nin'],
          country: responseData['country'],
          address: responseData['address'],
          state: responseData['state'],
          status: responseData['status'],
          phoneNumber: responseData['phoneNumber'],
          otp: responseData['otp'],
          emailOtp: responseData['emailOtp'],
          isEmailVerified: responseData['isEmailVerified'],
          otpExpiration: responseData['otpExpiration'],
          createdDate: responseData['createdDate'],
          lastModifiedDate: responseData['lastModifiedDate'],
          role: responseData['role']
      );

      // print('user ${user.id}');

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
      if (!responseData['isEmailVerified']) {
        handleEmailNotVerified();
        authProvider.removeUser();
      } else {
        authProvider.saveUser(user);
        // AppNavigator.instance.removeAllNavigateToNavHandler(DASHBOARD_SCREEN_ROUTE);
        handleBackgroundAppRequest(
          user: user,
          authProvider: authProvider,
          walletProvider: walletProvider,
          transactionProvider: transactionProvider,
          subscriptionProvider: subscriptionProvider,
          offerProvider: offerProvider
        );
        handleShowLoader();
        AppNavigator.instance.navigateToHandler(DASHBOARD_SCREEN_ROUTE);
      }

    }).catchError((error) {
      handleShowCustomToast(message: handleApiFormatError(error));
    });
  }

  // confirm verification

  confirmVerification() async {
    _confirmVerification()
        .then((responseData) async {
    }).catchError((error) {
      handleShowCustomToast(message: handleApiFormatError(error));
      // showErrorAlertHelper(errorMessage: handleApiFormatError(error));
    });
  }

  // generate otp

  generateOtp(
      {required String email,
        required VoidCallback onSuccess,
        VoidCallback? onFailure}) {
    _sendEmailOtpCode({"email": email}).then((value) {
      onSuccess();
    }).catchError((error) {
      if (onFailure != null) {
        onFailure();
      }
      handleShowCustomToast(message: handleApiFormatError(error));
      // showErrorAlertHelper(errorMessage: handleApiFormatError(error));
    });
  }

  // reset password

  resetPassword({required int otp, required String newPassword, required VoidCallback onSuccess}) {
    _resetPassword({
      'otp': otp,
      'newPassword': newPassword
    }).then((value) {
      onSuccess();
      showSuccessAlertHelper(successMessage: 'Password reset successful');
    }).catchError((error) {
      handleShowCustomToast(message: handleApiFormatError(error));
      // showErrorAlertHelper(errorMessage: handleApiFormatError(error));
    });
  }

  // verify email

  verifyEmailOtp({required String otpCode,required VoidCallback onSuccess}) {
    final intOtp = int.parse(otpCode);
    _confirmEmailOtp({"emailOtp": intOtp}).then((value) {
      onSuccess();
    }).catchError((error) {
      handleShowCustomToast(message: handleApiFormatError(error));
      // showErrorAlertHelper(errorMessage: handleApiFormatError(error));
    });
  }

  // login flow

  Future<LoginModal?> login({
    required String email,
    required String password,
    required AuthProvider authProvider,
    required WalletProvider walletProvider,
    required TransactionProvider transactionProvider,
    required OfferProvider offerProvider,
    required SubscriptionProvider subscriptionProvider,
    required bool rememberMe,
    required VoidCallback handleEmailNotVerified
  }) async {
    _loginApi({
      'email': email.toLowerCase(),
      'password': password,
    }).then((responseData) async {
      var token = responseData['access_token'];

      if (responseData != null && token != '') {
        UserSession.instance.setToken(token);
        await currentUser(
            email: email,
            password: password,
            authProvider: authProvider,
            walletProvider: walletProvider,
            transactionProvider: transactionProvider,
            offerProvider: offerProvider,
            subscriptionProvider: subscriptionProvider,
            rememberMe: rememberMe,
            handleEmailNotVerified: handleEmailNotVerified
        );
      }
      return token;
    }).catchError((error) {
      handleShowCustomToast(message: handleApiFormatError(error));
    });
  }

}