import 'package:get/get.dart';
import 'package:starter/common/widgets/loaders/loaders.dart';
import 'package:starter/core/controllers/auth_controller.dart';

class VerifyChangedEmailController extends GetxController {
  VerifyChangedEmailController({required this.email});
  final String email;

  static VerifyChangedEmailController get instance => Get.find();

  @override
  void onInit() {
    sendEmailVerification(email);
    super.onInit();
  }

  sendEmailVerification(String email) async {
    try {
      await AuthController.instance.sendRequestEmailChange(email);
      Loaders.successSnackBar(title: 'Email Sent', message: 'Please check your inbox and verify your email.');
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
