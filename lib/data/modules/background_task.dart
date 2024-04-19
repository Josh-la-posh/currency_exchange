import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:swappr/data/modules/interceptor.dart';
import 'package:swappr/data/provider/auth_provider.dart';
import 'package:swappr/features/authentication/models/user_model.dart';

final _apiService = AppInterceptor(showLoader: false).dio;

getUserProfileDetails(AuthProvider authProvider) {
  Future userProfileDetails(){
    return _apiService.get('');
  }

  // userProfileDetails().then(
  //   (value) {
  //     var response = value.data;
  //
  //
  //   }
  // )
}

handleBackgroundAppRequest({
  required UserModel user,
  required AuthProvider authProvider
}) async {
  getUserProfileDetails(authProvider);
}

