import 'package:pouch/features/transaction/models/transaction_entity.dart';

class GetFcyAccountEntity {
  int? currentPage;
  int? skippedRecords;
  int? totalPages;
  bool? hasNext;
  List? content;
  int? payloadSize;
  int? totalRecords;

  GetFcyAccountEntity({
     this.currentPage,
     this.skippedRecords,
     this.totalPages,
     this.hasNext,
     this.content,
     this.payloadSize,
     this.totalRecords,
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