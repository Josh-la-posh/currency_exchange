import 'package:dio/dio.dart';
import 'interceptor.dart';

final apiService = AppInterceptor(showLoader: true).dio;

class ApiOptions {
  final Options options;
  ApiOptions(this.options);
}
