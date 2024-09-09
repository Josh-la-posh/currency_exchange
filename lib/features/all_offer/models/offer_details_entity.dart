
import 'package:pouch/features/all_offer/models/offer.dart';

class OfferDetailsEntity {
  int? totalPages;
  int? payloadSize;
  bool? hasNext;
  List? content;
  int? currentPage;
  int? skippedRecords;
  int? totalRecords;

  OfferDetailsEntity({
    this.totalPages,
    this.payloadSize,
    this.hasNext,
    this.content,
    this.currentPage,
    this.skippedRecords,
    this.totalRecords,
  });

  factory OfferDetailsEntity.fromJson(Map<String, dynamic> json) => OfferDetailsEntity(
    totalPages: json['totalPages'] as int,
    payloadSize: json['payloadSize'] as int,
    hasNext: json['hasNext'] as bool,
    content: json['content'],
    currentPage: json['currentPage'] as int,
    skippedRecords: json['skippedRecords'] as int,
    totalRecords: json['totalRecords'] as int,
  );
}