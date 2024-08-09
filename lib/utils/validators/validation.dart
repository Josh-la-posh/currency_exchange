

import 'package:pouch/utils/constants/enums.dart';

class TValidator {
  static String? validateName(String? value) {

    // Check for empty field
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty.';
    }

    // Check for minimum name length
    if (value.length < 3) {
      return 'Minimum 3 characters required';
    }

    // Check for special characters
    final nameCharacterCheck = RegExp(r'[!@#$%^&*(),.?":;{}|<>]');
    if (nameCharacterCheck.hasMatch(value)) {
      return 'This field contain special character';
    }

    // Check for numbers
    final nameNumCheck = RegExp(r'[0-9]');
    if (nameNumCheck.hasMatch(value)) {
      return 'This field cannot contain numbers';
    }

    // // Check for spaces
    final nameSpaceCheck = RegExp(r'[ ]');
    if (nameSpaceCheck.hasMatch(value)) {
      return 'This field cannot contain spaces';
    }

    return null;

  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }
    
    // Regular expression for email validation
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    // Regular expression for phone number validation (assuming a 10-digit phone number format)
    final phoneRegExp = RegExp(r'^\d{10}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number format (10 digits required).';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    // Check for minimum password length
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }

    // Check for uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter.';
    }

    // Check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }

    // Check for special characters
    if (value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password cannot have special character.';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value1, String? value2) {
    if (value1 == null || value1.isEmpty) {
      return 'Confirm your password';
    }

    // Check for minimum password length
    if (value1 != value2) {
      return 'Password do not match';
    }
    return null;
  }

  static String? validateLoginPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
  }

  static String? otpValidator(String? value) {

    if (value == null || value.isEmpty) {
      return 'Enter the code sent to your email';
    }
    if (value.length < 6) {
      return 'OTP code length must be 6 characters';
    }

    if (value.length > 6) {
      return 'OTP code length must be 6 characters';
    }

    // Check for numbers
    if (value.contains(RegExp(r'[A-Za-z]'))) {
      return 'OTP code must contain only numbers';
    }
    return null;
  }

  static String? numValidator(String? val) {
    final letterCheck = RegExp(r'[0-9]');
    if (val == null || val.isEmpty) {
      return 'Field cannot be empty';
    }
    if (!letterCheck.hasMatch(val)) {
      return 'Field can only contain numbers';
    }
    return null;
  }

  // static String? currencyValidator(Currency? curr) {
  //   if (curr == Currency.NGN) {
  //     return 'Please select a currency';
  //   }
  // }

  static String? acctNumValidator(String? val) {
    final letterCheck = RegExp(r'[0-9]');
    if (val == null || val.isEmpty) {
      return 'Enter your account number';
    }
    if (!letterCheck.hasMatch(val)) {
      return 'Field can only contain numbers';
    }

    final numRegExp = RegExp(r'^\d{10}$');

    if (!numRegExp.hasMatch(val)) {
      return 'Enter a correct account number (10 digits required).';
    }


    return null;
  }

  static String? withdrawalValidator(String? val, double val2) {
    final letterCheck = RegExp(r'[0-9]');
    if (val == null || val.isEmpty) {
      return 'Enter an amount';
    }
    if (!letterCheck.hasMatch(val)) {
      return 'Field can only contain numbers';
    }
    if (double.parse(val) > (val2)) {
      return 'Amount can\'t be greater than available balance';
    }
    if (double.parse(val) < 1) {
      return 'Amount must not be less than 1';
    }
    return null;
  }

  static String? bankValidator(Bank? bank) {
    if (bank == '') {
      return 'Please select your preferred bank';
    }
    return null;
  }

  static String? foreignBankValidator(ForeignBank? bank) {
    if (bank == '') {
      return 'Please select your preferred currency';
    }
    return null;
  }

  static String? emptyFieldValidator(String? value) {
    // Check for empty field
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty.';
    }

    return null;

  }
}