import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/data/modules/dio.dart';
import '../../../data/modules/interceptor.dart';
import '../../../data/modules/storage_session_controller.dart';
import '../../../utils/responses/handleApiError.dart';

final _apiService = AppInterceptor(showLoader: false).dio;
class AuthService {
  static final AuthService _instance = AuthService._();

  AuthService._();

  static AuthService get instance => _instance;
  
  final userSessionController = Get.find<UserSessionController>();

  // Post requests


  Future createAccount(Object data) async{
    return apiService.post('/users/create', data: data);
  }

  Future changePassword(Object data) async{
    return apiService.post('/users/change-password', data: data);
  }

  Future sendEmailOtpCode(Object data) {
    return _apiService.post('/users/generate-otp', data: data);
  }

  Future emailVerificationOtp(Object data) {
    return _apiService.post('/users/re-email-confirmation-otp', data: data);
  }

  Future resetPassword(Object data) {
    return apiService.post('/users/reset-password', data: data);
  }

  Future confirmEmailOtp(Object data) {
    return _apiService.post('/users/email-verification', data: data);
  }

  Future loginApi({required Object data}) async {
    final response = await _apiService.post('/auth/login', data: data);
    return response;
  }

  Future updateAddress(Object data) async{
    return _apiService.post('/users/update-address', data: data);
  }


  // Get requests

  Future currentUserApi() async {
    final response = await _apiService.get('/users/current-user');
    return response.data;
  }

  Future confirmVerification() async {
    final response = await _apiService.get('/users/confirm-verification');
    return response.data;
  }






  // creating an account

  // createAccount(
  //     {required String firstName,
  //       required String lastName,
  //       required String email,
  //       required String phoneNumber,
  //       required String password,
  //       required VoidCallback onSuccess}) async {
  //   _createAccount({
  //     'firstName': firstName,
  //     'lastName': lastName,
  //     'email': email.toLowerCase().trim(),
  //     'phoneNumber': phoneNumber,
  //     'password': password,
  //   }).then((responseData) {
  //     print(responseData.data);
  //     onSuccess();
  //   }).catchError((error) {
  //     handleShowCustomToast(message: handleApiFormatError(error));
  //     // showErrorAlertHelper(errorMessage: handleApiFormatError(error));
  //   });
  // }

  // updateAddress({
  //   required String postCode,
  //   required String address,
  //   required String email,
  //   required String password,
  //   required AuthProvider authProvider,
  //   required WalletProvider walletProvider,
  //   required TransactionProvider transactionProvider,
  //   required NotificationProvider notificationProvider,
  //   required OfferProvider offerProvider,
  //   required SubscriptionProvider subscriptionProvider,
  //   required bool rememberMe,
  //   required VoidCallback handleEmailNotVerified,
  //   }) async {
  //   handleShowCustomToast(message: 'Uploading data ...');
  //   _updateAddress({
  //     'postCode': postCode,
  //     'address': address,
  //   }).then((responseData) async{
  //     print(responseData.data);
  //     await currentUser(
  //         email: email.toLowerCase().trim(),
  //         password: password,
  //         authProvider: authProvider,
  //         walletProvider: walletProvider,
  //         transactionProvider: transactionProvider,
  //         offerProvider: offerProvider,
  //         subscriptionProvider: subscriptionProvider,
  //         notificationProvider: notificationProvider,
  //         rememberMe: rememberMe,
  //         handleEmailNotVerified: handleEmailNotVerified
  //     );
  //   }).catchError((error) {
  //     handleShowCustomToast(message: handleApiFormatError(error));
  //     // showErrorAlertHelper(errorMessage: handleApiFormatError(error));
  //   });
  // }
  //
  // // change password
  //
  // changePassword({
  //   required String currentPassword,
  //   required String newPassword,
  //   required VoidCallback onSuccess
  // }) {
  //   _changePassword({
  //     'currentPassword': currentPassword,
  //     'newPassword': newPassword
  //   }).then((response) {
  //     print('change password $response');
  //     onSuccess();
  //     handleShowCustomToast(message: 'Password changed successfully');
  //     // showSuccessAlertHelper(successMessage: 'Password changed successfully');
  //   }).catchError((error){
  //     print(error.toString());
  //     handleShowCustomToast(message: handleApiFormatError(error));
  //     // showErrorAlertHelper(errorMessage: handleApiFormatError(error));
  //   });
  // }
  //
  // // current user
  //
  // currentUser({
  //   required String email,
  //   required String password,
  //   required AuthProvider authProvider,
  //   required WalletProvider walletProvider,
  //   required TransactionProvider transactionProvider,
  //   required OfferProvider offerProvider,
  //   required SubscriptionProvider subscriptionProvider,
  //   required NotificationProvider notificationProvider,
  //   required bool rememberMe,
  //   required VoidCallback handleEmailNotVerified
  // }) async {
  //   _currentUserApi()
  //       .then((responseData) async {
  //     UserModel user = UserModel(
  //         id: responseData['id'],
  //         firstName: responseData['firstName'],
  //         lastName: responseData['lastName'],
  //         email: responseData['email'],
  //         password: responseData['password'],
  //         isVerified: responseData['isVerified'],
  //         nin: responseData['nin'],
  //         country: responseData['country'],
  //         address: responseData['address'],
  //         postCode: responseData['postCode'],
  //         state: responseData['state'],
  //         status: responseData['status'],
  //         phoneNumber: responseData['phoneNumber'],
  //         otp: responseData['otp'],
  //         emailOtp: responseData['emailOtp'],
  //         isEmailVerified: responseData['isEmailVerified'],
  //         otpExpiration: responseData['otpExpiration'],
  //         createdDate: responseData['createdDate'],
  //         lastModifiedDate: responseData['lastModifiedDate'],
  //         role: responseData['role']
  //     );
  //
  //     // print('user ${user.id}');
  //
  //     if (rememberMe) {
  //
  //       userSessionController.setRememberMeHandler(
  //           email: email.toLowerCase().trim(),
  //           password: password,
  //           enabled: true
  //       );
  //     } else {
  //       userSessionController.setRememberMeHandler(
  //           email: email,
  //           password: password
  //       );
  //     }
  //
  //     // if emailVerified' == false
  //     if (!responseData['isEmailVerified']) {
  //       handleEmailNotVerified();
  //       authProvider.removeUser();
  //     } else {
  //       authProvider.saveUser(user);
  //       // handleBackgroundAppRequest(
  //       //   user: user,
  //       // );
  //       // handleShowLoader();
  //       if (authProvider.user?.address == null) {
  //         Get.to(() => AddAddressDetail(
  //             email: email.toLowerCase().trim(),
  //             password: password,
  //             rememberMe: rememberMe
  //         ));
  //       } else {
  //         AppNavigator.instance.removeAllNavigateToNavHandler(DASHBOARD_SCREEN_ROUTE);
  //       }
  //     }
  //
  //   }).catchError((error) {
  //     handleShowCustomToast(message: handleApiFormatError(error));
  //   });
  // }
  //
  // // confirm verification
  //
  // confirmVerification() async {
  //   _confirmVerification()
  //       .then((responseData) async {
  //   }).catchError((error) {
  //     handleShowCustomToast(message: handleApiFormatError(error));
  //     // showErrorAlertHelper(errorMessage: handleApiFormatError(error));
  //   });
  // }
  //
  // // generate otp
  //
  // generateOtp({
  //   required String email,
  //   required VoidCallback onSuccess,
  //   VoidCallback? onFailure}) {
  //   handleShowCustomToast(message: 'Sending OTP ...');
  //   _sendEmailOtpCode({"email": email.toLowerCase().trim()}).then((value) {
  //     onSuccess();
  //   }).catchError((error) {
  //     if (onFailure != null) {
  //       onFailure();
  //     }
  //     handleShowCustomToast(message: handleApiFormatError(error));
  //     // showErrorAlertHelper(errorMessage: handleApiFormatError(error));
  //   });
  // }
  //
  // emailVerificationOtp({
  //   required String email,
  //   required VoidCallback onSuccess,
  //   VoidCallback? onFailure}) {
  //   _emailVerificationOtp({"email": email.toLowerCase().trim()}).then((value) {
  //     onSuccess();
  //   }).catchError((error) {
  //     if (onFailure != null) {
  //       onFailure();
  //     }
  //     handleShowCustomToast(message: handleApiFormatError(error));
  //     // showErrorAlertHelper(errorMessage: handleApiFormatError(error));
  //   });
  // }
  //
  // // reset password
  //
  // resetPassword({required int otp, required String newPassword, required VoidCallback onSuccess}) {
  //   _resetPassword({
  //     'otp': otp,
  //     'newPassword': newPassword
  //   }).then((value) {
  //     onSuccess();
  //     showSuccessAlertHelper(successMessage: 'Password reset successful');
  //   }).catchError((error) {
  //     handleShowCustomToast(message: handleApiFormatError(error));
  //     // showErrorAlertHelper(errorMessage: handleApiFormatError(error));
  //   });
  // }
  //
  // // verify email
  //
  // verifyEmailOtp({required String otpCode,required VoidCallback onSuccess}) {
  //   final intOtp = int.parse(otpCode);
  //   _confirmEmailOtp({"emailOtp": intOtp}).then((value) {
  //     onSuccess();
  //   }).catchError((error) {
  //     handleShowCustomToast(message: handleApiFormatError(error));
  //     // showErrorAlertHelper(errorMessage: handleApiFormatError(error));
  //   });
  // }
  //
  //
  // // login flow
  //
  // login({
  //   required String email,
  //   required String password,
  //   required AuthProvider authProvider,
  //   required WalletProvider walletProvider,
  //   required TransactionProvider transactionProvider,
  //   required OfferProvider offerProvider,
  //   required SubscriptionProvider subscriptionProvider,
  //   required NotificationProvider notificationProvider,
  //   required bool rememberMe,
  //   required VoidCallback handleEmailNotVerified
  // }) async {
  //   _loginApi({
  //     'email': email.toLowerCase().trim(),
  //     'password': password,
  //   }).then((responseData) async {
  //     var token = responseData['access_token'];
  //
  //     if (responseData != null && token != '') {
  //       userSessionController.setToken(token);
  //       UserSession.instance.setToken(token);
  //
  //       await currentUser(
  //           email: email.toLowerCase().trim(),
  //           password: password,
  //           authProvider: authProvider,
  //           walletProvider: walletProvider,
  //           transactionProvider: transactionProvider,
  //           offerProvider: offerProvider,
  //           subscriptionProvider: subscriptionProvider,
  //           notificationProvider: notificationProvider,
  //           rememberMe: rememberMe,
  //           handleEmailNotVerified: handleEmailNotVerified
  //       );
  //     }
  //     return token;
  //   }).catchError((error) {
  //     print(error);
  //     handleShowCustomToast(message: handleApiFormatError(error));
  //   });
  // }
  //
  // loginAfterEmailVerified({
  // required String email,
  //   required String password,
  //   required AuthProvider authProvider,
  //   required WalletProvider walletProvider,
  //   required TransactionProvider transactionProvider,
  //   required OfferProvider offerProvider,
  //   required SubscriptionProvider subscriptionProvider,
  //   required bool rememberMe,
  //   required VoidCallback handleEmailNotVerified,
  // }) async {
  //   _loginApi({
  //     'email': email.toLowerCase().trim(),
  //     'password': password,
  //   }).then((responseData) async {
  //     var token = responseData['access_token'];
  //
  //     if (responseData != null && token != '') {
  //       userSessionController.setToken(token);
  //       Get.to(() => AddAddressDetail(
  //           email: email.toLowerCase().trim(),
  //           password: password,
  //           rememberMe: rememberMe,
  //       ));
  //     }
  //     return token;
  //   }).catchError((error) {
  //     handleShowCustomToast(message: handleApiFormatError(error));
  //   });
  // }
  //


}