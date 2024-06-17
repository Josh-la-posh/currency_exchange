
class GetBankAccountModel {
  String id, accountNumber, accountName, bankName, currency, type, bankCode, recipientCode, createdDate, lastModifiedDate;

  GetBankAccountModel({
    required this.id,
    required this.accountNumber,
    required this.accountName,
    required this.bankName,
    required this.currency,
    required this.type,
    required this.bankCode,
    required this.recipientCode,
    required this.createdDate,
    required this.lastModifiedDate
  });

  factory GetBankAccountModel.fromJson(Map<String, dynamic> json) {
    return GetBankAccountModel(
      id: json['id'],
      accountNumber: json['accountNumber'],
      accountName: json['accountName'],
      bankName: json['bankName'],
      currency: json['currency'],
      type: json['type'],
      bankCode: json['bankCode'],
      recipientCode: json['recipientCode'],
      createdDate: json['createdDate'],
      lastModifiedDate: json['lastModifiedDate'],
    );
  }

}