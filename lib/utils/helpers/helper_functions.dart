import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pouch/utils/constants/colors.dart';

import '../configs/env_config.dart';

class THelperFunctions {

  static void showAlert(String title, String message) {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
              ),
            ],
          );
        }
    );
  }

  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => screen),
    );
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  static String getFormattedDate(String date, {String format = 'MMM dd'}) {
    final dateTime = DateTime.parse(date);
    return DateFormat(format).format(dateTime);
  }

  static String getFormattedTime(String date, {String format = 'h:mm a'}) {
    final dateTime = DateTime.parse(date);
    return DateFormat(format).format(dateTime);
  }

  static String getTimeDifference(String date, {String format = 'h:mm a'}) {
    final dateTime = DateTime.parse(date);
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    int seconds = difference.inSeconds;
    String timeDifference;
    print(seconds);
    if (seconds < 60) {
      timeDifference = "$seconds seconds ago";
    } else if (seconds >= 60 && seconds < 3600) {
      int minutes = seconds ~/ 60;
      timeDifference = "$minutes minutes ago";
    } else  if ( seconds >= 3600 && seconds < 86400){
      int hours = seconds ~/ (60 * 60);
      timeDifference = "$hours hours ago";
    } else {
      int days = seconds ~/ (60 * 60 * 24);
      timeDifference = "$days days ago";
    }
    return timeDifference;
  }

  static DateTime milliSecondToDate(String milliSecondString) {
    int milli = int.parse(milliSecondString);
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milli);
    return dateTime;
  }

  static String millisecondConversion(String milliSecondString) {
    String time;
    int milliseconds = int.parse(milliSecondString);
    int seconds = milliseconds ~/ 1000;
    int remainingMilliseconds = milliseconds % 1000;

    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;

    int hours = minutes ~/ 60;
    int remainingMinute = minutes % 60;

    int days = hours ~/ 24;
    int remainingHours = days % 24;

    if (seconds < 60) {
      return time = "$seconds seconds";
    } else if (seconds < 3600) {
      int minutes = seconds ~/ 60;
      return time = "$minutes minutes";
    } else {
      int days = seconds ~/ 86400;
      int hours = (seconds % 86400) ~/ 3600;
      if (days > 0) {
        return time = "$days days $hours hours";
      } else {
        return time = '$hours hours';
      }
    }

    // if (days > 0) {
    //   time = "${days}days ${remainingHours}hours ${remainingMinute}minutes ${remainingSeconds}seconds";
    // } else if (days == 0 && hours >= 1) {
    //   time = "${remainingHours}hours ${remainingMinute}minutes ${remainingSeconds}seconds";
    // } else if (days == 0 && hours == 0 && seconds > 0) {
    //   time = "${remainingMinute}minutes ${remainingSeconds}seconds";
    // } else {
    //   time = "${remainingSeconds}seconds";
    // }
    //
    // return time;
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  static List<Widget> wrapWidgets<T>(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i+= rowSize) {
      final rowChildren = widgets.sublist(i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrappedList.add(Row(children: rowChildren));
    }
    return wrappedList;
  }

  static String getStringMultiplication(String a, String b) {
    double? intNum1 = double.tryParse(a);
    double? intNum2 = double.tryParse(b);
    double result;

    if (intNum1 != null && intNum2 != null) {
      result = intNum1 * intNum2;
      return result.toString();
    } else {
      result = 0;
      return result.toString();
    }
    // return result.toString();
  }

  static int addUpBooleans(List<bool> arr) {
    int num = 0;
    for (bool t in arr) {
      if (t == true) {
        num += 1;
      }
    }
    return num;
  }

  static String maskEmail(String email) {
    String maskedEmail = '';
    List<String> parts = email.split('@');

    if (parts.length == 2) {
      String username = parts[0];
      String domain = parts[1];

      if (username.isNotEmpty) {
        String firstLetter = username[0];
        String maskedUsername = '$firstLetter${'*' * (username.length - 1)}';
        maskedEmail = '$maskedUsername@$domain';
      }
    }

    return maskedEmail;
  }

  static String maskPhoneNumberHelper(String phoneNumber) {
    if (phoneNumber.length < 6) {
      // Handle invalid phone numbers
      return phoneNumber;
    }

    // Extract the first three digits
    String prefix = phoneNumber.substring(0, 3);

    // Extract the last three digits
    String suffix = phoneNumber.substring(phoneNumber.length - 3);

    // Replace the middle digits with asterisks
    String middleDigits = phoneNumber.substring(3, phoneNumber.length - 3);
    middleDigits = '*' * middleDigits.length;

    // Concatenate the formatted phone number
    String formattedPhoneNumber = prefix + middleDigits + suffix;

    return formattedPhoneNumber;
  }

  static String getInitials(firstName, lastName) {
    String firstInitial = firstName[0];
    String lastInitial = lastName[0];
    return '$firstInitial$lastInitial';
  }

  static void showDebugMessageInConsole(List<String> message) {
    if (EnvConfigurationModule.instance.getEnvType() == 'DEV') {
      print(message);
    }
  }

  static void showTextForDuration(
      BuildContext context,
      String text,
      {Duration duration = const Duration(seconds: 3)}
      ) async {
    final overlayState = Overlay.of(context);
    final overlayEntry = OverlayEntry(
        builder: (context) => Container(
          width: THelperFunctions.screenWidth() * 0.4,
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          // margin: EdgeInsets.only(top: THelperFunctions.screenHeight() - 600),
          decoration: BoxDecoration(
            color: TColors.primary,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        )
    );

    overlayState.insert(overlayEntry);
    await Future.delayed(duration);
    overlayEntry.remove();
  }

  static String moneyFormatter(String? amount) {
    final formatter = NumberFormat("#,##0.00");

    if (amount == null || amount.isEmpty) {
      return formatter.format(0);
    }

    try {
      // Parse the string to double
      double money = double.parse(amount);
      // Format the parsed double value
      return formatter.format(money);
    } catch (e) {
      print('Error parsing amount: $e');
      return formatter.format(0); // Fallback to "0.00" in case of an error
    }
  }

  static String formatRate(String? rate) {
    // If rate is null or empty, return "0.00"
    if (rate == null || rate.isEmpty) {
      return '0.00';
    }

    // Try parsing the rate to a double
    double parsedRate;
    try {
      parsedRate = double.parse(rate);
    } catch (e) {
      // In case of parsing error, return "0.00"
      return '0.00';
    }

    // Convert to a string with up to 2 decimal places
    String formattedRate = parsedRate.toStringAsFixed(2);

    // Remove trailing zeros and the decimal point if necessary
    if (formattedRate.endsWith('.00')) {
      formattedRate = formattedRate.substring(0, formattedRate.length - 3);
    } else if (formattedRate.endsWith('0')) {
      formattedRate = formattedRate.replaceAll(RegExp(r'0+$'), '');
    }

    return formattedRate;
  }

  // static String formatRate(String? rate) {
  //   String formattedRate = rate.toString();
  //   if (rate == null || rate.isEmpty) {
  //     formattedRate = '0.00';
  //   } else {
  //     if (formattedRate.contains('.')) {
  //       formattedRate = formattedRate.replaceAll(RegExp(r'0*$'), '');
  //       formattedRate = formattedRate.replaceAll(RegExp(r'\.$'), '');
  //     }
  //   }
  //   return formattedRate;
  // }
}