import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starter/usecase/auth/controllers/onboarding/onboarding_controller.dart';
import 'package:starter/usecase/auth/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:starter/usecase/auth/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:starter/usecase/auth/screens/onboarding/widgets/onboarding_page.dart';
import 'package:starter/usecase/auth/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:starter/utils/image_strings.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: ImageStrings.onBoardingImage1,
                title: "Jump into dream",
                subTitle: "Welcome to a World of Limitless Choices!",
              ),
              OnBoardingPage(
                image: ImageStrings.onBoardingImage2,
                title: "Easy to fly more than one",
                subTitle: "For Seamless Transactions - Your Convenience, Our Priority!",
              ),
              OnBoardingPage(
                image: ImageStrings.onBoardingImage3,
                title: "Full power at your seat",
                subTitle: "From Our Doorstep to Yours - Swift, Secure, and Contactless Delivery!",
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
