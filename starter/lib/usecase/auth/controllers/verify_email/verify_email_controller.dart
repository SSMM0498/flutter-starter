import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:starter/common/widgets/loaders/loaders.dart';
import 'package:starter/common/widgets/success_screen/success_screen.dart';
import 'package:starter/core/controllers/auth_controller.dart';
import 'package:starter/core/services/pocketbase/pocketbase.dart';
import 'package:starter/data/models/user.dart';
import 'package:starter/routes/routes.dart';
import 'package:starter/utils/image_strings.dart';

class VerifyEmailController extends GetxController {
  VerifyEmailController({required this.email});
  final String email;

  static VerifyEmailController get instance => Get.find();

  @override
  void onInit() {
    sendEmailVerification(email);
    setTimerForAutoRedirect();
    super.onInit();
  }

  sendEmailVerification(String email) async {
    try {
      await AuthController.instance.sendEmailVerification(email);
      Loaders.successSnackBar(title: 'Email Sent', message: 'Please check your inbox and verify your email.');
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  setTimerForAutoRedirect() {
    Timer.periodic(
      const Duration(seconds: 5),
      (timer) async {
        // Reload user before checking email verification status
        final userRecord = await PocketBaseSingleton().client.collection('users').authRefresh();
        final user = UserModel.fromJson(json.decode(userRecord.record.toString()));
        if (user.verified!) {
          timer.cancel();
          Get.off(
            () => SuccessScreen(
              image: ImageStrings.successfullyRegisterAnimation,
              title: "Your Account Created",
              subtitle: "Your account has been created successfully.",
              onPressed: () => Get.offNamed(Routes.navigationPanel),
            ),
          );
        }
      },
    );
  }

  checkEmailVerificationStatus() async {
    final userRecord = await PocketBaseSingleton().client.collection('users').authRefresh();
    final currentUser = UserModel.fromJson(json.decode(userRecord.record.toString()));
    if (currentUser.verified!) {
      Get.off(
        () => SuccessScreen(
          image: ImageStrings.successfullyRegisterAnimation,
          title: "Your Account Created",
          subtitle: "Your account has been created successfully.",
          onPressed: () => Get.offNamed(Routes.navigationPanel),
        ),
      );
    }
  }
}
