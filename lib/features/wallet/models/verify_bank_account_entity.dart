class VerifyBankAccountEntity {
  bool status;
  final String message;
  final Map<String, dynamic> data;


  VerifyBankAccountEntity({
    required this.status,
    required this.message,
    required this.data
  });

  factory VerifyBankAccountEntity.fromJson(Map<String, dynamic> json) => VerifyBankAccountEntity(
      status: json['status'] as bool,
      message: json['message'] as String,
      data: json['data']
  );
}