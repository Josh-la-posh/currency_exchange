class FlutterwaveEntity {
  final String status;
  final String message;
  final Map<String, dynamic> meta;


  const FlutterwaveEntity({
    required this.status,
    required this.message,
    required this.meta
  });

  factory FlutterwaveEntity.fromJson(Map<String, dynamic> json) => FlutterwaveEntity(
      status: json['status'] as String,
      message: json['message'] as String,
      meta: json['meta']
  );
}