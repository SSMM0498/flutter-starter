import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:starter/data/models/app_setting.dart';

class LocalStorage {
  static const _tokenKey = 'TOKEN';
  static const _isFirstTokenKey = 'IS_FIRST_TIME';
  static const _rememberMeEmail = 'REMEMBER_ME_EMAIL';
  static const _rememberMePassword = 'REMEMBER_ME_PASSWORD';
  final _settingsKey = 'APP_SETTINGS';
  final _userCache = 'USER_CACHE';

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  Future<String?> storageRead(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      if (e is PlatformException && e.code == 'BadPaddingException') {
        print("🗑️ Clearing all data");
        await _storage.deleteAll();
      }
    }
    return null;
  }

  Future<void> cacheUser(String userJson) async {
    await _storage.write(key: _userCache, value: userJson);
    print("👏 Caching User Over $userJson");
  }

  Future<String?> getCachedUser() async {
    return await storageRead(_userCache);
  }

  Future<AppSetting?> getAppSettings() async {
    final settingsJson = await storageRead(_settingsKey);
    if (settingsJson != null) {
      return AppSetting.fromJson(jsonDecode(settingsJson));
    }
    return null;
  }

  Future<void> setAppSettings(AppSetting setting) async {
    await _storage.write(key: _settingsKey, value: jsonEncode(setting.toJson()));
  }

  Future<void> deleteAppSettings() async {
    await _storage.delete(key: _settingsKey);
  }

  Future<String?> getToken() async {
    final token = await storageRead(_tokenKey);
    return token;
  }

  Future<void> setToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }

  Future<bool> getIsFirstTime() async {
    final isFirstTime = await storageRead(_isFirstTokenKey);
    return isFirstTime == 'true';
  }

  Future<void> setIsFirstTime(bool isFirstTime) async {
    await _storage.write(key: _isFirstTokenKey, value: isFirstTime.toString());
  }

  Future<void> setIsFirstTimeIfNull() async {
    final isFirstTime = await storageRead(_isFirstTokenKey);
    if (isFirstTime == null) {
      await _storage.write(key: _isFirstTokenKey, value: 'true');
    }
  }

  Future<void> deleteIsFirstTime() async {
    await _storage.delete(key: _isFirstTokenKey);
  }

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  Future<String?> getRememberMeEmail() async {
    final email = await storageRead(_rememberMeEmail);
    return email;
  }

  Future<void> setRememberMeEmail(String email) async {
    await _storage.write(key: _rememberMeEmail, value: email);
  }

  Future<void> deleteRememberMeEmail() async {
    await _storage.delete(key: _rememberMeEmail);
  }

  Future<String?> getRememberMePassword() async {
    final password = await storageRead(_rememberMePassword);
    return password;
  }

  Future<void> setRememberMePassword(String password) async {
    await _storage.write(key: _rememberMePassword, value: password);
  }

  Future<void> deleteRememberMePassword() async {
    await _storage.delete(key: _rememberMePassword);
  }

  Future<void> deleteRememberMe() async {
    await _storage.delete(key: _rememberMeEmail);
    await _storage.delete(key: _rememberMePassword);
  }
}
