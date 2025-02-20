import 'dart:ui';
import 'package:pouch/utils/responses/handleApiError.dart';
import '../../../data/modules/dio_service.dart';
import '../../../data/modules/interceptor.dart';

// final _apiService = AppInterceptor(showLoader: false).dio;
class AuthService {
  static final AuthService _instance = AuthService._();

  AuthService._();

  static AuthService get instance => _instance;

  final DioService _dioService = DioService();

  // Future _createAccount({required Object data}) {
  //   return _apiService.post('/users/create', data: data);
  // }
  //
  // Future _changePassword({required Object data}) {
  //   return _apiService.post('/users/change-password', data: data);
  // }
  //
  // Future _sendEmailOtpCode({required Object data}) {
  //   return _apiService.post('/users/generate-otp', data: data);
  // }
  //
  // Future _emailVerificationOtp({required Object data}) {
  //   return _apiService.post('/users/re-email-confirmation-otp', data: data);
  // }
  //
  // Future _resetPassword({required Object data}) {
  //   return _apiService.post('/users/reset-password', data: data);
  // }
  //
  // Future _confirmEmailOtp({required Object data}) {
  //   return _apiService.post('/users/email-verification', data: data);
  // }
  //
  // Future _loginApi({required Object data}) {
  //   return _apiService.post('/auth/login', data: data);
  // }
  //
  // Future _updateAddress({required Object data}) {
  //   return _apiService.post('/users/update-address', data: data);
  // }
  //
  // Future _currentUserApi() {
  //   return _apiService.get('/users/current-user');
  // }
  //
  // Future _confirmVerification() {
  //   return _apiService.get('/users/confirm-verification');
  // }

  // Post requests

  // Future createAccount({required Object data, required VoidCallback onFailure}) async {
  //   return _createAccount(data: data).then((response) {
  //     return response;
  //   }).catchError((error) {
  //     onFailure();
  //     throw (handleApiFormatError(error));
  //   });
  // }

  // Future changePassword({required Object data, required VoidCallback onFailure}) async{
  //   return _changePassword(data: data).then((response) {
  //     return response.data;
  //   }).catchError((error) {
  //     onFailure();
  //     throw (handleApiFormatError(error));
  //   });
  // }

  // Future sendEmailOtpCode({required Object data, required VoidCallback onFailure}) async{
  //   return _sendEmailOtpCode(data: data).then((response) {
  //     return response.data;
  //   }).catchError((error) {
  //     onFailure();
  //     throw (handleApiFormatError(error));
  //   });
  // }
  //
  // Future emailVerificationOtp({required Object data, required VoidCallback onFailure}) async{
  //   return _emailVerificationOtp(data: data).then((response) {
  //     return response.data;
  //   }).catchError((error) {
  //     onFailure();
  //     throw (handleApiFormatError(error));
  //   });
  // }
  //
  // Future resetPassword({required Object data, required VoidCallback onFailure}) async{
  //   return _resetPassword(data: data).then((response) async {
  //     return response.data;
  //   }).catchError((error) {
  //     onFailure();
  //     throw (handleApiFormatError(error));
  //   });
  // }
  //
  // Future confirmEmailOtp({required Object data, required VoidCallback onFailure}) async{
  //   return _confirmEmailOtp(data: data).then((response) async {
  //     return response.data;
  //   }).catchError((error) {
  //     onFailure();
  //     throw (handleApiFormatError(error));
  //   });
  // }

  // Future loginApi({required Object data, required VoidCallback onFailure}) async{
  //   return _loginApi(data: data).then((response) async {
  //     return response;
  //   }).catchError((error) {
  //     print('The found error is: $error');
  //     onFailure();
  //     throw (handleApiFormatError(error));
  //   });
  // }

  // Future updateAddress({required Object data, required VoidCallback onFailure}) async{
  //   return _updateAddress(data: data).then((response) async {
  //     return response;
  //   }).catchError((error) {
  //     onFailure();
  //     throw (handleApiFormatError(error));
  //   });
  // }

  // Future currentUserApi({required VoidCallback onFailure}) async{
  //   return _currentUserApi().then((response) async {
  //     return response.data;
  //   }).catchError((error) {
  //     onFailure();
  //     throw (handleApiFormatError(error));
  //   });
  // }

  // Future confirmVerification() async {
  //   final response = await _apiService.get('/users/confirm-verification');
  //   return response.data;
  // }

  // Get requests

  Future<Map<String, dynamic>> currentUserApi({required VoidCallback onFailure}) async {
    try {
      final response = await _dioService.getRequest('/users/current-user');
      return response;
    } catch (error) {
      onFailure();
      throw error;
    }
  }

  // Post requests

  Future<Map<String, dynamic>> loginApi({
    required Map<String, dynamic> data,
    required VoidCallback onFailure,
  }) async {
    try {
      final response = await _dioService.postRequest(endpoint: '/auth/login', data: data);
      return response;
    } catch (error) {
      onFailure();
      throw error;
    }
  }

  Future<Map<String, dynamic>> createAccount({
    required Map<String, dynamic> data,
    required VoidCallback onFailure,
  }) async {
    try {
      final response = await _dioService.postRequest(endpoint: '/users/create', data: data);
      return response;
    } catch (error) {
      onFailure();
      throw error;
    }
  }

  Future<Map<String, dynamic>> changePassword({required Map<String, dynamic> data, required VoidCallback onFailure}) async {
    try {
      return await _dioService.postRequest(endpoint: '/users/change-password', data: data);
    } catch (error) {
      onFailure();
      throw error;
    }
  }

  Future<Map<String, dynamic>> sendEmailOtpCode({required Map<String, dynamic> data, required VoidCallback onFailure}) async {
    try {
      return await _dioService.postRequest(endpoint: '/users/generate-otp', data: data);
    } catch (error) {
      onFailure();
      throw error;
    }
  }

  Future<Map<String, dynamic>> emailVerificationOtp({required Map<String, dynamic> data, required VoidCallback onFailure}) async {
    try {
      return await _dioService.postRequest(endpoint: '/users/re-email-confirmation-otp', data: data);
    } catch (error) {
      onFailure();
      throw error;
    }
  }

  Future<Map<String, dynamic>> resetPassword({required Map<String, dynamic> data, required VoidCallback onFailure}) async {
    try {
      return await _dioService.postRequest(endpoint: '/users/reset-password', data: data);
    } catch (error) {
      onFailure();
      throw error;
    }
  }

  Future<Map<String, dynamic>> confirmEmailOtp({required Map<String, dynamic> data, required VoidCallback onFailure}) async {
    try {
      return await _dioService.postRequest(endpoint: '/users/email-verification', data: data);
    } catch (error) {
      onFailure();
      throw error;
    }
  }

  Future<Map<String, dynamic>> updateAddress({required Map<String, dynamic> data, required VoidCallback onFailure}) async {
    try {
      return await _dioService.postRequest(endpoint: '/users/update-address', data: data);
    } catch (error) {
      onFailure();
      throw error;
    }
  }

}