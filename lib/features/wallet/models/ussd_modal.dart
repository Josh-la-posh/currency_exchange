class UssdModel {
  final String reference;
  final String status;
  final String display_text;
  final String ussd_code;


  const UssdModel({
    required this.reference,
    required this.status,
    required this.display_text,
    required this.ussd_code,
  });

  factory UssdModel.fromJson(Map<String, dynamic> json) => UssdModel(
    reference: json['reference'] as String,
    status: json['status'] as String,
    display_text: json['display_text'] as String,
    ussd_code: json['ussd_code'] as String,
  );
}