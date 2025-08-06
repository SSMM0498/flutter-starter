import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:starter/common/styles/sizes.dart';
import 'package:starter/l10n/app_localizations.dart';
import 'package:starter/common/widgets/appbar/appbar.dart';
import 'package:starter/usecase/user/controllers/update_email_controller.dart';
import 'package:starter/utils/validation.dart';

class ChangeEmail extends StatelessWidget {
  const ChangeEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateEmailController());
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(localizations.emailChangeTitle, style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations.emailChangeSubtitle,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: Sizes.spaceBtwSections),
            Form(
              key: controller.updateEmailFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.email,
                    validator: (value) => Validator.validateField(value, [
                      (value) => Validator.validateEmptyText(localizations.fieldRequired(localizations.email), value),
                      (value) => Validator.validateEmail(localizations.invalidEmail, value),
                    ]),
                    expands: false,
                    decoration: InputDecoration(
                      labelText: localizations.email,
                      prefixIcon: const Icon(Iconsax.user),
                    ),
                  ),
                  const SizedBox(height: Sizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () => controller.updateEmail(), child: Text(localizations.save)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
