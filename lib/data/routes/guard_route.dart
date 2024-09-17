import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pouch/data/modules/storage_session_controller.dart';
import 'package:pouch/features/authentication/screens/login/login.dart';
import '../../features/authentication/controllers/auth_controller.dart';

class AuthGuard extends StatelessWidget {
  final authController = Get.find<AuthController>();
  final userSessionController = Get.find<UserSessionController>();
  final Widget widget;
  final bool askIfUserWantToExitApp;
  final bool doNotPopRoute;

  AuthGuard({
    Key? key,
    required this.widget,
    this.askIfUserWantToExitApp = false,
    this.doNotPopRoute = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Obx(() {
      if (authController.user.value.email == null ||
          userSessionController.isLoginBool() == false) {
        userSessionController.logoutUser();
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.cancel, size: 100, color: Colors.red),
                const SizedBox(height: 20),
                const Text('User not logged in'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Get.offAll(() => LoginScreen());
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        );
      }

      return StreamBuilder<InternetStatus>(
        stream: InternetConnection().onStatusChange,
        // stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final connectivityResult = snapshot.data;

            if (connectivityResult == InternetStatus.disconnected) {
              return Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.signal_wifi_off, size: 100, color: Colors.red),
                      const SizedBox(height: 20),
                      const Text('No Internet Connection'),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {

                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (askIfUserWantToExitApp) {
              return WillPopScope(
                onWillPop: () async {
                  return await _showExitConfirmationDialog(context);
                },
                child: widget,
              );
            }

            if (doNotPopRoute) {
              return widget;
            }

            return widget;
          } else {
            // Loading or error state
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      );
    });
  }

  Future<bool> _showExitConfirmationDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit App'),
        content: const Text('Are you sure you want to exit?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    ) ?? false;
  }
}





// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:provider/provider.dart';
// import 'package:pouch/utils/constants/colors.dart';
// import '../../features/authentication/routes/names.dart';
// import '../../utils/shared/error_boundary/error_boundary.dart';
// import '../../utils/shared/notification/snackbar.dart';
// import '../modules/app_navigator.dart';
// import '../modules/session_manager.dart';
// import '../provider/auth_provider.dart';
//
// class AuthGuard extends StatefulWidget {
//   final Widget widget;
//   final bool askIfUserWantToExitApp;
//   final bool doNotPopRoute;
//   AuthGuard({
//     super.key,
//     required this.widget,
//     this.askIfUserWantToExitApp = false,
//     this.doNotPopRoute = false,
//   });
//
//   @override
//   State<AuthGuard> createState() => _AuthGuardState();
// }
//
// class _AuthGuardState extends State<AuthGuard> {
//   bool isOnline = true;
//   late StreamSubscription<ConnectivityResult> _connectivitySubscription;
//
//   @override
//   initState() {
//     super.initState();
//
//     _connectivitySubscription = Connectivity()
//         .onConnectivityChanged
//         .listen((ConnectivityResult result) {
//       if (result == ConnectivityResult.mobile ||
//           result == ConnectivityResult.wifi) {
//         if (isOnline == false) {
//           handleShowCustomToast(message: 'Online');
//         }
//         setState(() {
//           isOnline = true;
//         });
//       } else {
//         setState(() {
//           isOnline = false;
//         });
//         handleShowCustomToast(
//             message: 'Offline',
//             textColor: Colors.white,
//             backgroundColor: Colors.redAccent);
//       }
//     });
//   }
//
//   @override
//   dispose() {
//     _connectivitySubscription.cancel();
//
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var authProvider = Provider.of<AuthProvider>(context);
//     if (authProvider.user == null ||
//         UserSession.instance.isLoginBool() == false) {
//       // Future.delayed(
//       //     const Duration(
//       //       seconds: 1,
//       //     ), () {
//       //   UserSession.instance
//       //       .logoutUser(logoutMessage: 'Session expired, Please logins');
//       // });
//       return Scaffold(
//         backgroundColor: Colors.white,
//         body: Container(
//           padding: const EdgeInsets.all(40),
//           alignment: Alignment.center,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(
//                 width: double.infinity,
//                 child: Icon(Icons.cancel),
//               ),
//               const SizedBox(
//                 height: 40,
//               ),
//               Container(
//                 decoration:
//                 BoxDecoration(borderRadius: BorderRadius.circular(4)),
//                 width: double.infinity,
//                 height: 55,
//                 child: ElevatedButton(
//                   style: ButtonStyle(
//                     backgroundColor:
//                     MaterialStateProperty.all(TColors.primary),
//                     shape: MaterialStateProperty.all(
//                       RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(4.8),
//                       ),
//                     ),
//                   ),
//                   onPressed: () {
//                     UserSession.instance.logoutUser();
//                     AppNavigator.instance
//                         .removeAllNavigateToNavHandler(AUTH_LOGIN_SCREEN_ROUTE);
//                   },
//                   child: const Text(
//                     'Please Login',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Roboto',
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//     return PopScope(
//       canPop:
//       widget.askIfUserWantToExitApp || widget.doNotPopRoute ? false : true,
//       child: ErrorBoundary(app: widget.widget),
//     );
//   }
// }
