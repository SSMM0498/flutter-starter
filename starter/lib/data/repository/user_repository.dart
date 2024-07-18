import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:http/http.dart' as http;
import 'package:starter/core/services/pocketbase/pocketbase.dart';
import 'package:starter/data/models/user.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _cachedUsersData = {};
  final PocketBase pb = PocketBaseSingleton().client;

  Future<void> saveUserRecord(UserModel user) async {
    try {
      await pb.collection('users').create(body: user.toJson());
    } on ClientException {
      rethrow;
    }
  }

  Future<UserModel> fetchUserDetails(
    String userId, {
    bool useCache = false,
  }) async {
    try {
      if (useCache && _cachedUsersData.containsKey(userId)) {
        return _cachedUsersData[userId];
      }
      final user = await pb.collection('users').getOne(userId);
      final userModel = UserModel.fromJson(user.toJson());
      _cachedUsersData[userId] = userModel;
      return userModel;
    } on ClientException {
      rethrow;
    }
  }

  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await pb.collection('users').update(updatedUser.id!, body: updatedUser.toJson());
    } on ClientException {
      rethrow;
    }
  }

  Future<void> removeUserRecord(String userId) async {
    try {
      await pb.collection('users').delete(userId);
    } on ClientException {
      rethrow;
    }
  }

  Future<String> uploadAvatar(String path, XFile image) async {
    try {
      final file = await image.readAsBytes();
      await pb.collection('users').update(pb.authStore.model.id, files: [
        http.MultipartFile.fromBytes(
          'avatar',
          file,
          filename: path,
        ),
      ]);
      return pb.authStore.model.avatar;
    } on ClientException {
      rethrow;
    }
  }
}
