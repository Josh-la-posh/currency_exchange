class ResetPasswordModel {
  final String email;
  final String? OTPCode;

  ResetPasswordModel({
    required this.email,
    this.OTPCode
  });
}

class ChangePasswordModel {
  final String currentPassword;
  final String newPassword;

  ChangePasswordModel({
    required this.currentPassword,
    required this.newPassword,
  });
}