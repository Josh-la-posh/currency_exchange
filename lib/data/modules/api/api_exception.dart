import 'package:dio/dio.dart';

class ApiErrorHandler {
  static String handleDioError(DioException error) {
    if (error.response != null) {
      switch (error.response?.statusCode) {
        case 400:
          return '${error.response?.data['message'] ?? 'Invalid request'}';
        case 401:
          return '${error.response?.data['message'] ?? 'Unauthorized'}';
        case 403:
          return 'Forbidden: You do not have permission.';
        case 404:
          return 'Not Found: ${error.response?.data['message'] ?? 'Resource not found'}';
        case 500:
          return 'Server Error: Please try again later.';
        default:
          return '${error.response?.data['message'] ?? 'Something went wrong'}';
      }
    } else if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      return 'Connection Timeout: Please check your internet connection.';
    } else if (error.type == DioExceptionType.connectionError) {
      return 'Please check your internet connection.';
    } else if (error.type == DioExceptionType.unknown) {
      return 'Network Error: Please check your internet connection.';
    } else if (error.type == DioExceptionType.cancel) {
      return 'Request was cancelled by the user.';
    } else {
      return '${error.message}';
    }
  }
}
