import 'package:flutter/material.dart';
import 'package:starter/common/styles/sizes.dart';
import 'package:starter/usecase/auth/controllers/onboarding/onboarding_controller.dart';
import 'package:starter/utils/device_utility.dart';


class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: DeviceUtils.getAppBarHeight(),
      right: Sizes.defaultSpace,
      child: TextButton(
        onPressed: () => OnBoardingController.instance.skipPage(),
        child: const Text('Skip'),
      ),
    );
  }
}
