// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pouch/features/home/routes/names.dart';
import 'package:pouch/features/transaction/routes/names.dart';
import 'package:pouch/features/wallet/routes/names.dart';
import 'package:pouch/utils/constants/colors.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import '../../data/modules/app_navigator.dart';
import '../../data/provider/auth_provider.dart';
import '../../features/profile/routes/names.dart';
import '../constants/image_strings.dart';

enum RouteType { Home, Wallet, History, Profile }

// Routes Path
const HOME_INDEX_SCREEN_ROUTE = DASHBOARD_SCREEN_ROUTE;
const WALLET_INDEX_SCREEN_ROUTE = WALLET_SCREEN_ROUTE;
const TRANSACTION_INDEX_SCREEN_ROUTE = TRANSACTION_HISTORY_SCREEN_ROUTE;
const PROFILE_INDEX_SCREEN_ROUTE = PROFILE_SCREEN_ROUTE;

class AppLayout extends StatefulWidget {
  final RouteType currentRoute;
  final String? currentRoutePathname;
  final Widget childWidget;
  final Color? layoutBodyColor;
  final GlobalKey<NavigatorState>? navKey;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? appbar;

  const AppLayout({
    super.key,
    required this.currentRoute,
    this.currentRoutePathname,
    this.layoutBodyColor = Colors.white,
    required this.childWidget,
    this.navKey,
    this.floatingActionButton,
    this.appbar
  });

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool _isBottomBarVisible = true;

  final List<String> items = List.generate(30, (index) => 'Item ${index + 1}');

  @override
  void initState() {
    super.initState();
    // _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    // _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(AppNavigator
        .instance.navigatorKey.currentState?.context as BuildContext);

    final darkMode = THelperFunctions.isDarkMode(context);
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: widget.appbar,
        backgroundColor: widget.layoutBodyColor,
        bottomNavigationBar: _isBottomBarVisible == false
            ? const SizedBox.shrink()
            : BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          useLegacyColorScheme: false,
          currentIndex: widget.currentRoute == RouteType.Wallet
              ? 1
              : widget.currentRoute == RouteType.History
              ? 2
              : widget.currentRoute == RouteType.Profile
              ? 3
              : 0,
          selectedFontSize: 11,
          selectedIconTheme: const IconThemeData(size: 24.0),
          unselectedIconTheme: const IconThemeData(size: 24.0),
          unselectedFontSize: 11,
          selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
          unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
          backgroundColor: darkMode ? Colors.black : Colors.white,
          selectedItemColor: TColors.primary,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: (index) {
            if (index == 1) {
              // Get.to(const SubscribeScreen());
      
              if (widget.navKey != null) {
                if (widget.currentRoute != RouteType.Wallet) {
                  widget.navKey!.currentState!
                      .pushNamed(WALLET_INDEX_SCREEN_ROUTE);
                }
              } else {
                AppNavigator.instance.navigateToHandler(
                  WALLET_INDEX_SCREEN_ROUTE
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
                if (widget.currentRoute != RouteType.Profile) {
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
              icon: SizedBox(
                height: 30,
                child: Image(image: AssetImage(widget.currentRoute == RouteType.Home
                    ? TImages.homeActive
                    : TImages.home)),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                height: 30,
                child: Image(image: AssetImage(widget.currentRoute == RouteType.Wallet
                    ? TImages.subscribeActive
                    : TImages.subscribe)),
              ),
              label: 'Wallet',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                height: 30,
                child: Image(image: AssetImage(widget.currentRoute == RouteType.History
                    ? TImages.historyActive
                    : TImages.history)),
              ),
              label: 'Transactions',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                height: 30,
                child: Image(image: AssetImage(widget.currentRoute == RouteType.Profile
                    ? TImages.profileActive
                    : TImages.profile)),
              ),
              label: 'Profile',
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
      ),
    );
  }
}
