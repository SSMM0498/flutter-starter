import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starter/common/widgets/loaders/full_screen_loader.dart';
import 'package:starter/common/widgets/loaders/loaders.dart';
import 'package:starter/core/controllers/auth_controller.dart';
import 'package:starter/core/controllers/network_manager.dart';
import 'package:starter/usecase/auth/screens/password_configuration/reset_password.dart';
import 'package:starter/utils/image_strings.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  sendPasswordResetEmail() async {
    try {
      FullScreenLoader.openLoadingDialog('Processing your request...', ImageStrings.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      if (!forgetPasswordFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      await AuthController.instance.sendPasswordResetEmail(email.text.trim());

      FullScreenLoader.stopLoading();

      Loaders.successSnackBar(title: 'Email Sent', message: 'Email Link Sent to Reset Your Password.');

      Get.to(() => ResetPassword(email: email.text.trim()));
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      FullScreenLoader.openLoadingDialog('Processing your request...', ImageStrings.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      await AuthController.instance.sendPasswordResetEmail(email);

      FullScreenLoader.stopLoading();

      Loaders.successSnackBar(title: 'Email Sent', message: 'Email Link Sent to Reset Your Password.');
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
