import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../utils/shared/notification/snackbar.dart';

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

    // _connectivitySubscription = Connectivity()
    //     .onConnectivityChanged
    //     .listen((ConnectivityResult result) {
    //   if (result == ConnectivityResult.mobile ||
    //       result == ConnectivityResult.wifi) {
    //     if (isOnline == false) {
    //       handleShowCustomToast(message: 'Online');
    //     }
    //     setState(() {
    //       isOnline = true;
    //     });
    //   } else {
    //     setState(() {
    //       isOnline = false;
    //     });
    //     handleShowCustomToast(
    //         message: 'Offline',
    //         textColor: Colors.white,
    //         backgroundColor: Colors.redAccent);
    //   }
    // } as void Function(List<ConnectivityResult> event)?);
  }

  @override
  dispose() {
    _connectivitySubscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var authProvider = Provider.of<AuthProvider>(context);
    // if (authProvider.user == null ||
    //     UserSession.instance.isLoginBool() == false) {
    //   Future.delayed(
    //       Duration(
    //         seconds: 1,
    //       ), () {
    //     UserSession.instance
    //         .logoutUser(logoutMessage: 'Session expired, Please login');
    //   });
      return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.all(40),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                child: Image.asset('lib/assets/illustration/unauthorized.jpg'),
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
                    MaterialStateProperty.all(Color(0xFF1B88DF)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.8),
                      ),
                    ),
                  ),
                  onPressed: () {
                    // UserSession.instance.logoutUser();
                    // AppNavigator.instance
                    //     .removeAllNavigateToNavHandler(AUTH_LOGIN_SCREEN_ROUTE);
                  },
                  child: const Text(
                    'Please Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Avenir',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    // }
    // return PopScope(
    //   canPop:
    //   widget.askIfUserWantToExitApp || widget.doNotPopRoute ? false : true,
    //   child: ErrorBoundary(app: widget.widget),
    // );
  }
}
