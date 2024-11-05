import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/features/splash/routes/names.dart';
import 'package:pouch/utils/bindings/root_bindings.dart';
import 'package:pouch/utils/shared/error_boundary/error_boundary.dart';
import 'package:pouch/utils/shared/loader/global_loader.dart';
import 'package:pouch/utils/themes/theme.dart';
import 'data/routes/routes.dart';
import 'features/authentication/screens/onboarding/onboarding.dart';

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalAppLoader(
      app: ErrorBoundary(
        app: GetMaterialApp(
          title: 'pouch',
          themeMode: ThemeMode.system,
          theme: TAppTheme.lightTheme,
          darkTheme: TAppTheme.darkTheme,
          initialRoute: SPLASH_SCREEN_ROUTE,
          routes: routes,
          initialBinding: RootBindings(),
          debugShowCheckedModeBanner: false,
          home: const OnboardingScreen()
        ),
      ),
    );
  }
}
