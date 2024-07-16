import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  var locale = const Locale('en', ''); // Default language

  void changeLanguage(String languageCode) {
    Locale newLocale = Locale(languageCode, '');
    locale = newLocale;
    update(); // This will trigger a rebuild of GetX builders
    Get.updateLocale(newLocale); // This updates the locale in GetX
  }
}
