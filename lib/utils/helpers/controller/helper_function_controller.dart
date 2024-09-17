import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constants/colors.dart';

class HelperFunctionsController extends GetxController {
  var multipliedString = '0'.obs;

  // Show Alert
  void showAlert(String title, String message) {
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
      },
    );
  }

  // Navigation
  void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  // Truncate text
  String truncateText(String text, int maxLength) {
    return text.length <= maxLength ? text : '${text.substring(0, maxLength)}...';
  }

  // Check dark mode
  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  // Screen size helpers
  Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  // Format date
  String getFormattedDate(String date, {String format = 'MMM dd'}) {
    final dateTime = DateTime.parse(date);
    return DateFormat(format).format(dateTime);
  }

  // Format time
  String getFormattedTime(String date, {String format = 'h:mm a'}) {
    final dateTime = DateTime.parse(date);
    return DateFormat(format).format(dateTime);
  }

  // Calculate time difference
  String getTimeDifference(String date, {String format = 'h:mm a'}) {
    final dateTime = DateTime.parse(date);
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    int seconds = difference.inSeconds;
    if (seconds < 60) {
      return "$seconds seconds ago";
    } else if (seconds < 3600) {
      int minutes = seconds ~/ 60;
      return "$minutes minutes ago";
    } else if (seconds < 86400) {
      int hours = seconds ~/ 3600;
      return "$hours hours ago";
    } else {
      int days = seconds ~/ 86400;
      return "$days days ago";
    }
  }

  // String multiplication
  String getStringMultiplication(String a, String b) {
    double? num1 = double.tryParse(a);
    double? num2 = double.tryParse(b);

    if (num1 != null && num2 != null) {
      multipliedString.value = (num1 * num2).toString();
      return multipliedString.value;
    } else {
      multipliedString.value = '0';
      return multipliedString.value;
    }
  }

  Future<void> showTextForDuration(BuildContext context, String text,
      {Duration duration = const Duration(seconds: 3)}) async {
    final overlayState = Overlay.of(context);
    final overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          top: screenHeight() - 100,
          left: screenWidth() * 0.3,
          child: Material(
            color: TColors.primary,
            borderRadius: BorderRadius.circular(6),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              child: Text(
                text,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ),
        ));

    overlayState.insert(overlayEntry);
    await Future.delayed(duration);
    overlayEntry.remove();
  }

  String moneyFormatter(String amount) {
    String cleanedAmount = amount.replaceAll(RegExp(r'[^\d.,]'), '');

    cleanedAmount = cleanedAmount.replaceAll(',', '');

    if (amount == null || amount.isEmpty) {
      final formatter = NumberFormat("#,##0.00");
      return formatter.format(0);
    }

    if (cleanedAmount.isEmpty || cleanedAmount == '.' || cleanedAmount == ',') {
      return '0.00';
    }

    double? money;
    try {
      money = double.parse(cleanedAmount);
    } catch (e) {
      print('Error parsing amount: $e');
      return '0.00';
    }

    final formatter = NumberFormat("#,##0.00");
    return formatter.format(money);
  }


  @override
  void onClose() {
    super.onClose();
  }
}
