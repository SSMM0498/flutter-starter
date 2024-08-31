
import 'package:flutter/material.dart';
import 'package:starter/common/styles/colors.dart';
import 'package:starter/common/styles/sizes.dart';
import 'package:starter/utils/device_utility.dart';
import 'package:starter/utils/helper_functions.dart';
import 'package:starter/utils/image_strings.dart';
import 'package:starter/utils/text_strings.dart';

class OnboardingLogo extends StatelessWidget {
  const OnboardingLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return Positioned(
      top: DeviceUtils.getAppBarHeight(),
      left: Sizes.defaultSpace,
      child: Row(
        children: [
          Image(
            color: isDark ? AppColors.primary : AppColors.darkPrimary,
            height: Sizes.xl * 1.7,
            image: AssetImage(
              isDark ? ImageStrings.logoLight : ImageStrings.logoDark,
            ),
          ),
          const SizedBox(
            width: Sizes.spaceBtwItems * 0.5,
          ),
          Text(
            TextStrings.appName,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ],
      ),
    );
  }
}
