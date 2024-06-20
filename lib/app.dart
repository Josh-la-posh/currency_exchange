import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:swappr/features/splash/routes/names.dart';
import 'package:swappr/utils/shared/error_boundary/error_boundary.dart';
import 'package:swappr/utils/shared/loader/global_loader.dart';
import 'package:swappr/utils/themes/theme.dart';

import 'data/modules/app_navigator.dart';
import 'data/provider/root_provider.dart';
import 'data/routes/animate_route.dart';
import 'data/routes/nested_route.dart';
import 'data/routes/routes.dart';
import 'features/authentication/screens/onboarding/onboarding.dart';
import 'features/home/routes/names.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalAppLoader(
      app: ErrorBoundary(
        app: RootProvider(
          app: GetMaterialApp(
            title: 'Swappr',

            // CUSTOM THEME

            themeMode: ThemeMode.system,
            theme: TAppTheme.lightTheme,
            darkTheme: TAppTheme.darkTheme,
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