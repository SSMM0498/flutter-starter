import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:starter/l10n/app_localizations.dart';
import 'package:starter/common/styles/colors.dart';
import 'package:starter/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:starter/core/controllers/app_settings_controller.dart';

class LanguageSwitcherWidget extends StatelessWidget {
  LanguageSwitcherWidget({super.key});

  final AppSettingController appSettingController = Get.find<AppSettingController>();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return SettingsMenuTile(
      icon: Iconsax.global,
      title: localizations.languages,
      subTitle: localizations.languagesSubtitle,
      trailing: IconButton(
        icon: const Icon(Iconsax.arrow_right, size: 28, color: AppColors.primary),
        onPressed: () => appSettingController.selectLanguage(context),
      ),
    );
  }
}
