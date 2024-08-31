import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:starter/common/styles/sizes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starter/common/widgets/app_checkbox/app_checkbox.dart';
import 'package:starter/routes/routes.dart';
import 'package:starter/usecase/auth/controllers/login/login_controller.dart';
import 'package:starter/usecase/auth/screens/password_configuration/forget_password.dart';
import 'package:starter/utils/validation.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final localizations = AppLocalizations.of(context)!;

    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.spaceBtwSections,
        ),
        child: Column(
          children: [
            TextFormField(
              controller: controller.email,
              validator: (value) => Validator.validateField(value, [
                (value) => Validator.validateEmptyText(localizations.fieldRequired(localizations.email), value),
                (value) => Validator.validateEmail(localizations.invalidEmail, value),
              ]),
              decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.direct_right),
                labelText: localizations.email,
              ),
            ),
            const SizedBox(height: Sizes.spaceBtwInputFields),
            Obx(
              () => TextFormField(
                controller: controller.password,
                validator: (value) => Validator.validateEmptyText(localizations.fieldRequired(localizations.password), value),
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.password_check),
                  labelText: localizations.password,
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                    icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye),
                  ),
                ),
              ),
            ),
            const SizedBox(height: Sizes.spaceBtwInputFields / 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => AppCheckbox(
                    label: Text(localizations.rememberMe, style: Theme.of(context).textTheme.labelMedium),
                    value: controller.rememberMe.value,
                    onChanged: (value) => controller.rememberMe.value = !controller.rememberMe.value,
                  ),
                ),
                TextButton(
                  onPressed: () => Get.to(() => const ForgetPassword()),
                  child: Text(localizations.forgotPassword),
                ),
              ],
            ),
            const SizedBox(height: Sizes.spaceBtwInputFields),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.emailAndPasswordSignIn(),
                child: Text(localizations.signIn),
              ),
            ),
            const SizedBox(height: Sizes.spaceBtwItems),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.toNamed(Routes.signup),
                child: Text(localizations.createAccount),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
