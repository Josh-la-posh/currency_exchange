class DefaultWalletModel {
  String? id, currency, balance, pendingWithdrawals, createdDate, lastModifiedDate;
  bool? isActive;

  DefaultWalletModel({
    this.id,
    this.currency,
    this.balance,
    this.isActive,
    this.pendingWithdrawals,
    this.createdDate,
    this.lastModifiedDate,
  });

  factory DefaultWalletModel.fromJson(Map<String, dynamic> json) => DefaultWalletModel(
    id: json['id'] as String?,
    currency: json['currency'] as String?,
    balance: json['balance'] as String?,
    isActive: json['isActive'] as bool?,
    pendingWithdrawals: json['pendingWithdrawals'] as String?,
    createdDate: json['createdDate'] as String?,
    lastModifiedDate: json['lastModifiedDate'] as String?,
  );
}