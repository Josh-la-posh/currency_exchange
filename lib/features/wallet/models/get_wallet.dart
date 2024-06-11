import 'package:flutter/material.dart';

class WalletModel{

}

class GetWalletModel {
  String? id, currency, balance, pendingWithdrawals;
  bool? isActive;
  String? createdDate, lastModifiedDate;

  GetWalletModel({
    this.id,
    this.currency,
    this.balance,
    this.isActive,
    this.pendingWithdrawals,
    this.createdDate,
    this.lastModifiedDate,
  });

  factory GetWalletModel.fromJson(Map<String, dynamic> json) {
    return GetWalletModel(
      id: json['id'],
      currency: json['currency'],
      balance: json['balance'],
      isActive: json['isActive'],
      pendingWithdrawals: json['pendingWithdrawals'],
      createdDate: json['createdDate'],
      lastModifiedDate: json['lastModifiedDate'],
    );
  }

}