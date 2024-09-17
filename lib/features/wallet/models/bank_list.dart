class BankListModel {
  int? id;
  String? name, slug, code, longCode, gateway, country, currency, type, createdAt, updatedAt ;
  bool? pay_with_bank, supports_transfer, active, is_deleted;
  
  BankListModel({
    this.id,
    this.name,
    this.slug,
    this.code,
    this.longCode,
    this.gateway,
    this.pay_with_bank,
    this.supports_transfer,
    this.active,
    this.country,
    this.currency,
    this.type,
    this.is_deleted,
    this.createdAt,
    this.updatedAt,
  });

  factory BankListModel.fromJson(Map<String, dynamic> json) => BankListModel(
    id: json['id'] as int?,
    name: json['name'] as String?,
    slug: json['slug'] as String?,
    code: json['code'] as String?,
    longCode: json['longCode'] as String?,
    gateway: json['gateway'] as String?,
    pay_with_bank: json['pay_with_bank'] as bool?,
    supports_transfer: json['supports_transfer'] as bool?,
    active: json['active'] as bool?,
    country: json['country'] as String?,
    currency: json['currency'] as String?,
    type: json['type'] as String?,
    is_deleted: json['is_deleted'] as bool?,
    createdAt: json['createdAt'] as String?,
    updatedAt: json['updatedAt'] as String?,
  );
}