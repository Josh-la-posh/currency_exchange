class UssdEntity {
  final bool status;
  final String message;
  final Map<String, dynamic> data;


  const UssdEntity({
    required this.status,
    required this.message,
    required this.data
  });

  factory UssdEntity.fromJson(Map<String, dynamic> json) => UssdEntity(
      status: json['status'] as bool,
      message: json['message'] as String,
      data: json['data']
  );
}