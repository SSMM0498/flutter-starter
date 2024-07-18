import 'package:flutter/material.dart';

import 'package:starter/common/styles/sizes.dart';
import 'package:starter/common/widgets/appbar/appbar.dart';
import 'package:starter/common/widgets/login_signup/form_divider.dart';
import 'package:starter/common/widgets/login_signup/social_buttons.dart';
import 'package:starter/usecase/auth/screens/signup/widgets/signup_form.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Let’s create your account",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: Sizes.spaceBtwSections),
              const SignupForm(),
              const SizedBox(height: Sizes.spaceBtwSections),
              const FormDivider(dividerText: "or sign up with"),
              const SizedBox(height: Sizes.spaceBtwSections),
              const SocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
