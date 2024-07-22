import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starter/core/controllers/theme_controller.dart';
import 'package:starter/utils/helper_functions.dart';

class ThemeSwitcherWidget extends StatelessWidget {
  ThemeSwitcherWidget({super.key});

  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: HelperFunctions.isDarkMode(context),
      onChanged: (bool value) => themeController.toggleTheme(),
    );
  }
}
