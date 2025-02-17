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
            // return cleanErrorMessage(firstValue);
            return firstValue;
          } else if (firstValue is List && firstValue.isNotEmpty) {
            return firstValue.first.toString();
          }

          return cleanErrorMessage(data.values.toString());
        } else {
          return cleanErrorMessage(data.toString());
        }
      } else {
        return 'No Response from Server';
      }
    } else {
      return 'An unexpected error occurred';
    }
  } catch (e, stackTrace) {
    debugPrint('Caught error: $e');
    debugPrint('Stack trace: $stackTrace');

    if (e is DioException) {
      return 'Failed to parse error response: ${e.message}';
    } else if (e != null && e.toString().isNotEmpty) {
      return 'Unexpected error occurred: ${e.toString()}';
    } else {
      return 'An unexpected error occurred.';
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