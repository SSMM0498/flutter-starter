import 'package:get/get.dart';
import 'package:starter/common/widgets/loaders/loaders.dart';
import 'package:starter/core/controllers/auth_controller.dart';
import 'package:starter/utils/text_strings.dart';

class VerifyChangedEmailController extends GetxController {
  VerifyChangedEmailController({required this.email});
  final String email;

  static VerifyChangedEmailController get instance => Get.find();

  @override
  void onInit() {
    sendEmailVerification(email: email);
    super.onInit();
  }

  sendEmailVerification({required String email, LoaderText? changeEmailText}) async {
    try {
      await AuthController.instance.sendRequestEmailChange(email);
      if (changeEmailText != null) {
        Loaders.successSnackBar(title: changeEmailText.title, message: changeEmailText.message);
      }
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
