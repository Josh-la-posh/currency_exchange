class PaystackModel {
  String? reference;
  String? status;
  String? display_text;
  String? account_name;
  String? account_number;
  Map<String, dynamic>? bank;
  String? account_expires_at;


  PaystackModel({
    this.reference,
    this.status,
    this.display_text,
    this.account_name,
    this.account_number,
    this.bank,
    this.account_expires_at
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