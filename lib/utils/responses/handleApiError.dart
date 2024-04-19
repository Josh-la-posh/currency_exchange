import 'package:dio/dio.dart';

String handleApiFormatError(dynamic error) {
  try {
    if (error is DioException) {
      if (error.response != null) {
        // Retrieve the error message from the response
        if (error.response!.data is String) {
          return cleanErrorMessage(error.response!.data.toString());
        } else {
          if (error.response!.data == null) {
            return 'No response from server, check your network connectivity.';
          }
          if (error.response!.data!.values is Object ||
              error.response!.data!.values is Map) {
            if (error.response!.data.values.first != null) {
              if (error.response!.data.values.first is String) {
                return cleanErrorMessage(
                    error.response!.data.values.first.toString());
              }
              return cleanErrorMessage(
                  error.response!.data.values.first[0].toString());
            }
            if (error.response!.data!.values!.first!.values!.first != null) {
              if (error.response!.data.values.first.values.first is String) {
                return cleanErrorMessage(
                    error.response!.data.values.first.values.first.toString());
              }
              return cleanErrorMessage(
                  error.response!.data.values.first.values.first[0].toString());
            }
            return cleanErrorMessage(error.response!.data.values.toString());
          } else {
            return cleanErrorMessage(error.response!.data.toString());
          }
        }
      } else {
        // Handle other DioError scenarios
        return 'Something went wrong, please try again later.';
      }
    } else {
      // Handle other types of errors
      return 'No response from server, check your network connectivity.';
    }
    // ignore: avoid_catches_without_on_clauses
  } catch (e) {
    return 'No response from server, check your network connectivity.';
  }
}

String cleanErrorMessage(String value) {
  if (value.contains('DioException') ||
      value.contains('https://tools.ietf.org') ||
      value.contains('html')) {
    return 'Something went wrong, please try again later.';
  }
  if (value.toLowerCase().contains('internal server error')) {
    return 'No response from the server, check your network connectivity';
  }
  return value;
}
