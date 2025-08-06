// pocketbase_singleton.dart
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:starter/core/services/local_storage/local_storage.dart';
import 'package:starter/data/models/user.dart';
import 'factories/factory_mobile.dart' if (dart.library.html) 'factories/factory_web.dart';

class PocketBaseSingleton {
  static final PocketBaseSingleton _instance = PocketBaseSingleton._internal();

  final _pocketBaseUrl = dotenv.env['POCKETBASE_URL']!;
  late final PocketBase client;
  late String _temporaryDirectory;
  final _httpClient = HttpClient();
  UserModel user = UserModel.empty();
  late final LocalStorage storage;

  factory PocketBaseSingleton() {
    return _instance;
  }

  PocketBaseSingleton._internal();

  Future<void> initialize() async {
    debugPrint('📦 PocketbaseService init');
    try {
      storage = LocalStorage();

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

      client.authStore.onChange.listen((event) {
        debugPrint('🔐 AuthStore changed: ${event.token} ${event.model}');
      });

      if (client.authStore.isValid) {
        final connectivityResult = await Connectivity().checkConnectivity();
        if (connectivityResult != ConnectivityResult.none) {
          try {
            await authRefresh();
          } catch (e) {
            client.authStore.clear();
          }
        } else {
          debugPrint('⚠️ No internet connection. Skipping auth refresh.');
        }
      }
    } finally {
      _temporaryDirectory = (await getTemporaryDirectory()).path;

      // Remove splash screen
      FlutterNativeSplash.remove();
    }
  }

  Future<void> authRefresh() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      await client.collection('users').authRefresh();
    } else {
      final cachedUser = await storage.getCachedUser();
      if (cachedUser != null) {
        user = UserModel.fromJson(json.decode(cachedUser));
        client.authStore.save(user.token!, RecordModel.fromJson(user.toJson()));
      }
    }
  }

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
