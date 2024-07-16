import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  var themeMode = ThemeMode.system; // Default theme

  void toggleTheme() {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    update(); // This will trigger a rebuild of GetX builders
    Get.changeThemeMode(themeMode); // This updates the theme mode in GetX
  }
}
