import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:starter/l10n/app_localizations.dart';
import 'package:starter/common/styles/sizes.dart';
import 'package:starter/common/widgets/appbar/appbar.dart';
import 'package:starter/common/widgets/images/circular_image.dart';
import 'package:starter/common/widgets/shimmers/shimmer.dart';
import 'package:starter/common/widgets/text/section_heading.dart';
import 'package:starter/usecase/user/controllers/update_gender_controller.dart';
import 'package:starter/usecase/user/controllers/user_controller.dart';
import 'package:starter/usecase/user/screens/profile/widgets/change_email.dart';
import 'package:starter/usecase/user/screens/profile/widgets/change_phone_number.dart';
import 'package:starter/usecase/user/screens/profile/widgets/change_username.dart';
import 'package:starter/usecase/user/screens/profile/widgets/change_name.dart';
import 'package:starter/usecase/user/screens/profile/widgets/profile_menu.dart';
import 'package:starter/utils/formatter.dart';
import 'package:starter/utils/image_strings.dart';
import 'package:starter/utils/text_strings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    final genderController = Get.put(UpdateGenderController());
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustomAppBar(
        title: Text(localizations.profile),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final networkImage = controller.user.value.profilePicUrl;
                      final image = networkImage != null ? networkImage.toString() : ImageStrings.user;
                      return controller.imageUploading.value
                          ? const CustomShimmerEffect(width: 80, height: 80, radius: 80)
                          : CircularImage(image: image, width: 80, height: 80, isNetworkImage: networkImage != null);
                    }),
                    TextButton(
                      onPressed: () =>
                          controller.uploadUserProfilePicture(LoaderText(title: localizations.congratulations, message: localizations.profileImage)),
                      child: Text(localizations.changeProfilePicture),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Sizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: Sizes.spaceBtwItems),
              // Profile Information
              SectionHeading(title: localizations.profileInformation, showActionButton: false),
              const SizedBox(height: Sizes.spaceBtwItems),
              Obx(
                () => ProfileMenu(
                  title: localizations.name,
                  value: controller.user.value.fullName,
                  onPressed: () => Get.to(() => const ChangeName()),
                ),
              ),
              Obx(
                () => ProfileMenu(
                  title: localizations.username,
                  value: controller.user.value.username,
                  onPressed: () => Get.to(() => const ChangeUsername()),
                ),
              ),
              const SizedBox(height: Sizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: Sizes.spaceBtwItems),
              // Personal Information
              SectionHeading(title: localizations.personalInformation, showActionButton: false),
              const SizedBox(height: Sizes.spaceBtwItems),
              Obx(
                () => ProfileMenu(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: controller.user.value.id!));
                  },
                  title: localizations.userID,
                  value: controller.user.value.id!,
                  icon: Iconsax.copy,
                ),
              ),
              Obx(
                () => ProfileMenu(
                  title: localizations.email,
                  value: controller.user.value.email,
                  onPressed: () => Get.to(() => const ChangeEmail()),
                ),
              ),
              Obx(
                () => ProfileMenu(
                  title: localizations.phone,
                  value: controller.user.value.phoneNumber,
                  onPressed: () => Get.to(() => const ChangePhoneNumber()),
                ),
              ),
              Obx(
                () => ProfileMenu(
                  title: localizations.gender,
                  value: controller.user.value.gender != null
                      ? Formatter.formatTitleCase(controller.user.value.gender.toString().split('.').last)
                      : localizations.noSet,
                  onPressed: () {
                    genderController.selectGender(context);
                  },
                ),
              ),
              Obx(
                () => ProfileMenu(
                  title: localizations.dateOfBirth,
                  value: controller.user.value.dateOfBirth != null ? controller.user.value.dateOfBirth.toString() : localizations.noSet,
                  onPressed: () {},
                ),
              ),
              const Divider(),
              const SizedBox(height: Sizes.spaceBtwItems),
              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: Text(localizations.closeAccount, style: const TextStyle(color: Colors.red)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
