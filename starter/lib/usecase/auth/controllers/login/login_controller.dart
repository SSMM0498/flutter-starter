import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starter/common/widgets/loaders/full_screen_loader.dart';
import 'package:starter/common/widgets/loaders/loaders.dart';
import 'package:starter/core/controllers/auth_controller.dart';
import 'package:starter/core/controllers/network_manager.dart';
import 'package:starter/core/controllers/user_controller.dart';
import 'package:starter/core/services/local_storage/local_storage.dart';
import 'package:starter/data/models/user.dart';
import 'package:starter/utils/image_strings.dart';

class LoginController extends GetxController {
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = LocalStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  @override
  void onInit() {
    localStorage.getRememberMeEmail().then((onValue) {
      if (onValue != null) {
        email.text = onValue;
      }
    });
    localStorage.getRememberMePassword().then((onValue) {
      if (onValue != null) {
        password.text = onValue;
      }
    });
    super.onInit();
  }

  Future<void> emailAndPasswordSignIn() async {
    try {
      FullScreenLoader.openLoadingDialog('Logging you in...', ImageStrings.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }
      if (!loginFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }
      if (rememberMe.value) {
        localStorage.setRememberMeEmail(email.text.trim());
        localStorage.setRememberMePassword(password.text.trim());
      } else {
        localStorage.deleteRememberMeEmail();
        localStorage.deleteRememberMePassword();
      }

      final userCredentials = await AuthController.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      FullScreenLoader.stopLoading();
      if (userCredentials.token.isNotEmpty && userCredentials.record != null) {
        Get.offAllNamed('/');
      }
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  Future<void> providerSignIn(String provider) async {
    try {
      FullScreenLoader.openLoadingDialog('Logging you in...', ImageStrings.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      // ignore: unused_local_variable
      final userCredentials = await AuthController.instance.loginProvider(provider);

      if (userCredentials.token.isNotEmpty && userCredentials.record != null) {
        final user = UserModel.fromJson(json.decode(userCredentials.record.toString()));
        await userController.saveUserRecord(user);

        localStorage.deleteRememberMeEmail();
        localStorage.deleteRememberMePassword();

        FullScreenLoader.stopLoading();

        Get.offAllNamed('/');
      } else {
        throw "Can login with $provider";
      }
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
