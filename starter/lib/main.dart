import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:starter/routes/routes.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:starter/app.dart';
import 'package:starter/core/controllers/auth_controller.dart';
import 'package:starter/core/services/local_storage/local_storage.dart';
import 'package:starter/core/services/pocketbase/pocketbase.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  // Ensure that Flutter bindings are initialized
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Initialize time zones
  tz.initializeTimeZones();

  // Preserve the native splash screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize PocketBase
  await PocketBaseSingleton().initialize();

  // Initialize the AuthController
  Get.put(AuthController());

  // Determine the initial route
  final PocketBase pb = PocketBaseSingleton().client;
  final auth = pb.authStore;

  var initialRoute = Routes.navigationPanel;
  if (auth.isValid == false) {
    final storage = LocalStorage();
    await storage.setIsFirstTimeIfNull();
    final isFirstTime = await storage.getIsFirstTime();
    if (isFirstTime) {
      initialRoute = Routes.onBoarding;
    } else {
      initialRoute = Routes.login;
    }
    debugPrint("🛣️ >>> $initialRoute");
  }

  // Run the app
  runApp(MyApp(initialRoute: initialRoute));
}
