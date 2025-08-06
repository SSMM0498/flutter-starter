import 'package:flutter/material.dart';

import 'package:starter/l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:starter/common/styles/colors.dart';
import 'package:starter/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:starter/usecase/auth/controllers/onboarding/onboarding_controller.dart';
import 'package:starter/usecase/auth/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:starter/usecase/auth/screens/onboarding/widgets/onboarding_logo.dart';
import 'package:starter/usecase/auth/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:starter/usecase/auth/screens/onboarding/widgets/onboarding_page.dart';
import 'package:starter/usecase/auth/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:starter/utils/helper_functions.dart';
import 'package:starter/utils/image_strings.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    final isDark = HelperFunctions.isDarkMode(context);
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: Stack(
        children: [
          const OnboardingLogo(),
          Positioned(
            top: -150,
            right: -250,
            child: CircularContainer(
              backgroundColor: isDark ? AppColors.light.withOpacity(0.2) : AppColors.darkPrimary.withOpacity(0.1),
            ),
          ),
          Positioned(
            bottom: 50,
            left: -200,
            child: CircularContainer(
              backgroundColor: isDark ? AppColors.light.withOpacity(0.2) : AppColors.darkPrimary.withOpacity(0.1),
            ),
          ),
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: [
              OnBoardingPage(
                image: ImageStrings.onBoardingImage1,
                title: localizations.onBoardingPage1Title,
                subTitle: localizations.onBoardingPage1SubTitle,
              ),
              OnBoardingPage(
                image: ImageStrings.onBoardingImage2,
                title: localizations.onBoardingPage2Title,
                subTitle: localizations.onBoardingPage2SubTitle,
              ),
              OnBoardingPage(
                image: ImageStrings.onBoardingImage3,
                title: localizations.onBoardingPage3Title,
                subTitle: localizations.onBoardingPage3SubTitle,
              ),
              OnBoardingPage(
                image: ImageStrings.onBoardingImage4,
                title: localizations.onBoardingPage4Title,
                subTitle: localizations.onBoardingPage4SubTitle,
              ),
            ],
          ),
          const OnBoardingSkip(),
          const OnBoardingDotNavigation(),
          const OnBoardingNextButton(),
        ],
      ),
    );
  }
}
