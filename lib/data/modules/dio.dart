import 'interceptor.dart';

final apiService = AppInterceptor(showLoader: true).dio;

class ApiService {
}

class TimeoutException implements Exception {
  final String message;
  TimeoutException(this.message);
}