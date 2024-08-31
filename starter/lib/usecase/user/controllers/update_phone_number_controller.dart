import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starter/common/widgets/loaders/full_screen_loader.dart';
import 'package:starter/common/widgets/loaders/loaders.dart';
import 'package:starter/core/controllers/network_manager.dart';
import 'package:starter/data/repository/user_repository.dart';
import 'package:starter/usecase/user/controllers/user_controller.dart';
import 'package:starter/utils/image_strings.dart';

class UpdatePhoneNumberController extends GetxController {
  static UpdatePhoneNumberController get instance => Get.find();

  final phoneNumber = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updatePhoneNumberFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    phoneNumber.text = userController.user.value.phoneNumber;
    super.onInit();
  }

  Future<void> updatePhoneNumber() async {
    try {
      FullScreenLoader.openLoadingDialog(animation: ImageStrings.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      if (!updatePhoneNumberFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      await userRepository.updateUserDetails({
        'phoneNumber': phoneNumber.text.trim(),
      });

      userController.user.value.phoneNumber = phoneNumber.text.trim();
      userController.user.refresh();

      FullScreenLoader.stopLoading();

      Loaders.successSnackBar(title: 'Congratulations', message: 'Your phone number has been updated.');

      Get.back();
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
