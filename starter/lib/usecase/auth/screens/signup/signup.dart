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
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(
          "Let’s become a member",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SignupForm(),
              SizedBox(height: Sizes.spaceBtwSections),
              FormDivider(dividerText: "or sign up with"),
              SizedBox(height: Sizes.spaceBtwSections),
              SocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
