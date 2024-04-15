import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swappr/data/provider/root_provider.dart';
import 'package:swappr/data/routes/routes.dart';
import 'package:swappr/utils/shared/error_boundary/error_boundary.dart';
import 'package:swappr/utils/shared/loader/global_loader.dart';
import 'package:swappr/utils/themes/theme.dart';

import 'features/authentication/screens/onboarding/onboarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalAppLoader(
      app: ErrorBoundary(
        app: RootProvider(
          app: GetMaterialApp(
            title: 'Swappr',
            // theme: ThemeData(
            //   colorScheme: ColorScheme.fromSeed(
            //       seedColor: Colors.deepPurple
            //   ),
            //   useMaterial3: true,
            // ),

            // CUSTOM THEME

            themeMode: ThemeMode.system,
            theme: TAppTheme.lightTheme,
            darkTheme: TAppTheme.darkTheme,
            debugShowCheckedModeBanner: false,
            home: const OnboardingScreen(),
            routes: routes,
          ),
        ),
      ),
    );
  }
}
