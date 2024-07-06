import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:swappr/data/modules/app_navigator.dart';
import 'package:swappr/data/modules/session_manager.dart';
import 'package:swappr/data/provider/auth_provider.dart';
import 'package:swappr/features/authentication/screens/login/widgets/login_form.dart';
import 'package:swappr/features/authentication/screens/onboarding/onboarding.dart';
import 'package:swappr/utils/layouts/auth_layout.dart';

import '../../../home/routes/names.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  bool _rememberMe = false;
  bool isLoading = true;

  var authProvider = Provider.of<AuthProvider>(
    AppNavigator.instance.navigatorKey.currentContext as BuildContext
  );

  @override
  void initState() {
    UserSession.instance.getRememberMeHandler((email, password, enabled) {
      if (enabled == true) {
        setState(() {
          _email = email;
          _password = null;
          _rememberMe = true;
          isLoading = false;
        });
      } else {
        _email = null;
        _password = null;
        _rememberMe = false;
        isLoading = false;
      }
    });

    UserSession.instance.isLoginBool().then((value) {
      if (value == true && authProvider.user != null) {
        AppNavigator.instance
            .removeAllNavigateToNavHandler(DASHBOARD_SCREEN_ROUTE);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      onTap: () {
        Get.to(() => const OnboardingScreen());
      },
        heading: 'Log In',
        title: 'Welcome Back!',
        child: LoginForm(
            email: _email,
            password: _password,
            rememberMe: _rememberMe));
  }
}

