import 'dart:async';
import 'package:get/get.dart';
import 'package:pouch/data/modules/inactivity_service.dart';
import 'package:pouch/data/modules/reset_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pouch/utils/local_storage/local_storage.dart';
import '../../features/authentication/models/user_model.dart';
import '../../utils/constants/app.dart';

class UserSessionController extends GetxController {
  static UserSessionController get to => Get.find<UserSessionController>();

  final SharedPreferences _storage = LocalStorage.instance.storage;
  var user = UserModel().obs;
  final resetController = ResetControllers();
  var isVerifiedDisplay = false.obs;

  void getIsVerified() {
    isVerifiedDisplay.value = !user.value.isVerified!;
  }

  Future<void> setToken(String accessToken) async {
    await _storage.setString(USER_SESSION_TOKEN, accessToken);
  }

  Future<void> setRefreshToken(String refreshToken) async {
    await _storage.setString(USER_REFRESH_TOKEN, refreshToken);
  }

  Future<void> setUserBiometrics(bool useBiometrics) async {
    await _storage.setBool(USER_BIOMETRIC_ENABLED, useBiometrics);
  }

  Future<void> setDeviceToken(String token) async {
    await _storage.setString(USER_DEVICE_TOKEN, token);
  }

  Future<String?> getAccessToken() async {
    return _storage.getString(USER_SESSION_TOKEN);
  }

  Future<String?> getRefreshToken() async {
    return _storage.getString(USER_REFRESH_TOKEN);
  }

  Future<bool?> getUserBiometrics() async {
    return _storage.getBool(USER_BIOMETRIC_ENABLED);
  }

  Future<String?> getDeviceToken() async {
    return _storage.getString(USER_DEVICE_TOKEN);
  }

  Future<bool> isLoginBool() async {
    String? token = _storage.getString(USER_SESSION_TOKEN);
    return token == null ? false : true;
  }

  // Future<void> routeUserToHomeIfLoggedIn(
  //     AuthController authController,
  //     WalletProvider walletProvider,
  //     TransactionProvider transactionProvider,
  //     OfferProvider offerProvider,
  //     SubscriptionProvider subscriptionProvider,
  //     NotificationProvider notificationProvider
  //     ) async {
  //   final userJson = _storage.getString(USER_DATA);
  //   var isLogin = await isLoginBool();
  //   bool canUserGoDashboard = userJson != null && isLogin;
  //   if (canUserGoDashboard) {
  //     handleBackgroundAppRequest(
  //         user: UserModel.fromJson(json.decode(userJson)),
  //         transactionProvider: transactionProvider,
  //         subscriptionProvider: subscriptionProvider,
  //     );
  //     if (authController.user.value?.address == null) {
  //       Get.to(() => AddAddressDetail(
  //           email: USER_REMEMBER_ME_EMAIL,
  //           password: USER_REMEMBER_ME_PASS,
  //           rememberMe: true
  //       ));
  //     } else {
  //       AppNavigator.instance.navigateToHandler(DASHBOARD_SCREEN_ROUTE);
  //     }
  //   }
  // }

  Future<void> logoutUser({String? logoutMessage = ''}) async {
    clearRememberMeHandler();
    await resetController.clearData();
    if (logoutMessage != '') Get.snackbar('', '$logoutMessage');
  }

  void removeUser() {
    user.value = UserModel();
    _storage.remove(USER_DATA);
  }

  Future<void> setRememberMeHandler({
    required String email,
    required String password,
    bool enabled = true
  }) async {
    await _storage.setBool(USER_REMEMBER_ME_ENABLED, enabled);
    await _storage.setString(USER_REMEMBER_ME_EMAIL, email);
    await _storage.setString(USER_REMEMBER_ME_PASS, password);
  }

  Future<void> clearRememberMeHandler() async {
    await _storage.remove(USER_SESSION_TOKEN);
    await _storage.remove(USER_REFRESH_TOKEN);
  }

  Future<void> removeAccessToken() async {
    await _storage.remove(USER_SESSION_TOKEN);
  }
}
