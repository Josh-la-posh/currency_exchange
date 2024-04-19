class CreateAccountModel {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String country;
  final String password;

  CreateAccountModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.country,
    required this.password,
  });
}
