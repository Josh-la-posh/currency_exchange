class FlutterwaveModel {
  String? transfer_reference;
  String? transfer_account;
  String? transfer_bank;
  int? account_expiration;
  String? transfer_note;
  String? transfer_amount;
  String? mode;

  FlutterwaveModel({
    this.transfer_reference,
    this.transfer_account,
    this.transfer_bank,
    this.account_expiration,
    this.transfer_note,
    this.transfer_amount,
    this.mode
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