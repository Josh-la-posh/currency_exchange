class TransactionEntity {
  final String id;
  final String transactionId;
  final String creditedCurrency;
  final String debitedCurrency;
  final String description;
  final String amount;
  final String transactionType;
  final String rate;
  final String creditedWallet;
  final String debitedWallet;
  final String createdDate;
  final String status;
  final String lastModifiedDate;

  TransactionEntity({
    required this.id,
    required this.transactionId,
    required this.creditedCurrency,
    required this.debitedCurrency,
    required this.description,
    required this.amount,
    required this.transactionType,
    required this.rate,
    required this.creditedWallet,
    required this.debitedWallet,
    required this.createdDate,
    required this.status,
    required this.lastModifiedDate,
  });

  factory TransactionEntity.fromJson(Map<String, dynamic> json) => TransactionEntity(
    id: json['id'] as String,
    transactionId: json['transactionId'] as String,
    creditedCurrency: json['creditedCurrency'] as String,
    debitedCurrency: json['debitedCurrency'] as String,
    description: json['description'] as String,
    amount: json['amount'] as String,
    transactionType: json['transactionType'] as String,
    rate: json['rate'] as String,
    creditedWallet: json['creditedWallet'] as String,
    debitedWallet: json['debitedWallet'] as String,
    createdDate: json['createdDate'] as String,
    status: json['status'] as String,
    lastModifiedDate: json['lastModifiedDate'] as String,
  );
}