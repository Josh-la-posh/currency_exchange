class DefaultWalletModel {
  String? id, currency, balance, pendingWithdrawals, createdDate, lastModifiedDate;
  final bool isActive;

  DefaultWalletModel({
    required this.id,
    required this.currency,
    required this.balance,
    required this.isActive,
    required this.pendingWithdrawals,
    this.createdDate,
    required this.lastModifiedDate,
  });

  factory DefaultWalletModel.fromJson(Map<String, dynamic> json) => DefaultWalletModel(
    id: json['id'] as String,
    currency: json['currency'] as String,
    balance: json['balance'] as String,
    isActive: json['isActive'] as bool,
    pendingWithdrawals: json['pendingWithdrawals'] as String,
    createdDate: json['createdDate'] as String,
    lastModifiedDate: json['lastModifiedDate'],
  );
}