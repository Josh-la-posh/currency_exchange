class PaystackModel {
  final String reference;
  final String status;
  final String display_text;
  final String account_name;
  final String account_number;
  final Map<String, dynamic> bank;
  final String account_expires_at;


  const PaystackModel({
    required this.reference,
    required this.status,
    required this.display_text,
    required this.account_name,
    required this.account_number,
    required this.bank,
    required this.account_expires_at
  });

  factory PaystackModel.fromJson(Map<String, dynamic> json) => PaystackModel(
      reference: json['reference'] as String,
      status: json['status'] as String,
      display_text: json['display_text'] as String,
      account_name: json['account_name'] as String,
      account_number: json['account_number'] as String,
      bank: json['bank'],
      account_expires_at: json['account_expires_at'] as String
  );
}