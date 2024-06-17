class VerifyBankAccountModel {
  String account_number, account_name;
  int bank_id;

  VerifyBankAccountModel({
    required this.account_number,
    required this.account_name,
    required this.bank_id,
  });

  factory VerifyBankAccountModel.fromJson(Map<String, dynamic> json) {
    return VerifyBankAccountModel(
      account_number: json['account_number'] as String,
      account_name: json['account_name'] as String,
      bank_id: json['bank_id'] as int,
    );
  }

}