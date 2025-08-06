import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:starter/core/services/local_storage/local_storage.dart';
import 'package:starter/l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:starter/common/styles/sizes.dart';
import 'package:starter/common/widgets/loaders/full_screen_loader.dart';
import 'package:starter/common/widgets/loaders/loaders.dart';
import 'package:starter/core/controllers/auth_controller.dart';
import 'package:starter/core/controllers/network_manager.dart';
import 'package:starter/core/services/pocketbase/pocketbase.dart';
import 'package:starter/data/models/user.dart';
import 'package:starter/data/repository/user_repository.dart';
import 'package:starter/routes/routes.dart';
import 'package:starter/usecase/user/screens/profile/widgets/re_authenticate_user_login_form.dart';
import 'package:starter/utils/image_strings.dart';
import 'package:starter/utils/text_strings.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  final Rx<UserModel> user = UserModel.empty().obs;

  final hidePassword = true.obs;
  final imageUploading = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final authController = AuthController.instance;
 final UserRepository userRepository = Get.put(UserRepository());

  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();

    final pb = PocketBaseSingleton().client;

    pb.authStore.onChange.listen((event) {
      if (event.model != null && event.token.isNotEmpty) {
        user.value = UserModel.fromJson(event.model.toJson());
        debugPrint('✅ UserController updated from authStore.onChange');
      } else {
        user.value = UserModel.empty();
      }
    });

    // Initial data fetch when the app starts
    if (pb.authStore.isValid) {
      // Use the cached user first for instant UI, then fetch fresh data
      loadUserFromCacheAndFetch();
    }
  }

  Future<void> loadUserFromCacheAndFetch() async {
    try {
      profileLoading.value = true;
      final storage = LocalStorage();
      final cachedUserJson = await storage.getCachedUser();
      if (cachedUserJson != null) {
        user.value = UserModel.fromJson(json.decode(cachedUserJson));
        debugPrint('✅ User loaded from cache.');
      }

      await fetchUserRecord();

    } catch (e) {
      debugPrint('🚨 Error in loadUserFromCacheAndFetch: $e');
    } finally {
      profileLoading.value = false;
    }
  }

  Future<void> fetchUserRecord() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        debugPrint('⏩ Skipping user record fetch: No internet.');
        return;
      }

      final userRecord = await userRepository.fetchUserDetails();
      user.value = userRecord;
      debugPrint('✅ User record fetched successfully from network.');
    } catch (e) {
      debugPrint('❌ Failed to fetch user record: $e');
    }
  }

  void deleteAccountWarningPopup() {
    final localizations = AppLocalizations.of(Get.context!)!;

    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(Sizes.md),
      title: localizations.deleteAccount,
      middleText: localizations.deleteAccountWarning,
      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.lg),
          child: Text(localizations.delete),
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: Text(localizations.cancel),
      ),
    );
  }

  void deleteUserAccount() async {
    try {
      FullScreenLoader.openLoadingDialog(animation: ImageStrings.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      final providerList = await userRepository.getUserProviderList();

      FullScreenLoader.stopLoading();
      if (providerList.isNotEmpty) {
        final providerRecord = providerList.first;
        await authController.loginProvider(providerRecord.provider);
        await userRepository.removeUserRecord();
        Get.offAllNamed(Routes.login);
      } else {
        Get.to(() => const ReAuthLoginForm());
      }
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.warningSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  Future<void> checkUserBeforeRemove() async {
    try {
      FullScreenLoader.openLoadingDialog(animation: ImageStrings.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      if (!reAuthFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      await AuthController.instance.loginWithEmailAndPassword(verifyEmail.text.trim(), verifyPassword.text.trim());

      await userRepository.removeUserRecord();
      FullScreenLoader.stopLoading();
      AuthController.instance.logout();
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.warningSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  void uploadUserProfilePicture(LoaderText uploadText) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70, maxHeight: 512, maxWidth: 512);
      if (image != null) {
        imageUploading.value = true;

        final imageUrl = await userRepository.uploadAvatar('Users/Images/Profile/', image);

        user.value.avatar = imageUrl;
        user.refresh();

        Loaders.successSnackBar(title: uploadText.title, message: uploadText.message);
      }
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap', message: 'Something went wrong: $e');
    } finally {
      imageUploading.value = false;
    }
  }
}
