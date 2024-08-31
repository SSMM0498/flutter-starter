import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starter/common/styles/colors.dart';
import 'package:starter/common/styles/sizes.dart';
import 'package:starter/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:starter/common/widgets/text/section_heading.dart';
import 'package:country_flags/country_flags.dart';
import 'package:iconsax/iconsax.dart';
import 'package:starter/core/services/local_storage/local_storage.dart';
import 'package:starter/data/models/app_setting.dart';
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

class AppSettingController extends GetxController {
  static AppSettingController get instance => Get.find();
  var themeMode = ThemeMode.system; // Default theme
  var locale = Get.deviceLocale ?? const Locale('fr', ''); // Default language based on device setting
  var fontScaleFactor = 1.0.obs;
  var playingSpeed = 1.0.obs;
  final _storage = LocalStorage();

  final availableLanguage = [
    LanguageModel(code: 'fr', label: 'Français'),
    LanguageModel(code: 'en', label: 'English'),
  ];

  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  Future<void> loadSettings() async {
    final settings = await _storage.getAppSettings();

    if (settings != null) {
      print("⚙️ App settings: ${settings.toJson()}");
      themeMode = settings.theme == ThemeMode.light.toString() ? ThemeMode.light : ThemeMode.dark;
      locale = Locale(settings.language, '');
      fontScaleFactor.value = settings.fontScaleFactor;
      playingSpeed.value = settings.playingSpeed;
      Get.changeThemeMode(themeMode);
      Get.updateLocale(locale);
    } else {
      await _storage.setAppSettings(AppSetting(
        theme: themeMode.toString(),
        language: locale.languageCode,
        fontScaleFactor: fontScaleFactor.value,
        playingSpeed: playingSpeed.value,
      ));
    }
  }

  Future<void> toggleTheme() async {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    update(); // This will trigger a rebuild of GetX builders
    Get.changeThemeMode(themeMode); // This updates the theme mode in GetX
    await _storage.setAppSettings(AppSetting(
      theme: themeMode.toString(),
      language: locale.languageCode,
      fontScaleFactor: fontScaleFactor.value,
      playingSpeed: playingSpeed.value,
    ));
  }

  Future<void> changeLanguage(String languageCode) async {
    locale = Locale(languageCode, '');
    update(); // This will trigger a rebuild of GetX builders
    Get.updateLocale(locale); // This updates the locale in GetX
    await _storage.setAppSettings(AppSetting(
      theme: themeMode.toString(),
      language: locale.languageCode,
      fontScaleFactor: fontScaleFactor.value,
      playingSpeed: playingSpeed.value,
    ));
  }

  Future<void> changeFontScaleFactor(double scaleFactor) async {
    fontScaleFactor.value = double.parse(scaleFactor.toStringAsFixed(1));
    await _storage.setAppSettings(AppSetting(
      theme: themeMode.toString(),
      language: locale.languageCode,
      fontScaleFactor: fontScaleFactor.value,
      playingSpeed: playingSpeed.value,
    ));
  }

  Future<void> changePlayingSpeed(double speed) async {
    playingSpeed.value = double.parse(speed.toStringAsFixed(1));
    update(); // This will trigger a rebuild of GetX builders
    _storage.setAppSettings(AppSetting(
      theme: themeMode.toString(),
      language: locale.languageCode,
      fontScaleFactor: fontScaleFactor.value,
      playingSpeed: playingSpeed.value,
    ));
  }

  Future<dynamic> selectLanguage(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          final localizations = AppLocalizations.of(context)!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(Sizes.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionHeading(title: localizations.selectLanguage, showActionButton: false),
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
          );
        });
  }
}
