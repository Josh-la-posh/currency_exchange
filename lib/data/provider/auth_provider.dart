import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swappr/data/modules/session_manager.dart';
import 'package:swappr/features/authentication/models/create_account_model.dart';
import 'package:swappr/features/authentication/models/password_model.dart';
import 'package:swappr/features/authentication/models/user_model.dart';
import 'package:swappr/utils/constants/app.dart';
import 'package:swappr/utils/local_storage/local_storage.dart';

class AuthProvider extends ChangeNotifier {

  final SharedPreferences _storage = LocalStorage.instance.storage;
  late StreamSubscription<void> _notificationSubscription;

  AuthProvider._() {
    _getUserSaveData();
    _notificationSubscription = Stream.periodic(const Duration(minutes: 5)).listen((event) {
      _processUserNotifications();
    });
  }

  // Singleton instance
  static AuthProvider? _instance;

  // Getter for the singleton instances;
  static AuthProvider get instance {
    _instance ??= AuthProvider._();
    return _instance!;
  }

  @override
  void dispose() {
    _notificationSubscription.cancel();
  }

  Future<void> _processUserNotifications() async {
    bool isUserLoggedIn = await UserSession.instance.isLoginBool();
    if (isUserLoggedIn) {
      getUserNotifications();
    }
  }

  Future<void> _getUserSaveData() async {
    final userJson = _storage.getString(USER_DATA);
    if (userJson != null) {
      if (_user == null) {
        saveUser(UserModel.fromJson(json.decode(userJson)));
      }
    }
  }

  Future<void> getUserNotifications() async {
    if (_user != null) {
      // NotificationService.instance.getNotifications(_user!.id, saveNotifications);
    }
  }

  UserModel? _user;

  UserModel? get user => _user;

  void saveUser(UserModel userInfo) {
    // Save user data in SharedPreferences

    final userJson = json.encode(userInfo.toJson());
    _storage.setString(USER_DATA, userJson);

    _user = userInfo;

    handleCreateAccountCleanups();
    notifyListeners();
    // getUserNotifications();
  }

  void removeUser(){
    _user = null;

    _storage.remove(USER_DATA);
    handleCreateAccountCleanups();
  }

  // creating account
  CreateAccountModel? _createAccountFormDetails;
  bool _createAccountCanVerifyEmail = false;
  String? _createAccountOtpId;

  CreateAccountModel? get createAccountFormDetails => _createAccountFormDetails;
  bool get createAccountCanVerifyEmail => _createAccountCanVerifyEmail;
  String? get createAccountOtpId => _createAccountOtpId;
  bool isVerifiedDisplay = true;

  handleCreateUserEmailConfirmation(
      {required CreateAccountModel formDetails, required String otpId}) {
    _createAccountFormDetails = formDetails;
    _createAccountCanVerifyEmail = true;
    _createAccountOtpId = otpId;
    notifyListeners();
  }

  handleCreateAccountCleanups() {
    _createAccountFormDetails = null;
    _createAccountCanVerifyEmail = false;
    _createAccountOtpId = null;
    notifyListeners();
  }

  // reset password
  ChangePasswordModel? _resetPasswordDetails;

  ChangePasswordModel? get resetPasswordDetails => _resetPasswordDetails;

  saveResetPasswordDetails(ChangePasswordModel resetDetails) {
    _resetPasswordDetails = resetDetails;
    notifyListeners();
  }

  clearResetPasswordDetails() {
    _resetPasswordDetails = null;
    notifyListeners();
  }

  setIsVerifiedDisplay(val) {
    isVerifiedDisplay = val;
    notifyListeners();
  }


}