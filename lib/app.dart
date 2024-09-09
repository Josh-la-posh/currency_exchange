import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pouch/features/splash/routes/names.dart';
import 'package:pouch/utils/shared/error_boundary/error_boundary.dart';
import 'package:pouch/utils/shared/loader/global_loader.dart';
import 'package:pouch/utils/themes/theme.dart';
import 'package:smile_id/smile_id.dart';
import 'package:smile_id/smileid_messages.g.dart';

import 'data/modules/app_navigator.dart';
import 'data/provider/root_provider.dart';
import 'data/routes/animate_route.dart';
import 'data/routes/nested_route.dart';
import 'data/routes/routes.dart';
import 'features/authentication/screens/onboarding/onboarding.dart';
import 'features/home/routes/names.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    SmileID.initialize(
        config: FlutterConfig(
            partnerId: "6951",
            authToken: "KJN217v5KAG6lNRsthGCY0toKbgnyoncCw85m73fztwaCcHIKG0jSCssquLqMMjHGMl5M9bX4K8jX77vPCjcHuE2bDEyLS1MnYG+e+Q69ctWH98zSozgz2EFxpxXVBr59qn2pSWJo27bYf1XaxZgpNUA08b2tjTcWuBv9ES2eR8=",
            prodBaseUrl: "https://api.smileidentity.com/",
            sandboxBaseUrl: "https://testapi.smileidentity.com/"
        ),
        useSandbox: true,
        enableCrashReporting: false
    );

  }

  @override
  Widget build(BuildContext context) {
    return GlobalAppLoader(
      app: ErrorBoundary(
        app: RootProvider(
          app: GetMaterialApp(
            title: 'pouch',
            // CUSTOM THEME
            themeMode: ThemeMode.system,
            theme: TAppTheme.lightTheme,
            // darkTheme: TAppTheme.darkTheme,
            initialRoute: SPLASH_SCREEN_ROUTE,
            routes: routes,
            navigatorKey: AppNavigator.instance.navigatorKey,
            debugShowCheckedModeBanner: false,
            onUnknownRoute: (settings) {
              return MaterialPageRoute(
                builder: (context) => const NestedNavigator(
                  initialRoutePath: DASHBOARD_SCREEN_ROUTE,
                ),
              );
            },
            onGenerateRoute: (settings) {
              if (settings.name is String &&
                  settings.name!.startsWith('/home')) {
                return MaterialPageRoute(
                  builder: (context) => NestedNavigator(
                    initialRoutePath: settings.name,
                  ),
                );
              }
              final WidgetBuilder? builder = routes[settings.name];
              if (builder != null) {
                return PageRouteBuilder(
                  settings: settings,
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      builder(context),
                  transitionsBuilder: TransitionRouteViaSlide,
                );
              }
              return null;
            },
            home: const OnboardingScreen(),
          ),
        ),
      ),
    );
  }
}