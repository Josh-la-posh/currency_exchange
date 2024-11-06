import 'package:pouch/data/modules/dio.dart';
import '../../../data/modules/interceptor.dart';

final _apiService = AppInterceptor(showLoader: false).dio;
class AuthService {
  static final AuthService _instance = AuthService._();

  AuthService._();

  static AuthService get instance => _instance;

  // Post requests


  Future createAccount(Object data) async{
    return apiService.post('/users/create', data: data);
  }

  Future changePassword(Object data) async{
    final response = await _apiService.post('/users/change-password', data: data);
    return response;
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
}