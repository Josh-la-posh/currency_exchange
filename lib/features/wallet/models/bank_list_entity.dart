class BankListEntity {
  final bool status;
  final String message;
  final List data;


  const BankListEntity({
    required this.status,
    required this.message,
    required this.data
  });

  factory BankListEntity.fromJson(Map<String, dynamic> json) => BankListEntity(
    status: json['status'] as bool,
    message: json['message'] as String,
    data: json['data']
  );
}