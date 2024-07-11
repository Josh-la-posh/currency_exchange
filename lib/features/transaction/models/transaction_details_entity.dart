import 'package:pouch/features/transaction/models/transaction_entity.dart';

class TransactionsDetailsEntity {
  int? totalPages;
  int? payloadSize;
  bool? hasNext;
  List content;
  int? currentPage;
  int? skippedRecords;
  int? totalRecords;

  TransactionsDetailsEntity({
    required this.totalPages,
    required this.payloadSize,
    required this.hasNext,
    required this.content,
    required this.currentPage,
    required this.skippedRecords,
    required this.totalRecords,
  });

  factory TransactionsDetailsEntity.fromJson(Map<String, dynamic> json) => TransactionsDetailsEntity(
    totalPages: json['totalPages'] as int,
    payloadSize: json['payloadSize'] as int,
    hasNext: json['hasNext'] as bool,
    content: json['content'],
    currentPage: json['currentPage'] as int,
    skippedRecords: json['skippedRecords'] as int,
    totalRecords: json['totalRecords'] as int,
  );
}