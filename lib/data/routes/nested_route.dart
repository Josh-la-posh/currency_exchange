import 'package:flutter/material.dart';
import 'package:swappr/features/home/screens/home.dart';
import 'package:swappr/features/profile/routes/names.dart';
import 'package:swappr/features/profile/screens/profile.dart';
import 'package:swappr/features/subscription/routes/names.dart';
import 'package:swappr/features/subscription/screens/subscribe.dart';
import 'package:swappr/features/transaction_history/routes/names.dart';
import 'package:swappr/features/transaction_history/screens/history.dart';

import '../../features/home/routes/names.dart';
import '../../utils/layouts/app_layout.dart';
import 'animate_route.dart';
import 'guard_route.dart';

class NestedNavigator extends StatefulWidget {
  final String? initialRoutePath;
  const NestedNavigator({super.key, this.initialRoutePath});

  @override
  State<NestedNavigator> createState() => _NestedNavigatorState();
}

class _NestedNavigatorState extends State<NestedNavigator> {
  final GlobalKey<NavigatorState> nestedNavigatorKey =
  GlobalKey<NavigatorState>();

  late RouteType currentRoute = RouteType.Home;
  String? currentRoutePathName;

  void initState() {
    super.initState();

    if (widget.initialRoutePath == SUBSCRIPTION_SCREEN_ROUTE) {
      currentRoute = RouteType.Subscribe;
    } else if (widget.initialRoutePath == TRANSACTION_HISTORY_SCREEN_ROUTE) {
      currentRoute = RouteType.History;
    } else if (widget.initialRoutePath == PROFILE_SCREEN_ROUTE) {
      currentRoute = RouteType.Profile;
    } else {
      currentRoute = RouteType.Home;
    }

    currentRoutePathName = widget.initialRoutePath;
  }

  // Widget handleTopBarCenterWidget() {
  //   if (currentRoute == RouteType.Subscribe) {
  //     return medicalHistoryTopBarCenterWidget();
  //   } else if (currentRoute == RouteType.Payments &&
  //       currentRoutePathName == TRANSACTIONS_SCREEN_ROUTE) {
  //     return transactionHistoryTopBarCenterWidget();
  //   } else if (currentRoute == RouteType.Payments &&
  //       currentRoutePathName == PAYMENTS_SCREEN_ROUTE) {
  //     return paymentsIndexScreenTopBarCenterWidget();
  //   }
  //
  //   return SizedBox.shrink();
  // }
  //
  // Widget handleTopBarRightWidget() {
  //   if (currentRoute == RouteType.MedicalHistory) {
  //     return medicalHistoryTopBarRightWidget();
  //   }
  //
  //   return SizedBox.shrink();
  // }
  //
  // Widget handleTopBarLeftWidget() {
  //   if (currentRoute == RouteType.Payments &&
  //       currentRoutePathName == TRANSACTIONS_SCREEN_ROUTE) {
  //     return transactionHistoryTopBarLeftWidget();
  //   }
  //
  //   return SizedBox.shrink();
  // }

  String handleInitialRoute() {
    if (widget.initialRoutePath == SUBSCRIPTION_SCREEN_ROUTE) {
      return SUBSCRIPTION_SCREEN_ROUTE;
    } else if (widget.initialRoutePath == TRANSACTION_HISTORY_SCREEN_ROUTE) {
      return TRANSACTION_HISTORY_SCREEN_ROUTE;
    } else if (widget.initialRoutePath == PROFILE_SCREEN_ROUTE) {
      return PROFILE_SCREEN_ROUTE;
    } else {
      return DASHBOARD_SCREEN_ROUTE;
    }
  }

  void handlePopContext(BuildContext context) {
    nestedNavigatorKey.currentState?.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AppLayout(
        currentRoute: currentRoute,
        currentRoutePathname: currentRoutePathName,
        // showTopBar: currentRoute == RouteType.MedicalHistory ||
        //     currentRoute == RouteType.Payments,
        // topBarCenterWidget: handleTopBarCenterWidget(),
        // topBarRightWidget: [handleTopBarRightWidget()],
        // topBarLeftWidget: handleTopBarLeftWidget(),
        navKey: nestedNavigatorKey,
        layoutBodyColor: Color(0xFFFAFAFAFA),
        childWidget: Navigator(
          key: nestedNavigatorKey,
          initialRoute: handleInitialRoute(),
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case DASHBOARD_SCREEN_ROUTE:
                if (currentRoute != RouteType.Home) {
                  setState(() {
                    currentRoute = RouteType.Home;
                    currentRoutePathName = settings.name;
                  });
                }
                return PageRouteBuilder(
                  settings: settings,
                  pageBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                      ) => HomeScreen(),
                      // AuthGuard(
                      //   doNotPopRoute: true,
                      //   widget: HomeScreen(),
                      // ),
                  transitionsBuilder: TransitionRouteViaSlide,
                );

              case SUBSCRIPTION_SCREEN_ROUTE:
                if (currentRoute != RouteType.Subscribe) {
                  setState(() {
                    currentRoute = RouteType.Subscribe;
                    currentRoutePathName = settings.name;
                  });
                }

                return PageRouteBuilder(
                  settings: settings,
                  pageBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                      ) => SubscribeScreen(),
                      // const AuthGuard(
                      //   widget: SubscribeScreen(),
                      // ),
                  transitionsBuilder: TransitionRouteViaSlide,
                );

              case TRANSACTION_HISTORY_SCREEN_ROUTE:
                if (currentRoute != RouteType.History) {
                  setState(() {
                    currentRoute = RouteType.History;
                    currentRoutePathName = settings.name;
                  });
                }

                return PageRouteBuilder(
                  settings: settings,
                  pageBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                      ) => TransactionHistoryScreen(),
                  // const AuthGuard(
                  //   widget: TransactionHistoryScreen(),
                  // ),
                  transitionsBuilder: TransitionRouteViaSlide,
                );

              case PROFILE_SCREEN_ROUTE:
                if (currentRoute != RouteType.Profile) {
                  setState(() {
                    currentRoute = RouteType.Profile;
                    currentRoutePathName = settings.name;
                  });
                }

                return PageRouteBuilder(
                  settings: settings,
                  pageBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                      ) => ProfileScreen(),
                  // const AuthGuard(
                  //   widget: ProfileScreen(),
                  // ),
                  transitionsBuilder: TransitionRouteViaSlide,
                );

              default:
                return PageRouteBuilder(
                  settings: settings,
                  pageBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                      ) => HomeScreen(),
                      // const AuthGuard(
                      //   doNotPopRoute: true,
                      //   widget: HomeScreen(),
                      // ),
                  transitionsBuilder: TransitionRouteViaSlide,
                );
            }
          },
        ),
      ),
    );
  }
}
