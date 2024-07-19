import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starter/common/styles/colors.dart';
import 'package:starter/common/styles/sizes.dart';
import 'package:starter/usecase/auth/controllers/signup/signup_controller.dart';
import 'package:starter/utils/device_utility.dart';
import 'package:starter/utils/helper_functions.dart';

class TermsAndConditionsCheckbox extends StatelessWidget {
  const TermsAndConditionsCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    final dark = HelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SizedBox(
          width: 19,
          height: 19,
          child: Obx(
            () => Checkbox(value: controller.privacyPolicy.value, onChanged: (value) => controller.privacyPolicy.value = !controller.privacyPolicy.value),
          ),
        ),
        const SizedBox(width: Sizes.spaceBtwItems),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "I agree to ",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      DeviceUtils.launchUrl("https://en.wikipedia.org/wiki/Privacy_policy");
                    },
                  text: "Privacy Policy ",
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: dark ? AppColors.white : AppColors.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: dark ? AppColors.white : AppColors.primary,
                      ),
                ),
                TextSpan(
                  text: "and ",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextSpan(
                  text: "Terms of use ",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      DeviceUtils.launchUrl("https://en.wikipedia.org/wiki/Terms_of_service");
                    },
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
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
      ],
    );
  }
}
