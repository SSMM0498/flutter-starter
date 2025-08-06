import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starter/l10n/app_localizations.dart';
import 'package:starter/common/styles/colors.dart';
import 'package:starter/common/styles/sizes.dart';
import 'package:starter/common/widgets/loaders/animation_loader.dart';
import 'package:starter/utils/helper_functions.dart';

class FullScreenLoader {
  static void openLoadingDialog({String? text, required String animation}) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (context) {
        final localizations = AppLocalizations.of(context)!;

        return PopScope(
          canPop: false,
          child: Container(
            color: HelperFunctions.isDarkMode(Get.context!) ? AppColors.dark : AppColors.white,
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                const SizedBox(height: Sizes.xl * 10),
                AnimationLoaderWidget(text: text ?? localizations.pleaseWait, animation: animation),
              ],
            ),
          ),
        );
      },
    );
  }

  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
