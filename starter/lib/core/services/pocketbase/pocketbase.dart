// pocketbase_singleton.dart
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:starter/data/models/user.dart';
import '../local_storage/local_storage.dart';
import 'factories/factory_mobile.dart' if (dart.library.html) 'factories/factory_web.dart';

class PocketBaseSingleton {
  static final PocketBaseSingleton _instance = PocketBaseSingleton._internal();

  final _pocketBaseUrl = "http://192.168.1.180:8090";
  late final PocketBase client;
  late String _temporaryDirectory;
  final _httpClient = HttpClient();
  UserModel user = UserModel.empty();

  factory PocketBaseSingleton() {
    return _instance;
  }

  PocketBaseSingleton._internal();

  Future<void> initialize() async {
    debugPrint('📦 PocketbaseService init');

    final LocalStorage storage = LocalStorage();

    final token = await storage.getToken();

    final customAuthStore = AsyncAuthStore(
      initial: token,
      save: storage.setToken,
      clear: storage.deleteToken,
    );

    client = PocketBase(
      _pocketBaseUrl, // Use the environment variable
      httpClientFactory: httpClientFactory.getHttpClient(),
      authStore: customAuthStore,
    );

    client.authStore.onChange.listen((AuthStoreEvent event) {
      if (event.model is RecordModel) {
        user = UserModel.fromJson(event.model.toJson());
        user.token = event.token;
        debugPrint('🔐 Update Auth Store ${user.toJson()}');
      }
    });

    if (client.authStore.isValid) {
      try {
        await authRefresh();
      } catch (e) {
        client.authStore.clear();
      }
    }

    _temporaryDirectory = (await getTemporaryDirectory()).path;

    // Remove splash screen
    FlutterNativeSplash.remove();
  }

  Future<RecordAuth> authRefresh() async => await client.collection('users').authRefresh();

  /// Helpers
  Uri getFileUrl(RecordModel recordModel, String fileName) => client.getFileUrl(recordModel, fileName);

  /// Either pass [uri] or [recordModel] to download file
  /// [useCache] will return the cached file if its already downloaded
  Future<File?> downloadFile({
    required RecordModel recordModel,
    required String fileName,
    bool useCache = false,
  }) async {
    try {
      Uri fileUri = client.getFileUrl(recordModel, fileName);
      File file = File('$_temporaryDirectory/$fileName');
      if (useCache && file.existsSync()) return file;
      var request = await _httpClient.getUrl(fileUri);
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      return await file.writeAsBytes(bytes);
    } catch (error) {
      return null;
    }
  }
}
