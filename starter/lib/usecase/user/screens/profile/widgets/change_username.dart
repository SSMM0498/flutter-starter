import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:starter/common/styles/sizes.dart';
import 'package:starter/l10n/app_localizations.dart';
import 'package:starter/common/widgets/appbar/appbar.dart';
import 'package:starter/usecase/user/controllers/update_username_controller.dart';
import 'package:starter/utils/text_strings.dart';
import 'package:starter/utils/validation.dart';

class ChangeUsername extends StatelessWidget {
  const ChangeUsername({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateUsernameController());
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(localizations.usernameChangeTitle, style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations.usernameChangeSubtitle,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: Sizes.spaceBtwSections),
            Form(
              key: controller.updateUsernameFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.username,
                    validator: (value) => Validator.validateEmptyText(localizations.fieldRequired(localizations.username), value),
                    expands: false,
                    decoration: InputDecoration(
                      labelText: localizations.username,
                      prefixIcon: const Icon(Iconsax.user),
                    ),
                  ),
                  const SizedBox(height: Sizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () => controller.updateUsername(LoaderText(title: localizations.congratulations, message: localizations.usernameUpdated)),
                        child: Text(localizations.save)),
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
