class TransactionEntity {
   String id;
   String? transactionId;
   String? creditedCurrency;
   String? debitedCurrency;
   String? description;
   String? amount;
   String? debitedAmount;
   String? transactionType;
   String? rate;
   String? rateDescription;
   String? creditedWallet;
   String? debitedWallet;
   String? createdDate;
   String? status;
   String? lastModifiedDate;

  TransactionEntity({
    required this.id,
    required this.transactionId,
    required this.creditedCurrency,
    required this.debitedCurrency,
    required this.description,
    required this.amount,
    required this.debitedAmount,
    required this.transactionType,
    required this.rate,
    required this.rateDescription,
    required this.creditedWallet,
    required this.debitedWallet,
    required this.createdDate,
    required this.status,
    required this.lastModifiedDate,
  });

  factory TransactionEntity.fromJson(Map<String, dynamic> json) => TransactionEntity(
    id: json['id'] as String,
    transactionId: json['transactionId'] as String?,
    creditedCurrency: json['creditedCurrency'] as String?,
    debitedCurrency: json['debitedCurrency'] as String?,
    description: json['description'] as String?,
    amount: json['amount'] as String?,
    debitedAmount: json['debitedAmount'] as String?,
    transactionType: json['transactionType'] as String?,
    rate: json['rate'] as String?,
    rateDescription: json['rateDescription'] as String?,
    creditedWallet: json['creditedWallet'] as String?,
    debitedWallet: json['debitedWallet'] as String?,
    createdDate: json['createdDate'] as String?,
    status: json['status'] as String?,
    lastModifiedDate: json['lastModifiedDate'] as String?,
  );
}