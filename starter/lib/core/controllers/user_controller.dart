import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:starter/common/styles/sizes.dart';
import 'package:starter/common/widgets/loaders/full_screen_loader.dart';
import 'package:starter/common/widgets/loaders/loaders.dart';
import 'package:starter/core/controllers/network_manager.dart';
import 'package:starter/core/services/local_storage/local_storage.dart';
import 'package:starter/data/models/user.dart';
import 'package:starter/data/repository/user_repository.dart';
import 'package:starter/usecase/auth/screens/login/login.dart';
import 'package:starter/utils/image_strings.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final hidePassword = true.obs;
  final imageUploading = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user0 = await LocalStorage().getUser();
      if (user0 != null) {
        final user = await userRepository.fetchUserDetails(user0.id!);
        this.user(user);
      }
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  Future<void> saveUserRecord(UserModel user) async {
    try {
      await userRepository.saveUserRecord(user);
    } catch (e) {
      Loaders.warningSnackBar(
          title: 'Data not saved', message: 'Something went wrong while saving your information. You can re-save your data in your Profile.');
    }
  }

  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(Sizes.md),
      title: 'Delete Account',
      middleText: 'Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently.',
      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
        child: const Padding(padding: EdgeInsets.symmetric(horizontal: Sizes.lg), child: Text('Delete')),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: const Text(
          'Cancel',
        ),
      ),
    );
  }

  void deleteUserAccount() async {
    try {
      FullScreenLoader.openLoadingDialog('Processing', ImageStrings.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      //   await AuthRepository.instance.deleteAccount();
      FullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.warningSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      FullScreenLoader.openLoadingDialog('Processing', ImageStrings.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      if (!reAuthFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      //   await AuthenticationRepository.instance.reAuthenticateWithEmailAndPassword(verifyEmail.text.trim(), verifyPassword.text.trim());
      //   await AuthenticationRepository.instance.deleteAccount();
      FullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.warningSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  void uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70, maxHeight: 512, maxWidth: 512);
      if (image != null) {
        imageUploading.value = true;

        final imageUrl = await userRepository.uploadAvatar('Users/Images/Profile/', image);

        user.value.avatar = imageUrl;
        user.refresh();

        Loaders.successSnackBar(title: 'Congratulations', message: 'Your Profile Image has been updated!');
      }
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap', message: 'Something went wrong: $e');
    } finally {
      imageUploading.value = false;
    }
  }
}
