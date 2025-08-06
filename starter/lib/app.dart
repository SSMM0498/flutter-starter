import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:starter/bindings.dart';
import 'package:starter/l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:starter/core/controllers/app_settings_controller.dart';
import 'package:starter/routes/app_routes.dart';

import 'common/styles/themes/theme.dart';

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    final appSettingController = Get.put(AppSettingController());

    return GetMaterialApp(
      title: 'Starter',
      debugShowCheckedModeBanner: false,
      themeMode: appSettingController.themeMode, // Use the current theme mode from the controller
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: appSettingController.availableLanguage.map((e) => Locale(e.code)),
      initialBinding: InitialBinding(),

      initialRoute: initialRoute,
      getPages: AppRoutes.pages,
    );
  }
}
