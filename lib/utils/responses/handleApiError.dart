import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

String handleApiFormatError(dynamic error) {
  try {
    if (error is DioException) {
      if (error.response != null) {
        // Retrieve the error message from the response
        final data = error.response!.data;
        if (data is String) {
          return cleanErrorMessage(error.response!.data.toString());
        } else {
          if (data == null) {
            return 'Internal server error. Please try again later.';
          }
          if (data!.values is Object ||
              data!.values is Map) {
            if (data.values.first != null) {
              if (data.values.last is String) {
                return cleanErrorMessage(
                    data.values.last.toString());
              } else if (data.values.last is Object) {
                return data.values.last[0].toString();
              }
              // debugPrint('Come on ${data.values.last}');
              // return cleanErrorMessage(
              //     data.values.last[0].toString());
            }
            // if (data!.values!.first!.values!.first != null) {
            //   if (data.values.first.values.first is String) {
            //     return cleanErrorMessage(
            //        data.values.first.values.first.toString());
            //   }
            //   return cleanErrorMessage(
            //       data.values.first.values.first[0].toString());
            // }
            return cleanErrorMessage(data.values.toString());
          } else {
            return cleanErrorMessage(data.toString());
          }
        }
      } else {
        // Handle other DioError scenarios
        return 'Something went wrong, please try again later.';
      }
    } else {
      // Handle other types of errors
      return 'No response from server, check your network connectivity. B';
    }
    // ignore: avoid_catches_without_on_clauses
  } catch (e) {
    return 'No response from server, check your network connectivity. C';
  }
}

String cleanErrorMessage(String message) {
  if (message.contains('DioException') ||
      message.contains('https://tools.ietf.org') ||
      message.contains('html')) {
    return 'Something went wrong, please try again later.';
  }
  if (message.toLowerCase().contains('internal server error')) {
    return 'Internal server error. Please try again later';
  }
  return message;
}





// String handleApiFormatError(dynamic error) {
//   if (error is DioException) {
//     final response = error.response;
//     if (response != null) {
//       final errorMessage = response.data; // Use null-safe access
//       if (errorMessage != null) {
//         return cleanErrorMessage(errorMessage);
//       } else {
//         return 'No response from server, check your network connectivity.';
//       }
//     } else {
//       // Handle other DioError scenarios (e.g., connect timeout)
//       return 'Something went wrong, please try again later.';
//     }
//   } else {
//     // Handle other types of errors
//     return 'An unexpected error occurred.';
//   }
// }
//
// String cleanErrorMessage(String message) {
//   if (message.contains('DioException') ||
//       message.contains('https://tools.ietf.org') ||
//       message.contains('html')) {
//     return 'Something went wrong, please try again later.';
//   }
//   if (message.toLowerCase().contains('internal server error')) {
//     return 'Internal server error. Please try again later.'; // More specific
//   }
//   return message;
// }
//
// // Helper extension for null-safe first element access
// extension FirstOrNull<T> on List<T> {
//   T? get firstOrNull => isEmpty ? null : first;
// }