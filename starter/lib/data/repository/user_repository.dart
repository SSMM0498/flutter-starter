import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:http/http.dart' as http;
import 'package:starter/core/services/pocketbase/pocketbase.dart';
import 'package:starter/data/models/user.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final PocketBase pb = PocketBaseSingleton().client;

  Future<void> saveUserRecord(UserModel user) async {
    try {
      await pb.collection('users').create(body: user.toJson());
    } on ClientException {
      rethrow;
    }
  }

  Future<List<ExternalAuthModel>> getUserProviderList() async {
    try {
      final result = await pb.collection('users').listExternalAuths(
            pb.authStore.model.id,
          );
      return result;
    } on ClientException {
      rethrow;
    }
  }

  Future<UserModel> fetchUserDetails() async {
    try {
      final user = await pb.collection('users').getOne(pb.authStore.model.id);
      final userModel = UserModel.fromJson(user.toJson());
      return userModel;
    } on ClientException {
      rethrow;
    }
  }

  Future<void> updateUserDetails(Map<String, dynamic> updatedUser) async {
    try {
      await pb.collection('users').update(pb.authStore.model.id!, body: updatedUser);
    } on ClientException {
      rethrow;
    }
  }

  Future<void> removeUserRecord() async {
    try {
      await pb.collection('users').delete(pb.authStore.model.id);
    } on ClientException {
      rethrow;
    }
  }

  Future<String> uploadAvatar(String path, XFile image) async {
    try {
      final file = await image.readAsBytes();
      final result = await pb.collection('users').update(pb.authStore.model.id, files: [
        http.MultipartFile.fromBytes(
          'avatar',
          file,
          filename: path,
        ),
      ]);
      return result.data["avatar"];
    } on ClientException {
      rethrow;
    }
  }
}
