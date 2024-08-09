import 'package:dio/dio.dart';

import 'package:dio/dio.dart';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

String handleApiFormatError(dynamic error) {
  try {
    if (error is DioException) {
      if (error.response != null) {
        final data = error.response!.data;
        print('the real data $data');

        if (data == null) {
          return 'Internal server error. Please try again later.';
        }

        if (data is String) {
          return cleanErrorMessage(data);
        } else if (data is Map) {
          final firstValue = data['message'];

          if (firstValue == null) {
            return 'Unexpected error occurred. Please try again later.';
          }

          if (firstValue is String) {
            return cleanErrorMessage(firstValue);
          } else if (firstValue is List && firstValue.isNotEmpty) {
            return firstValue.first.toString();
          }

          return cleanErrorMessage(data.values.toString());
        } else {
          return cleanErrorMessage(data.toString());
        }
      } else {
        return 'Something went wrong, please try again later.';
      }
    } else {
      return 'No response from server, check your network connectivity.';
    }
  } catch (e, stackTrace) {
    // Log the error and stack trace for debugging
    debugPrint('Caught error: $e');
    debugPrint('Stack trace: $stackTrace');

    // Provide a more descriptive error message
    if (e is DioException) {
      return 'Failed to parse error response: ${e.message}';
    } else if (e != null && e.toString().isNotEmpty) {
      return 'Unexpected error occurred: ${e.toString()}';
    } else {
      return 'An unknown error occurred.';
    }
  }
}

String cleanErrorMessage(String message) {
  if (message.contains('DioException') ||
      message.contains('https://tools.ietf.org') ||
      message.contains('html')) {
    return 'Something went wrong, please try again later.';
  }
  if (message.toLowerCase().contains('internal server error')) {
    return 'Internal server error. Please try again later.';
  }
  return message;
}



// String cleanErrorMessage(String message) {
//   if (message.contains('DioException') ||
//       message.contains('https://tools.ietf.org') ||
//       message.contains('html')) {
//     return 'Something went wrong, please try again later.';
//   }
//   if (message.toLowerCase().contains('internal server error')) {
//     return 'Internal server error. Please try again later.';
//   }
//   return message;
// }

