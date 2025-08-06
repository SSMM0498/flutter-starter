import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:starter/common/styles/sizes.dart';
import 'package:starter/l10n/app_localizations.dart';
import 'package:starter/common/widgets/appbar/appbar.dart';
import 'package:starter/usecase/user/controllers/update_phone_number_controller.dart';
import 'package:starter/utils/validation.dart';

class ChangePhoneNumber extends StatelessWidget {
  const ChangePhoneNumber({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdatePhoneNumberController());
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(localizations.phoneNumberChangeTitle, style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations.phoneNumberChangeSubtitle,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: Sizes.spaceBtwSections),
            Form(
              key: controller.updatePhoneNumberFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.phoneNumber,
                    validator: (value) => Validator.validatePhoneNumber(localizations.fieldRequired(localizations.phoneNumber), value),
                    expands: false,
                    decoration: InputDecoration(
                      labelText: localizations.phoneNumber,
                      prefixIcon: const Icon(Iconsax.user),
                    ),
                  ),
                  const SizedBox(height: Sizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () => controller.updatePhoneNumber(), child: Text(localizations.save)),
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
