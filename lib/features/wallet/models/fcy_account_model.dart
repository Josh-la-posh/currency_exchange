
class FcyAccountModel {
  final String id;

  FcyAccountModel({
    required this.id
  });

  factory FcyAccountModel.fromJson(Map<String, dynamic> json) => FcyAccountModel(
    id: json['id'] as String,
  );
}