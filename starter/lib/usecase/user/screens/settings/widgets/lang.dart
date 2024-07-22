import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:starter/common/styles/colors.dart';
import 'package:starter/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:starter/core/controllers/lang_controller.dart';

class LanguageSwitcherWidget extends StatelessWidget {
  LanguageSwitcherWidget({super.key});

  final LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return SettingsMenuTile(
      icon: Iconsax.global,
      title: 'Languages',
      subTitle: "Choose the language you know",
      trailing: IconButton(
        icon: const Icon(Iconsax.arrow_right, size: 28, color: AppColors.primary),
        onPressed: () => languageController.selectLanguage(context),
      ),
    );
  }
}
