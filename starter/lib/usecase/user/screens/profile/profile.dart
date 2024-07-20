import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:starter/common/styles/sizes.dart';
import 'package:starter/common/widgets/appbar/appbar.dart';
import 'package:starter/common/widgets/images/circular_image.dart';
import 'package:starter/common/widgets/shimmers/shimmer.dart';
import 'package:starter/common/widgets/text/section_heading.dart';
import 'package:starter/usecase/user/controllers/user_controller.dart';
import 'package:starter/usecase/user/screens/profile/widgets/change_email.dart';
import 'package:starter/usecase/user/screens/profile/widgets/change_phone_number.dart';
import 'package:starter/usecase/user/screens/profile/widgets/change_username.dart';
import 'package:starter/utils/image_strings.dart';

import 'widgets/change_name.dart';
import 'widgets/profile_menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text('Profile'),
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
                      final networkImage = controller.user.profilePicUrl;
                      final image = networkImage != null ? networkImage.toString() : ImageStrings.user;
                      return controller.imageUploading.value
                          ? const CustomShimmerEffect(width: 80, height: 80, radius: 80)
                          : CircularImage(image: image, width: 80, height: 80, isNetworkImage: networkImage != null);
                    }),
                    TextButton(onPressed: () => controller.uploadUserProfilePicture(), child: const Text('Change Profile Picture')),
                  ],
                ),
              ),
              const SizedBox(height: Sizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: Sizes.spaceBtwItems),
              // Profile Information
              const SectionHeading(title: 'Profile Information', showActionButton: false),
              const SizedBox(height: Sizes.spaceBtwItems),
              ProfileMenu(
                title: 'Name',
                value: controller.user.fullName,
                onPressed: () => Get.to(() => const ChangeName()),
              ),
              ProfileMenu(
                title: 'Username',
                value: controller.user.username,
                onPressed: () => Get.to(() => const ChangeUsername()),
              ),
              const SizedBox(height: Sizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: Sizes.spaceBtwItems),
              // Personal Information
              const SectionHeading(title: 'Personal Information', showActionButton: false),
              const SizedBox(height: Sizes.spaceBtwItems),
              ProfileMenu(
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: controller.user.id!));
                },
                title: 'User ID',
                value: controller.user.id!,
                icon: Iconsax.copy,
              ),
              ProfileMenu(
                title: 'E-mail',
                value: controller.user.email,
                onPressed: () => Get.to(() => const ChangeEmail()),
              ),
              ProfileMenu(
                title: 'Phone',
                value: controller.user.phoneNumber,
                onPressed: () => Get.to(() => const ChangePhoneNumber()),
              ),
              ProfileMenu(
                title: 'Gender',
                value: controller.user.gender != null ? controller.user.gender.toString() : "No set",
                onPressed: () {},
              ),
              ProfileMenu(
                title: 'Date of Birth',
                value: controller.user.dateOfBirth != null ? controller.user.dateOfBirth.toString() : "No set",
                onPressed: () {},
              ),
              const Divider(),
              const SizedBox(height: Sizes.spaceBtwItems),
              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: const Text('Close Account', style: TextStyle(color: Colors.red)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
