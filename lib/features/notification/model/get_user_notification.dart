

import 'package:pouch/utils/constants/enums.dart';

class GetUserNotification{
  String? id;
  String? description;
  bool? read;
  bool? delivered;
  String? type;
  String? offerId;
  String? createdDate;
  String? lastModifiedDate;

  GetUserNotification({
    required this.id,
    required this.description,
    required this.read,
    required this.delivered,
    required this.type,
    required this.offerId,
    required this.createdDate,
    required this.lastModifiedDate
  });

  factory GetUserNotification.fromJson(Map<String, dynamic> json) => GetUserNotification(
    id: json['id'] as String,
    description: json['description'] as String,
    read: json['read'] as bool,
    delivered: json['delivered'] as bool,
    type: json['type'] as String,
    offerId: json['offerId'] as String,
    createdDate: json['createdDate'] as String,
    lastModifiedDate: json['lastModifiedDate'] as String,
  );
}