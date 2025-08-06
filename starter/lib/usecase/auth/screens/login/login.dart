import 'package:flutter/material.dart';
import 'package:starter/l10n/app_localizations.dart';
import 'package:starter/common/styles/sizes.dart';

import 'package:starter/common/styles/spacing_styles.dart';
import 'package:starter/common/widgets/login_signup/form_divider.dart';
import 'package:starter/common/widgets/login_signup/social_buttons.dart';
import 'package:starter/usecase/auth/screens/login/widgets/login_form.dart';
import 'package:starter/usecase/auth/screens/login/widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: SpacingStyles.paddingWithAppBarHeight,
          child: Column(
            children: [
              const LoginHeader(),
              const LoginForm(),
              FormDivider(dividerText: localizations.orSignInWith),
              const SizedBox(height: Sizes.spaceBtwSections),
              const SocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
