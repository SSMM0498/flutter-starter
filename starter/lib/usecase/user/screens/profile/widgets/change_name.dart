import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starter/l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:starter/common/styles/sizes.dart';
import 'package:starter/common/widgets/appbar/appbar.dart';
import 'package:starter/usecase/user/controllers/update_name_controller.dart';
import 'package:starter/utils/text_strings.dart';
import 'package:starter/utils/validation.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(localizations.nameChangeTitle, style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations.nameChangeSubtitle,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: Sizes.spaceBtwSections),
            Form(
              key: controller.updateUserNameFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.firstName,
                    validator: (value) => Validator.validateEmptyText(localizations.fieldRequired(localizations.firstname), value),
                    expands: false,
                    decoration: InputDecoration(labelText: localizations.firstname, prefixIcon: const Icon(Iconsax.user)),
                  ),
                  const SizedBox(height: Sizes.spaceBtwInputFields),
                  TextFormField(
                    controller: controller.lastName,
                    validator: (value) => Validator.validateEmptyText(localizations.fieldRequired(localizations.lastname), value),
                    expands: false,
                    decoration: InputDecoration(labelText: localizations.lastname, prefixIcon: const Icon(Iconsax.user)),
                  ),
                  const SizedBox(height: Sizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () => controller.updateUserName(LoaderText(title: localizations.congratulations, message: localizations.nameUpdated)),
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
