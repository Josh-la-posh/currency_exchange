// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:swappr/features/home/routes/names.dart';
import 'package:swappr/features/subscription/routes/names.dart';
import 'package:swappr/features/transaction/routes/names.dart';
import 'package:swappr/utils/constants/colors.dart';
import '../../data/modules/app_navigator.dart';
import '../../data/provider/auth_provider.dart';
import '../../features/profile/routes/names.dart';
import '../constants/image_strings.dart';

enum RouteType { Home, Subscribe, History, Profile }

// Routes Path
const HOME_INDEX_SCREEN_ROUTE = DASHBOARD_SCREEN_ROUTE;
const SUBSCRIPTION_INDEX_SCREEN_ROUTE = SUBSCRIPTION_SCREEN_ROUTE;
const TRANSACTION_INDEX_SCREEN_ROUTE = TRANSACTION_HISTORY_SCREEN_ROUTE;
const PROFILE_INDEX_SCREEN_ROUTE = PROFILE_SCREEN_ROUTE;

class AppLayout extends StatefulWidget {
  final RouteType currentRoute;
  final String? currentRoutePathname;
  // final bool showTopBar;
  // final Widget topBarLeftWidget;
  // final Widget topBarCenterWidget;
  // final List<Widget> topBarRightWidget;
  final Widget childWidget;
  // final Color? topBarColor;
  final Color? layoutBodyColor;
  final GlobalKey<NavigatorState>? navKey;
  final Widget? floatingActionButton;

  const AppLayout({
    super.key,
    required this.currentRoute,
    this.currentRoutePathname,
    // this.showTopBar = true,
    // this.topBarLeftWidget = const SizedBox.shrink(),
    // this.topBarRightWidget = const [SizedBox.shrink()],
    // this.topBarCenterWidget = const SizedBox.shrink(),
    // this.topBarColor = Colors.white,
    this.layoutBodyColor = Colors.white,
    required this.childWidget,
    this.navKey,
    this.floatingActionButton
  });

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout>
    with SingleTickerProviderStateMixin {
  // double _appBarTopPadding = 16; // Initial top padding value
  final ScrollController _scrollController = ScrollController();
  bool _isBottomBarVisible = true;

  final List<String> items = List.generate(30, (index) => 'Item ${index + 1}');

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();

    super.dispose();
  }

  void _handleScroll() {
    // final direction = _scrollController.position.userScrollDirection;
    // if (direction == ScrollDirection.reverse && _isBottomBarVisible) {
    //   setState(() {
    //     _isBottomBarVisible = false;
    //   });
    // } else if (direction == ScrollDirection.forward && !_isBottomBarVisible) {
    //   setState(() {
    //     _isBottomBarVisible = true;
    //   });
    // }

    // if (_scrollController.offset <= 100) {
    //   setState(() {
    //     _appBarTopPadding = 16;
    //   });
    // } else {
    //   setState(() {
    //     _appBarTopPadding = 0;
    //   });
    // }
  }

  // var appDrawerProvider = Provider.of<AppDrawerProvider>(
  //     AppNavigator.instance.navigatorKey.currentContext as BuildContext);

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(AppNavigator
        .instance.navigatorKey.currentState?.context as BuildContext);
    return Scaffold(
      backgroundColor: widget.layoutBodyColor,
      bottomNavigationBar: _isBottomBarVisible == false
          ? const SizedBox.shrink()
          : BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        useLegacyColorScheme: false,
        currentIndex: widget.currentRoute == RouteType.Subscribe
            ? 1
            : widget.currentRoute == RouteType.History
            ? 2
            : widget.currentRoute == RouteType.Profile
            ? 3
            : 0,
        selectedFontSize: 12,
        selectedIconTheme: const IconThemeData(size: 24.0),
        unselectedIconTheme: const IconThemeData(size: 24.0),
        unselectedFontSize: 12,
        selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
        unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
        backgroundColor: Colors.white,
        selectedItemColor: TColors.primary,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (index) {
          if (index == 1) {
            // Get.to(const SubscribeScreen());

            if (widget.navKey != null) {
              if (widget.currentRoute != RouteType.Subscribe) {
                widget.navKey!.currentState!
                    .pushNamed(SUBSCRIPTION_INDEX_SCREEN_ROUTE);
              }
            } else {
              AppNavigator.instance.navigateToHandler(
                SUBSCRIPTION_INDEX_SCREEN_ROUTE
              );
            }
          } else if (index == 2) {
            // Get.to(const TransactionHistoryScreen());

            if (widget.navKey != null) {
              if (widget.currentRoute != RouteType.History) {
                widget.navKey!.currentState!
                    .pushNamed(TRANSACTION_INDEX_SCREEN_ROUTE);
              }
            } else {
              AppNavigator.instance.navigateToHandler(
                  TRANSACTION_INDEX_SCREEN_ROUTE
              );
            }
          } else if (index == 3) {
            // Get.to(const ProfileScreen());

            if (widget.navKey != null) {
              if (widget.currentRoute != RouteType.Subscribe) {
                widget.navKey!.currentState!
                    .pushNamed(PROFILE_INDEX_SCREEN_ROUTE);
              }
            } else {
              AppNavigator.instance.navigateToHandler(
                  PROFILE_INDEX_SCREEN_ROUTE
              );
            }
          } else {
            // Get.to(const HomeScreen());

            if (widget.navKey != null) {
              if (widget.currentRoute != RouteType.Home) {
                widget.navKey!.currentState!
                    .pushNamed(HOME_INDEX_SCREEN_ROUTE);
              }
            } else {
                AppNavigator.instance.navigateToHandler(
                    HOME_INDEX_SCREEN_ROUTE
                );
              }

          }
        },
        items: [
          BottomNavigationBarItem(
            tooltip: 'Home',
            icon: Image(image: AssetImage(widget.currentRoute == RouteType.Home
                ? TImages.homeActive
                : TImages.home)),
            label: '',
          ),
          BottomNavigationBarItem(
            tooltip: 'Subscriptions',
            icon: Image(image: AssetImage(widget.currentRoute == RouteType.Subscribe
                ? TImages.subscribeActive
                : TImages.subscribe)),
            label: '',
          ),
          BottomNavigationBarItem(
            tooltip: 'Transactions',
            icon: Image(image: AssetImage(widget.currentRoute == RouteType.History
                ? TImages.historyActive
                : TImages.history)),
            label: '',
          ),
          BottomNavigationBarItem(
            tooltip: 'Profile',
            icon: Image(image: AssetImage(widget.currentRoute == RouteType.Profile
                ? TImages.profileActive
                : TImages.profile)),
            label: '',
          ),
        ],
      ),
      // drawer: AppDrawerWidget(),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        controller: _scrollController,
        child: widget.childWidget,
      ),
      floatingActionButton: widget.floatingActionButton,
    );
  }
}
