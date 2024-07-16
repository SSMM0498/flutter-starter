import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starter/core/controllers/lang_controller.dart';

class LanguageSwitcherWidget extends StatelessWidget {
  LanguageSwitcherWidget({super.key});

  final LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: languageController.locale.languageCode,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        if (newValue != null) {
          languageController.changeLanguage(newValue);
        }
      },
      items: <String>['en', 'fr'] // Add more language codes as needed
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value.toUpperCase()), // Display language codes in uppercase
        );
      }).toList(),
    );
  }
}
