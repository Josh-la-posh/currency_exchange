import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:pouch/data/modules/reset_controllers.dart';
import 'package:pouch/features/authentication/screens/add_details/add_address_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pouch/data/modules/app_navigator.dart';
import 'package:pouch/data/modules/background_task.dart';
import 'package:pouch/data/provider/subscription_provider.dart';
import 'package:pouch/data/provider/transaction_provider.dart';
import 'package:pouch/features/authentication/routes/names.dart';
import 'package:pouch/features/home/routes/names.dart';
import 'package:pouch/utils/loader.dart';
import 'package:pouch/utils/local_storage/local_storage.dart';

import '../../utils/constants/app.dart';
import '../provider/auth_provider.dart';

class UserSession {
  static final UserSession _instance = UserSession._();

  UserSession._();

  static UserSession get instance => _instance;

  final SharedPreferences _storage = LocalStorage.instance.storage;
  final resetController = ResetControllers();

  setToken(String accessToken) async {
    _storage.setString(USER_SESSION_TOKEN, accessToken);
  }

  Future<String?> getAccessToken() async {
    return _storage.getString(USER_SESSION_TOKEN);
  }

  Future<bool> isLoginBool() async {
    String? token = _storage.getString(USER_SESSION_TOKEN);
    return token == null ? false : true;
  }

  routeUserToHomeIfLoggedIn(
      AuthProvider authProvider,
      TransactionProvider transactionProvider,
      SubscriptionProvider subscriptionProvider,
      ) async {
    final userJson = _storage.getString(USER_DATA);
    var isLogin = await UserSession.instance.isLoginBool();
    bool canUserGoDashboard = userJson != null && isLogin == true;
    if (canUserGoDashboard) {
      // handleBackgroundAppRequest(
      //     user: UserModel.fromJson(json.decode(userJson)),
      //     transactionProvider: transactionProvider,
      //     subscriptionProvider: subscriptionProvider,
      // );
      if (authProvider.user?.address == null) {
        Get.to(() => AddAddressDetail(
            email: USER_REMEMBER_ME_EMAIL,
            password: USER_REMEMBER_ME_PASS,
            rememberMe: true
        ));
      } else {
        AppNavigator.instance.navigateToHandler(DASHBOARD_SCREEN_ROUTE);
      }
    }
  }

  handleIfUserIsNotLoginAfterSplashScreen() async {
    AppNavigator.instance.navigateToHandler(AUTH_ONBOARDING_SCREEN_ROUTE);
  }

  Future<bool> checkAuthOnboardingScreenStatus() async {
    return _storage.getBool(HIDE_AUTH_ONBOARDING_SCREEN) == true ? true : false;
  }

  disableAuthOnboardingScreen() async {
    _storage.setBool(HIDE_AUTH_ONBOARDING_SCREEN, true);
  }

  logoutUser({String? logoutMessage = ''}) async {
    _storage.remove(USER_SESSION_TOKEN);
    AppNavigator.instance.resetProviders();
    await resetController.clearData();
    // AppNavigator.instance.removeAllNavigateToNavHandler(AUTH_LOGIN_SCREEN_ROUTE);
    Get.snackbar('', "You've successfully logged out of pouch. We hope to see you again soon.");
//     handleShowCustomToast(
//         message: logoutMessage ??
//             '''You've successfully logged out of pouch.
// We hope to see you again soon.''');
  }

  setRememberMeHandler({
    required String email,
    required String password,
    bool enabled = true
  }) async {
    _storage.setBool(USER_REMEMBER_ME_ENABLED, enabled);
    _storage.setString(USER_REMEMBER_ME_EMAIL, email);
    _storage.setString(USER_REMEMBER_ME_PASS, password);
  }

  getRememberMeHandler(
      Function(String? email, String? password, bool? enabled)
        getUserPreviousDetails
      ) async {
    handleShowLoader();

    getUserPreviousDetails(
      _storage.getString(USER_REMEMBER_ME_EMAIL),
      _storage.getString(USER_REMEMBER_ME_PASS),
      _storage.getBool(USER_REMEMBER_ME_ENABLED),
    );
    handleHideLoader();
  }

  clearRememberMeHandler() async {
    _storage.remove(USER_REMEMBER_ME_EMAIL);
    _storage.remove(USER_REMEMBER_ME_PASS);
  }
}