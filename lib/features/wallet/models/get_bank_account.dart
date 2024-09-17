
class GetBankAccountModel {
  String? id, accountNumber, accountName, bankName, currency, type, bankCode, recipientCode, createdDate, lastModifiedDate;

  GetBankAccountModel({
    this.id,
    this.accountNumber,
    this.accountName,
    this.bankName,
    this.currency,
    this.type,
    this.bankCode,
    this.recipientCode,
    this.createdDate,
    this.lastModifiedDate
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