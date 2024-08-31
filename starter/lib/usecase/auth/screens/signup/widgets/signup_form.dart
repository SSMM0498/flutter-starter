import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:starter/common/styles/sizes.dart';
import 'package:starter/usecase/auth/controllers/signup/signup_controller.dart';
import 'package:starter/usecase/auth/screens/signup/widgets/terms_conditions_checkbox.dart';
import 'package:starter/utils/validation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    final localizations = AppLocalizations.of(context)!;

    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) => Validator.validateEmptyText(localizations.fieldRequired(localizations.firstname), value),
                  expands: false,
                  decoration: InputDecoration(
                    labelText: localizations.firstname,
                    prefixIcon: const Icon(Iconsax.user),
                  ),
                ),
              ),
              const SizedBox(width: Sizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) => Validator.validateEmptyText(localizations.fieldRequired(localizations.lastname), value),
                  expands: false,
                  decoration: InputDecoration(
                    labelText: localizations.lastname,
                    prefixIcon: const Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: Sizes.spaceBtwInputFields),
          TextFormField(
            controller: controller.username,
            validator: (value) => Validator.validateEmptyText(localizations.fieldRequired(localizations.username), value),
            expands: false,
            decoration: InputDecoration(
              labelText: localizations.username,
              prefixIcon: const Icon(Iconsax.user_edit),
            ),
          ),
          const SizedBox(height: Sizes.spaceBtwInputFields),
          TextFormField(
            controller: controller.email,
            validator: (value) => Validator.validateField(value, [
              (value) => Validator.validateEmptyText(localizations.fieldRequired(localizations.email), value),
              (value) => Validator.validateEmail(localizations.invalidEmail, value),
            ]),
            decoration: InputDecoration(
              labelText: localizations.email,
              prefixIcon: const Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(height: Sizes.spaceBtwInputFields),
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => Validator.validatePhoneNumber(localizations.fieldRequired(localizations.phoneNumber), value),
            decoration: InputDecoration(
              labelText: localizations.phoneNumber,
              prefixIcon: const Icon(Iconsax.call),
            ),
          ),
          const SizedBox(height: Sizes.spaceBtwInputFields),
          Obx(
            () => TextFormField(
              controller: controller.password,
              validator: (value) => Validator.validateField(value, [
                (value) => Validator.validateEmptyText(localizations.fieldRequired(localizations.password), value),
                (value) => Validator.validatePassword([
                      localizations.passwordMinLength(8),
                      localizations.passwordUppercase,
                      localizations.passwordNumber,
                      localizations.passwordSpecialChar,
                    ], value),
              ]),
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                labelText: localizations.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                  icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye),
                ),
              ),
            ),
          ),
          const SizedBox(height: Sizes.spaceBtwInputFields),
          Obx(
            () => TextFormField(
              controller: controller.confirmPassword,
              validator: (value) => Validator.validateField(value, [
                (value) => Validator.validateEmptyText(localizations.fieldRequired(localizations.password), value),
                (value) => Validator.validatePassword([
                      localizations.passwordMinLength(8),
                      localizations.passwordUppercase,
                      localizations.passwordNumber,
                      localizations.passwordSpecialChar,
                    ], value),
              ]),
              obscureText: controller.hideConfirmPassword.value,
              decoration: InputDecoration(
                labelText: localizations.confirmPassword,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: () => controller.hideConfirmPassword.value = !controller.hideConfirmPassword.value,
                  icon: Icon(controller.hideConfirmPassword.value ? Iconsax.eye_slash : Iconsax.eye),
                ),
              ),
            ),
          ),
          const SizedBox(height: Sizes.spaceBtwInputFields),
          const TermsAndConditionsCheckbox(),
          const SizedBox(height: Sizes.spaceBtwSections),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(SignupTexts(
                passwordConfirmation: localizations.passwordConfirmation,
                passwordConfirmationMessage: localizations.passwordConfirmationMessage,
                acceptPolicy: localizations.acceptPolicy,
                acceptPolicyMessage: localizations.acceptPolicyMessage,
                congratulations: localizations.congratulations,
                congratulationVerifyMail: localizations.congratulationVerifyMail,
              )),
              child: Text(localizations.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
