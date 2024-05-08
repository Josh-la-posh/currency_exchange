import 'package:flutter/material.dart';
import 'package:swappr/data/modules/dio.dart';

class ProfileService {
  static final ProfileService _instance = ProfileService._();

  ProfileService._();

  static ProfileService get instance => _instance;


  Future _transactions(){
    return apiService.get(
      '/transaction',
    );
  }

  Future _transaction({required String id}){
    return apiService.get(
      '/transaction/$id',
    );
  }

  
}