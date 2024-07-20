import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:starter/core/controllers/network_manager.dart';
import 'package:starter/core/controllers/theme_controller.dart';
import 'package:starter/data/repository/user_repository.dart';
import 'package:starter/routes/app_routes.dart';

import 'common/styles/themes/theme.dart';

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
    return GetMaterialApp(
      title: 'Starter',
      debugShowCheckedModeBanner: false,
      themeMode: themeController.themeMode, // Use the current theme mode from the controller
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('fr', ''), // French
      ],
      initialBinding: GeneralBindings(),
      initialRoute: initialRoute,
      getPages: AppRoutes.pages,
    );
  }
}

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(UserRepository());
  }
}