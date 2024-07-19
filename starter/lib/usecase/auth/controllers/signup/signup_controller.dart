import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starter/common/widgets/loaders/full_screen_loader.dart';
import 'package:starter/common/widgets/loaders/loaders.dart';
import 'package:starter/core/controllers/auth_controller.dart';
import 'package:starter/core/controllers/network_manager.dart';
import 'package:starter/usecase/auth/screens/signup/verify_email.dart';
import 'package:starter/utils/image_strings.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final hidePassword = true.obs;
  final hideConfirmPassword = true.obs;
  final privacyPolicy = false.obs;
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  void signup() async {
    try {
      // Show loading dialog
      FullScreenLoader.openLoadingDialog('We are processing your information...', ImageStrings.docerAnimation);

      // Check if user is connected to the internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Validate the form
      if (!signupFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Check if user has accepted the privacy policy
      if (!privacyPolicy.value) {
        FullScreenLoader.stopLoading();
        Loaders.warningSnackBar(
            title: 'Accept Privacy Policy', message: 'In order to create account, you must have to read and accept the Privacy Policy & Terms of Use.');
        return;
      }

      // Check if passwords are identic
      if (password.text.trim() != confirmPassword.text.trim()) {
        FullScreenLoader.stopLoading();
        Loaders.warningSnackBar(
            title: 'Password Confirmation', message: 'The password confirmation does not match.');
        return;
      }

      // Register user with email and password
      var body = {
        'email': email.text.trim(),
        'password': password.text.trim(),
        'passwordConfirm': confirmPassword.text.trim(),
        'firstName': firstName.text.trim(),
        'lastName': lastName.text.trim(),
        'username': username.text.trim(),
        'phoneNumber': phoneNumber.text.trim(),
      };
      await AuthController.instance.registerWithEmailAndPassword(body);
      await AuthController.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Go to verify email screen
      FullScreenLoader.stopLoading();
      Loaders.successSnackBar(title: 'Congratulations', message: 'Your account has been created! Verify email to continue.');
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
