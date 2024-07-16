import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:starter/app.dart';

Future<void> main() async {
    // Ensure that Flutter bindings are initialized
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Preserve the native splash screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Wait 5s before removing the splash screen
  Future.delayed(const Duration(seconds: 2), () {
    FlutterNativeSplash.remove();
  });

  // Run the app
  runApp(const MyApp());
}
