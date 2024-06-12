class FlutterwaveModel {
  final String transfer_reference;
  final String transfer_account;
  final String transfer_bank;
  final int account_expiration;
  final String transfer_note;
  final String transfer_amount;
  final String mode;


  const FlutterwaveModel({
    required this.transfer_reference,
    required this.transfer_account,
    required this.transfer_bank,
    required this.account_expiration,
    required this.transfer_note,
    required this.transfer_amount,
    required this.mode
  });

  factory FlutterwaveModel.fromJson(Map<String, dynamic> json) => FlutterwaveModel(
      transfer_reference: json['transfer_reference'] as String,
      transfer_account: json['transfer_account'] as String,
      transfer_bank: json['transfer_bank'],
      account_expiration: json['account_expiration'] as int,
      transfer_note: json['transfer_note'],
      transfer_amount: json['transfer_amount'] as String,
      mode: json['mode']
  );
}