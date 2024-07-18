
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starter/common/styles/colors.dart';
import 'package:starter/common/styles/sizes.dart';
import 'package:starter/usecase/auth/controllers/signup/signup_controller.dart';
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
