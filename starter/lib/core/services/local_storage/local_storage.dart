import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  static const _tokenKey = 'TOKEN';
  static const _isFirstTokenKey = 'IS_FIRST_TIME';
  static const _rememberMeEmail = 'REMEMBER_ME_EMAIL';
  static const _rememberMePassword = 'REMEMBER_ME_PASSWORD';

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<String?> getToken() async {
    final token = await _storage.read(key: _tokenKey);
    return token;
  }

  Future<void> setToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }

  Future<bool> getIsFirstTime() async {
    final isFirstTime = await _storage.read(key: _isFirstTokenKey);
    return isFirstTime == 'true';
  }

  Future<void> setIsFirstTime(bool isFirstTime) async {
    await _storage.write(key: _isFirstTokenKey, value: isFirstTime.toString());
  }

  Future<void> setIsFirstTimeIfNull() async {
    final isFirstTime = await _storage.read(key: _isFirstTokenKey);
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
    final email = await _storage.read(key: _rememberMeEmail);
    return email;
  }

  Future<void> setRememberMeEmail(String email) async {
    await _storage.write(key: _rememberMeEmail, value: email);
  }

  Future<void> deleteRememberMeEmail() async {
    await _storage.delete(key: _rememberMeEmail);
  }

  Future<String?> getRememberMePassword() async {
    final password = await _storage.read(key: _rememberMePassword);
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
