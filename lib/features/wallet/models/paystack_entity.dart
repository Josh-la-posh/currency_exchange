class PaystackEntity {
  final bool status;
  final String message;
  final Map<String, dynamic> data;


  const PaystackEntity({
    required this.status,
    required this.message,
    required this.data
  });

  factory PaystackEntity.fromJson(Map<String, dynamic> json) => PaystackEntity(
      status: json['status'] as bool,
      message: json['message'] as String,
      data: json['data']
  );
}