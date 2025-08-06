import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:starter/l10n/app_localizations.dart';
import 'package:starter/common/styles/colors.dart';
import 'package:starter/common/styles/sizes.dart';
import 'package:starter/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:starter/common/widgets/loaders/full_screen_loader.dart';
import 'package:starter/common/widgets/loaders/loaders.dart';
import 'package:starter/common/widgets/text/section_heading.dart';
import 'package:starter/core/controllers/network_manager.dart';
import 'package:starter/data/models/user.dart';
import 'package:starter/data/repository/user_repository.dart';
import 'package:starter/routes/routes.dart';
import 'package:starter/usecase/user/controllers/user_controller.dart';
import 'package:starter/utils/formatter.dart';
import 'package:starter/utils/helper_functions.dart';
import 'package:starter/utils/image_strings.dart';

class UpdateGenderController extends GetxController {
  static UpdateGenderController get instance => Get.find();

  final userRepository = Get.put(UserRepository());
  final userController = UserController.instance;

  final genders = [
    'woman',
    'man',
  ];

  @override
  void onInit() {
    super.onInit();
    initializeGender();
  }

  void initializeGender() {}

  Future<void> changeGender(String newGender) async {
    try {
      FullScreenLoader.openLoadingDialog(animation: ImageStrings.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      Map<String, dynamic> gender = {'gender': newGender};

      await userRepository.updateUserDetails(gender);

      userController.user.value.gender = Gender.values.firstWhere(
        (el) {
          return el.toString().split('.').last == newGender;
        },
      );
      userController.user.refresh();

      FullScreenLoader.stopLoading();

      //TODO: Find a way to display loader screen
      //   Loaders.successSnackBar(title: updateName.title, message: updateName.message);

      Get.offNamed(Routes.userProfile);
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  Future<dynamic> selectGender(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          final localizations = AppLocalizations.of(context)!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(Sizes.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionHeading(title: localizations.gender, showActionButton: false),
                const SizedBox(height: Sizes.spaceBtwSections),
                ...genders.map(
                  ((gender) => Column(
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            onTap: () {
                              changeGender(gender);
                              Get.back();
                            },
                            leading: RoundedContainer(
                              width: 60,
                              height: 40,
                              backgroundColor: HelperFunctions.isDarkMode(context) ? AppColors.light : AppColors.white,
                              padding: const EdgeInsets.all(Sizes.sm),
                              child: Icon(gender == 'man' ? Iconsax.man : Iconsax.woman),
                            ),
                            title: Text(Formatter.formatTitleCase(gender)),
                            trailing: const Icon(Iconsax.arrow_right_34),
                          ),
                          const SizedBox(height: Sizes.spaceBtwItems / 2),
                        ],
                      )),
                ),
                const SizedBox(height: Sizes.spaceBtwSections),
              ],
            ),
          );
        });
  }
}
