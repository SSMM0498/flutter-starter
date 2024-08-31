import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starter/common/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starter/common/widgets/app_checkbox/app_checkbox.dart';
import 'package:starter/usecase/auth/controllers/signup/signup_controller.dart';
import 'package:starter/utils/device_utility.dart';
import 'package:starter/utils/helper_functions.dart';

class TermsAndConditionsCheckbox extends StatelessWidget {
  const TermsAndConditionsCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    final localizations = AppLocalizations.of(context)!;
    final dark = HelperFunctions.isDarkMode(context);

    return Obx(
      () => AppCheckbox(
        value: controller.privacyPolicy.value,
        onChanged: (value) => controller.privacyPolicy.value = !controller.privacyPolicy.value,
        label: Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "${localizations.iAgreeTo} ",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      DeviceUtils.launchUrl("https://en.wikipedia.org/wiki/Privacy_policy");
                    },
                  text: "${localizations.privacyPolicy} ",
                  style: Theme.of(context).textTheme.labelMedium!.apply(
                        color: dark ? AppColors.white : AppColors.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: dark ? AppColors.white : AppColors.primary,
                      ),
                ),
                TextSpan(
                  text: "${localizations.and} ",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                TextSpan(
                  text: "${localizations.termsOfUse} ",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      DeviceUtils.launchUrl("https://en.wikipedia.org/wiki/Terms_of_service");
                    },
                  style: Theme.of(context).textTheme.labelMedium!.apply(
                        color: dark ? AppColors.white : AppColors.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: dark ? AppColors.white : AppColors.primary,
                      ),
                ),
              ],
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
