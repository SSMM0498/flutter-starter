import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starter/common/widgets/loaders/full_screen_loader.dart';
import 'package:starter/common/widgets/loaders/loaders.dart';
import 'package:starter/core/controllers/network_manager.dart';
import 'package:starter/data/repository/user_repository.dart';
import 'package:starter/usecase/user/controllers/user_controller.dart';
import 'package:starter/usecase/user/screens/profile/widgets/verify_changed_email.dart';
import 'package:starter/utils/image_strings.dart';

class UpdateEmailController extends GetxController {
  static UpdateEmailController get instance => Get.find();

  final email = TextEditingController();
  final userController = UserController.instance;
  final userRepository = UserRepository.instance;
  GlobalKey<FormState> updateEmailFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    email.text = userController.user.value.email;
    super.onInit();
  }

  Future<void> updateEmail() async {
    try {
      FullScreenLoader.openLoadingDialog(animation: ImageStrings.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      if (!updateEmailFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      Get.to(VerifyChangedEmailScreen(email: email.text.trim()));
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
