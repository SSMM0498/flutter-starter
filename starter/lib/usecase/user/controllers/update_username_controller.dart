import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starter/common/widgets/loaders/full_screen_loader.dart';
import 'package:starter/common/widgets/loaders/loaders.dart';
import 'package:starter/core/controllers/network_manager.dart';
import 'package:starter/data/repository/user_repository.dart';
import 'package:starter/usecase/user/controllers/user_controller.dart';
import 'package:starter/utils/image_strings.dart';
import 'package:starter/utils/text_strings.dart';

class UpdateUsernameController extends GetxController {
  static UpdateUsernameController get instance => Get.find();

  final username = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUsernameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    username.text = userController.user.value.username;
    super.onInit();
  }

  Future<void> updateUsername(LoaderText updateUsername) async {
    try {
      FullScreenLoader.openLoadingDialog(animation: ImageStrings.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      if (!updateUsernameFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      await userRepository.updateUserDetails({
        'username': username.text.trim(),
      });

      userController.user.value.username = username.text.trim();
      userController.user.refresh();

      FullScreenLoader.stopLoading();

      Loaders.successSnackBar(title: updateUsername.title, message: updateUsername.message);

      Get.back();
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
