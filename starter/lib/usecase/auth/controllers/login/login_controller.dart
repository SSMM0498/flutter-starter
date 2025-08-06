import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starter/common/widgets/loaders/full_screen_loader.dart';
import 'package:starter/common/widgets/loaders/loaders.dart';
import 'package:starter/core/controllers/auth_controller.dart';
import 'package:starter/core/controllers/network_manager.dart';
import 'package:starter/data/repository/user_repository.dart';
import 'package:starter/routes/routes.dart';
import 'package:starter/core/services/local_storage/local_storage.dart';
import 'package:starter/utils/image_strings.dart';
import 'package:pocketbase/pocketbase.dart';

class LoginController extends GetxController {
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = LocalStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userRepository = UserRepository.instance;

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
      FullScreenLoader.openLoadingDialog(animation: ImageStrings.docerAnimation);

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
      print("🌟 $userCredentials");

      FullScreenLoader.stopLoading();
      if (userCredentials.token.isNotEmpty && userCredentials.record != null) {
        Get.offAllNamed(Routes.navigationPanel);
      }
    } catch (e) {
      FullScreenLoader.stopLoading();
      if (e is ClientException) {
        Loaders.errorSnackBar(title: 'Oh Snap', message: e.response['message']);
      } else {
        print("🌟 $e");
        Loaders.errorSnackBar(title: 'Oh Snap', message: 'Failed to credential.');
      }
    }
  }

  Future<void> providerSignIn(String provider) async {
    try {
      FullScreenLoader.openLoadingDialog(animation: ImageStrings.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      // ignore: unused_local_variable
      final userCredentials = await AuthController.instance.loginProvider(provider);

      if (userCredentials.token.isNotEmpty && userCredentials.record != null) {
        print("🌟 ${userCredentials.meta["rawUser"]}");

        if (provider == 'google') {
          Map<String, dynamic> matchColumns = {
            'firstName': userCredentials.meta["rawUser"]["given_name"].trim(),
            'lastName': userCredentials.meta["rawUser"]["family_name"].trim(),
            'avatarUrl': userCredentials.meta["rawUser"]["picture"]
          };
          await userRepository.updateUserDetails(matchColumns);
        }

        localStorage.deleteRememberMeEmail();
        localStorage.deleteRememberMePassword();

        FullScreenLoader.stopLoading();

        Get.offAllNamed(Routes.navigationPanel);
      } else {
        throw "💥 Can login with $provider";
      }
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
