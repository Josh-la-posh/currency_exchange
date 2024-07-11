import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:provider/provider.dart';
import 'package:pouch/utils/constants/colors.dart';
import '../../features/authentication/routes/names.dart';
import '../../utils/shared/error_boundary/error_boundary.dart';
import '../../utils/shared/notification/snackbar.dart';
import '../modules/app_navigator.dart';
import '../modules/session_manager.dart';
import '../provider/auth_provider.dart';

class AuthGuard extends StatefulWidget {
  final Widget widget;
  final bool askIfUserWantToExitApp;
  final bool doNotPopRoute;
  const AuthGuard({
    super.key,
    required this.widget,
    this.askIfUserWantToExitApp = false,
    this.doNotPopRoute = false,
  });

  @override
  State<AuthGuard> createState() => _AuthGuardState();
}

class _AuthGuardState extends State<AuthGuard> {
  bool isOnline = true;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  initState() {
    super.initState();

    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        if (isOnline == false) {
          handleShowCustomToast(message: 'Online');
        }
        setState(() {
          isOnline = true;
        });
      } else {
        setState(() {
          isOnline = false;
        });
        handleShowCustomToast(
            message: 'Offline',
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
      }
    });
  }

  @override
  dispose() {
    _connectivitySubscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    if (authProvider.user == null ||
        UserSession.instance.isLoginBool() == false) {
      // Future.delayed(
      //     const Duration(
      //       seconds: 1,
      //     ), () {
      //   UserSession.instance
      //       .logoutUser(logoutMessage: 'Session expired, Please logins');
      // });
      return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.all(40),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: double.infinity,
                child: Icon(Icons.cancel),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(4)),
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(TColors.primary),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.8),
                      ),
                    ),
                  ),
                  onPressed: () {
                    UserSession.instance.logoutUser();
                    AppNavigator.instance
                        .removeAllNavigateToNavHandler(AUTH_LOGIN_SCREEN_ROUTE);
                  },
                  child: const Text(
                    'Please Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return PopScope(
      canPop:
      widget.askIfUserWantToExitApp || widget.doNotPopRoute ? false : true,
      child: ErrorBoundary(app: widget.widget),
    );
  }
}
