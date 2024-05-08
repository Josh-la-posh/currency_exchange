import 'package:swappr/features/transaction/models/transaction_entity.dart';

class SubscriptionDetailsEntity {
  final int currentPage;
  final int skippedRecords;
  final int totalPages;
  final bool hasNext;
  final List content;
  final int payloadSize;
  final int totalRecords;

  SubscriptionDetailsEntity({
    required this.currentPage,
    required this.skippedRecords,
    required this.totalPages,
    required this.hasNext,
    required this.content,
    required this.payloadSize,
    required this.totalRecords,
  });

  factory SubscriptionDetailsEntity.fromJson(Map<String, dynamic> json) => SubscriptionDetailsEntity(
    currentPage: json['currentPage'] as int,
    skippedRecords: json['skippedRecords'] as int,
    totalPages: json['totalPages'] as int,
    hasNext: json['hasNext'] as bool,
    content: json['content'],
    payloadSize: json['payloadSize'] as int,
    totalRecords: json['totalRecords'] as int,
  );
}