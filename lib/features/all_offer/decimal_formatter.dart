import 'package:flutter/services.dart';

class DecimalTextInputFormatter extends TextInputFormatter {
  final int decimalRange;

  DecimalTextInputFormatter({this.decimalRange = 2})
      : assert(decimalRange > 0);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Ensure the value is a valid decimal number
    if (double.tryParse(newValue.text) == null) {
      return oldValue;
    }

    // Limit the number of decimal places
    final parts = newValue.text.split('.');
    if (parts.length == 2 && parts[1].length > decimalRange) {
      return oldValue;
    }

    return newValue;
  }
}
