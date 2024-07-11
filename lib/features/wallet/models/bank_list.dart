class BankListModel {
  final int id;
  String? name, slug, code, longCode, gateway, country, currency, type, createdAt, updatedAt ;
  bool? pay_with_bank, supports_transfer, active, is_deleted;
  
  BankListModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.code,
    required this.longCode,
    this.gateway,
    required this.country,
    required this.currency,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.pay_with_bank,
    required this.supports_transfer,
    required this.active, 
    required this.is_deleted, 
  });

  factory BankListModel.fromJson(Map<String, dynamic> json) => BankListModel(
    id: json['id'] as int,
    name: json['name'] as String,
    slug: json['slug'] as String,
    code: json['code'] as String,
    longCode: json['longCode'] as String,
    gateway: json['gateway'],
    pay_with_bank: json['pay_with_bank'] as bool,
    supports_transfer: json['supports_transfer'] as bool,
    active: json['active'] as bool,
    country: json['country'] as String,
    currency: json['currency'] as String,
    type: json['type'] as String,
    is_deleted: json['is_deleted'] as bool,
    createdAt: json['createdAt'] as String,
    updatedAt: json['updatedAt'] as String,
  );
}