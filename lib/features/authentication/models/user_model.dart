class LoginModal {
  final String access_token;

  const LoginModal({
    required this.access_token
  });

  Map<String, dynamic> toJson() {
    return {
      'access_token': access_token,
    };
  }

  factory LoginModal.fromJson(Map<String, dynamic> json) {
    return LoginModal(
      access_token: json['access_token'],
    );
  }
}

class RoleModel {
  String? id;
  String? name;
  String? description;
  bool? active;
  String? createdDate;
  String? lastModifiedDate;

   RoleModel({
    this.id,
    this.name,
    this.description,
    this.active,
    this.createdDate,
    this.lastModifiedDate
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'active': active,
      'createdDate': createdDate,
      'lastModifiedDate': lastModifiedDate,
    };
  }

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      active: json['active'],
      createdDate: json['createdDate'],
      lastModifiedDate: json['lastModifiedDate'],
    );
  }

}

class UserModel {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  bool? isVerified;
  String? nin;
  String? country;
  String? address;
  String? postCode;
  String? state;
  String? status;
  String? phoneNumber;
  int? otp;
  int? emailOtp;
  bool? isEmailVerified;
  String? otpExpiration;
  String? createdDate;
  String? lastModifiedDate;
  Map<String,dynamic>? role;

   UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.isVerified,
    this.nin,
    this.country,
    this.address,
    this.postCode,
    this.state,
    this.status,
    this.phoneNumber,
    this.otp,
    this.emailOtp,
    this.isEmailVerified,
    this.otpExpiration,
    this.createdDate,
    this.lastModifiedDate,
    this.role
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
      'address': address,
      'postCode': postCode,
      'state': state,
      'status': status,
      'phoneNumber': phoneNumber,
      'otp': otp,
      'emailOtp': emailOtp,
      'isEmailVerified': isEmailVerified,
      'otpExpiration': otpExpiration,
      'createdDate': createdDate,
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
      address: json['address'],
      postCode: json['postCode'],
      state: json['state'],
      status: json['status'],
      phoneNumber: json['phoneNumber'],
      otp: json['otp'],
      emailOtp: json['emailOtp'],
      isEmailVerified: json['isEmailVerified'],
      otpExpiration: json['otpExpiration'],
      createdDate: json['createdDate'],
      lastModifiedDate: json['lastModifiedDate'],
      role: json['role'],
    );
  }
}