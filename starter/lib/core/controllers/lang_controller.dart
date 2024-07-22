import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:starter/common/styles/colors.dart';
import 'package:starter/common/styles/sizes.dart';
import 'package:starter/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:starter/common/widgets/text/section_heading.dart';
import 'package:starter/utils/helper_functions.dart';

class LanguageModel {
  String code;
  String label;

  LanguageModel({
    required this.code,
    required this.label,
  });

  static LanguageModel empty() => LanguageModel(code: '', label: '');
}

class LanguageController extends GetxController {
  var locale = const Locale('en', ''); // Default language
  final availableLanguage = [
    LanguageModel(code: 'en', label: 'English'),
    LanguageModel(code: 'fr', label: 'Français'),
  ];

  void changeLanguage(String languageCode) {
    Locale newLocale = Locale(languageCode, '');
    locale = newLocale;
    update(); // This will trigger a rebuild of GetX builders
    Get.updateLocale(newLocale); // This updates the locale in GetX
  }

  Future<dynamic> selectLanguage(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => SingleChildScrollView(
        padding: const EdgeInsets.all(Sizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeading(title: 'Select Language', showActionButton: false),
            const SizedBox(height: Sizes.spaceBtwSections),
            ...availableLanguage.map(
              ((lang) => Column(
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        onTap: () {
                          changeLanguage(lang.code);
                          Get.back();
                        },
                        leading: RoundedContainer(
                          width: 60,
                          height: 40,
                          backgroundColor: HelperFunctions.isDarkMode(context) ? AppColors.light : AppColors.white,
                          padding: const EdgeInsets.all(Sizes.sm),
                          child: CountryFlag.fromLanguageCode(lang.code),
                        ),
                        title: Text(lang.label),
                        trailing: const Icon(Iconsax.arrow_right_34),
                      ),
                      const SizedBox(height: Sizes.spaceBtwItems / 2),
                    ],
                  )),
            ),
            const SizedBox(height: Sizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}
