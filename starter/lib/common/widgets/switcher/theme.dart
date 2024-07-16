import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starter/core/controllers/theme_controller.dart';

class ThemeSwitcherWidget extends StatelessWidget {
  ThemeSwitcherWidget({Key? key});

  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: themeController.themeMode == ThemeMode.dark,
      onChanged: (bool value) {
        themeController.toggleTheme();
      },
    );
  }
}