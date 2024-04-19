class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final bool isVerified;
  final String nin;
  final String country;
  final String status;
  final String phoneNumber;
  final int otp;
  final String emailOtp;
  final bool isEmailVerified;
  final String otpExpiration;
  final String currentDate;
  final String lastModifiedDate;
  final String role;

  const UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.isVerified,
    required this.nin,
    required this.country,
    required this.status,
    required this.phoneNumber,
    required this.otp,
    required this.emailOtp,
    required this.isEmailVerified,
    required this.otpExpiration,
    required this.currentDate,
    required this.lastModifiedDate,
    required this.role
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'isVerified': isVerified,
      'nin': nin,
      'country': country,
      'status': status,
      'phoneNumber': phoneNumber,
      'otp': otp,
      'emailOtp': emailOtp,
      'isEmailVerified': isEmailVerified,
      'otpExpiration': otpExpiration,
      'currentDate': currentDate,
      'lastModifiedDate': lastModifiedDate,
      'role': role
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['password'],
      isVerified: json['isVerified'],
      nin: json['nin'],
      country: json['country'],
      status: json['status'],
      phoneNumber: json['phoneNumber'],
      otp: json['otp'],
      emailOtp: json['emailOtp'],
      isEmailVerified: json['isEmailVerified'],
      otpExpiration: json['otpExpiration'],
      currentDate: json['currentDate'],
      lastModifiedDate: json['lastModifiedDate'],
      role: json['role'],
    );
  }
}