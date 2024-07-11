import 'package:pouch/features/transaction/models/transaction_entity.dart';

class GetFcyAccountEntity {
  final int currentPage;
  final int skippedRecords;
  final int totalPages;
  final bool hasNext;
  final List content;
  final int payloadSize;
  final int totalRecords;

  GetFcyAccountEntity({
    required this.currentPage,
    required this.skippedRecords,
    required this.totalPages,
    required this.hasNext,
    required this.content,
    required this.payloadSize,
    required this.totalRecords,
  });

  factory GetFcyAccountEntity.fromJson(Map<String, dynamic> json) => GetFcyAccountEntity(
    totalPages: json['totalPages'] as int,
    payloadSize: json['payloadSize'] as int,
    hasNext: json['hasNext'] as bool,
    content: json['content'],
    currentPage: json['currentPage'] as int,
    skippedRecords: json['skippedRecords'] as int,
    totalRecords: json['totalRecords'] as int,
  );
}