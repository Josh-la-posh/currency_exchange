import 'dart:ui';
import 'package:pouch/utils/responses/handleApiError.dart';
import '../../../data/modules/interceptor.dart';

final _apiService = AppInterceptor(showLoader: false).dio;
class AuthService {
  static final AuthService _instance = AuthService._();

  AuthService._();

  static AuthService get instance => _instance;

  Future _createAccount({required Object data}) {
    return _apiService.post('/users/create', data: data);
  }

  Future _changePassword({required Object data}) {
    return _apiService.post('/users/change-password', data: data);
  }

  Future _sendEmailOtpCode({required Object data}) {
    return _apiService.post('/users/generate-otp', data: data);
  }

  Future _emailVerificationOtp({required Object data}) {
    return _apiService.post('/users/re-email-confirmation-otp', data: data);
  }

  Future _resetPassword({required Object data}) {
    return _apiService.post('/users/reset-password', data: data);
  }

  Future _confirmEmailOtp({required Object data}) {
    return _apiService.post('/users/email-verification', data: data);
  }

  Future _loginApi({required Object data}) {
    return _apiService.post('/auth/login', data: data);
  }

  Future _updateAddress({required Object data}) {
    return _apiService.post('/users/update-address', data: data);
  }

  Future _currentUserApi() {
    return _apiService.get('/users/current-user');
  }

  Future _confirmVerification() {
    return _apiService.get('/users/confirm-verification');
  }

  // Post requests

  Future createAccount({required Object data, required VoidCallback onFailure}) async {
    return _createAccount(data: data).then((response) {
      return response;
    }).catchError((error) {
      onFailure();
      throw (handleApiFormatError(error));
    });
  }

  Future changePassword({required Object data, required VoidCallback onFailure}) async{
    return _changePassword(data: data).then((response) {
      return response.data;
    }).catchError((error) {
      onFailure();
      throw (handleApiFormatError(error));
    });
  }

  Future sendEmailOtpCode({required Object data, required VoidCallback onFailure}) async{
    return _sendEmailOtpCode(data: data).then((response) {
      return response.data;
    }).catchError((error) {
      onFailure();
      throw (handleApiFormatError(error));
    });
  }

  Future emailVerificationOtp({required Object data, required VoidCallback onFailure}) async{
    return _emailVerificationOtp(data: data).then((response) {
      return response.data;
    }).catchError((error) {
      onFailure();
      throw (handleApiFormatError(error));
    });
  }

  Future resetPassword({required Object data, required VoidCallback onFailure}) async{
    return _resetPassword(data: data).then((response) async {
      return response.data;
    }).catchError((error) {
      onFailure();
      throw (handleApiFormatError(error));
    });
  }

  Future confirmEmailOtp({required Object data, required VoidCallback onFailure}) async{
    return _confirmEmailOtp(data: data).then((response) async {
      return response.data;
    }).catchError((error) {
      onFailure();
      throw (handleApiFormatError(error));
    });
  }

  Future loginApi({required Object data, required VoidCallback onFailure}) async{
    return _loginApi(data: data).then((response) async {
      return response;
    }).catchError((error) {
      print('The found error is: $error');
      onFailure();
      throw (handleApiFormatError(error));
    });
  }

  Future updateAddress({required Object data, required VoidCallback onFailure}) async{
    return _updateAddress(data: data).then((response) async {
      return response;
    }).catchError((error) {
      onFailure();
      throw (handleApiFormatError(error));
    });
  }

  // Get requests

  Future currentUserApi({required VoidCallback onFailure}) async{
    return _currentUserApi().then((response) async {
      return response.data;
    }).catchError((error) {
      onFailure();
      throw (handleApiFormatError(error));
    });
  }

  Future confirmVerification() async {
    final response = await _apiService.get('/users/confirm-verification');
    return response.data;
  }
}