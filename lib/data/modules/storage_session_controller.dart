import 'dart:async';
import 'package:get/get.dart';
import 'package:pouch/data/modules/reset_controllers.dart';
import 'package:pouch/features/authentication/controllers/auth_controller.dart';
import 'package:pouch/features/authentication/screens/login/login.dart';
import 'package:pouch/features/authentication/screens/onboarding/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pouch/utils/loader.dart';
import 'package:pouch/utils/local_storage/local_storage.dart';
import '../../utils/constants/app.dart';

class UserSessionController extends GetxController {
  static UserSessionController get to => Get.find<UserSessionController>();

  final SharedPreferences _storage = LocalStorage.instance.storage;
  AuthController get authController => Get.find<AuthController>();
  final resetController = ResetControllers();

  Future<void> setToken(String accessToken) async {
    await _storage.setString(USER_SESSION_TOKEN, accessToken);
  }

  Future<String?> getAccessToken() async {
    return _storage.getString(USER_SESSION_TOKEN);
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

  Future<void> routeUserToHomeIfLoggedIn() async {
    final userJson = _storage.getString(USER_DATA);
    final email = _storage.getString(USER_REMEMBER_ME_EMAIL);
    final password = _storage.getString(USER_REMEMBER_ME_PASS);
    final rememberMe = _storage.getBool(USER_REMEMBER_ME_ENABLED);
    var isLogin = await isLoginBool();
    bool canUserGoDashboard = userJson != null && isLogin == true;
    if (canUserGoDashboard) {
      if (rememberMe == true) {
        authController.login(
            email: email.toString(),
            password: password.toString(),
            rememberMe: true,
            handleEmailNotVerified: (){}
        );
      } else {
        Get.offAll(() => LoginScreen());
      }
    } else {
      Get.offAll(() => OnboardingScreen());
    }
  }

  Future<bool> checkAuthOnboardingScreenStatus() async {
    return _storage.getBool(HIDE_AUTH_ONBOARDING_SCREEN) ?? false;
  }

  Future<void> disableAuthOnboardingScreen() async {
    await _storage.setBool(HIDE_AUTH_ONBOARDING_SCREEN, true);
  }

  Future<void> logoutUser({String? logoutMessage = ''}) async {
    await _storage.remove(USER_SESSION_TOKEN);
    await resetController.clearData();
    Get.snackbar('', "You've successfully logged out of pouch. We hope to see you again soon.");
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

  Future<void> getRememberMeHandler(
      Function(String? email, String? password, bool? enabled) getUserPreviousDetails
      ) async {
    handleShowLoader();
    getUserPreviousDetails(
      _storage.getString(USER_REMEMBER_ME_EMAIL),
      _storage.getString(USER_REMEMBER_ME_PASS),
      _storage.getBool(USER_REMEMBER_ME_ENABLED),
    );
    handleHideLoader();
  }

  Future<void> clearRememberMeHandler() async {
    await _storage.remove(USER_REMEMBER_ME_EMAIL);
    await _storage.remove(USER_REMEMBER_ME_PASS);
  }
}
