import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:starter/core/controllers/user_controller.dart';
import 'package:starter/data/models/user.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/pocketbase/pocketbase.dart';

class AuthController extends GetxController {
  final PocketBase pb = PocketBaseSingleton().client;

  static AuthController get instance => Get.find();

  Future<UserModel> registerWithEmailAndPassword(Map<String, dynamic> body) async {
    try {
      final userRecord = await pb.collection('users').create(body: body);
      final user = UserModel.fromJson(userRecord.toJson());
      return user;
    } on ClientException {
      rethrow;
    }
  }

  Future<void> sendEmailVerification(String email) async {
    try {
      await pb.collection('users').requestVerification(email);
    } on ClientException {
      rethrow;
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await pb.collection('users').requestPasswordReset(email);
    } on ClientException {
      rethrow;
    }
  }

  Future<RecordAuth> loginWithEmailAndPassword(String email, String password) async {
    try {
      return await pb.collection('users').authWithPassword(email, password);
    } on ClientException {
      rethrow;
    }
  }

  Future<RecordAuth> loginProvider(String providerName) async {
    try {
      return await pb.collection('users').authWithOAuth2(providerName, (url) async {
        await launchUrl(url, webOnlyWindowName: "_blank");
      });
    } on ClientException {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _clearUserInfo();
      Get.offAllNamed('/login');
    } on ClientException {
      rethrow;
    }
  }

  Future<void> _clearUserInfo() async {
    UserController.instance.user.value = UserModel.empty();
    pb.authStore.clear();
  }
}
