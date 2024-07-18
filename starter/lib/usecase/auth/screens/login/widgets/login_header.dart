import 'package:flutter/material.dart';
import 'package:starter/common/styles/sizes.dart';
import 'package:starter/utils/helper_functions.dart';
import 'package:starter/utils/image_strings.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image(
              height: Sizes.xl * 1.8,
              image: AssetImage(
                dark ? ImageStrings.logoLight : ImageStrings.logoDark,
              ),
            ),
            const SizedBox(
              width: Sizes.spaceBtwItems,
            ),
            Text(
              "Starter",
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ],
        ),
        const SizedBox(
          height: Sizes.spaceBtwSections,
        ),
        Text(
          "Welcome back",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: Sizes.sm),
        Text(
          "Discover Limitless Choices and Unmatched Convenience.",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
