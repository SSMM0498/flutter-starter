import 'package:flutter/material.dart';
import 'package:starter/common/styles/colors.dart';

import 'package:starter/common/styles/sizes.dart';
import 'package:starter/utils/helper_functions.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.all(Sizes.defaultSpace),
      child: Column(
        children: [
          SizedBox(
            height: HelperFunctions.screenHeight() * 0.125,
          ),
          Image(
            height: HelperFunctions.screenHeight() * 0.5,
            image: AssetImage(image),
            color: dark ? AppColors.light : AppColors.dark,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Sizes.spaceBtwItems),
          Text(
            subTitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
