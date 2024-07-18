import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:starter/common/styles/colors.dart';
import 'package:starter/common/styles/sizes.dart';
import 'package:starter/usecase/auth/controllers/login/login_controller.dart';
import 'package:starter/utils/image_strings.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () => controller.googleSignIn(),
            icon: const Image(
              width: Sizes.iconMd,
              height: Sizes.iconMd,
              image: AssetImage(ImageStrings.google),
            ),
          ),
        ),
        const SizedBox(width: Sizes.spaceBtwItems),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            // TODO: Implement Facebook Signin
            onPressed: () {},
            icon: const Image(
              width: Sizes.iconMd,
              height: Sizes.iconMd,
              image: AssetImage(ImageStrings.facebook),
            ),
          ),
        ),
      ],
    );
  }
}
