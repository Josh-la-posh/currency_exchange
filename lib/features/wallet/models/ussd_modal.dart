class UssdModel {
  String? reference;
  String? status;
  String? display_text;
  String? ussd_code;


  UssdModel({
    this.reference,
    this.status,
    this.display_text,
    this.ussd_code,
  });

  factory UssdModel.fromJson(Map<String, dynamic> json) => UssdModel(
    reference: json['reference'] as String,
    status: json['status'] as String,
    display_text: json['display_text'] as String,
    ussd_code: json['ussd_code'] as String,
  );
}