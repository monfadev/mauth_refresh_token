import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../models/auth/user_jwt.dart';
import '../../models/enum/network_enums.dart';
import '../../models/enum/theme_enums.dart';
import '../globals/logger.dart';

class CacheManager {
  CacheManager._private();

  static CacheManager instance = CacheManager._private();

  late final FlutterSecureStorage _secureStorage;

  Future<void> initialize() async {
    _secureStorage = const FlutterSecureStorage(iOptions: _iosOptions, aOptions: _androidOptions);
  }

  static const _androidOptions = AndroidOptions(encryptedSharedPreferences: true);
  static const _iosOptions = IOSOptions(accessibility: KeychainAccessibility.first_unlock);

  Future<void> updateLoggedIn(bool isLoggedIn) async {
    await _secureStorage.write(key: NetworkEnums.login.path, value: isLoggedIn.toString());
  }

  Future<bool?> isLoggedIn() async {
    final data = await _secureStorage.read(key: NetworkEnums.login.path);
    if (data == null) return null;
    if (data == 'true') {
      return true;
    } else if (data == 'false') {
      return false;
    } else {
      return null;
    }
  }

  Future<void> updateToken(UserJWT userJWT) async {
    clog('-- METHOD RUNNING [updateToken] --');

    await _secureStorage.write(key: NetworkEnums.accessToken.path, value: userJWT.accessToken!);
    await _secureStorage.write(key: NetworkEnums.refreshToken.path, value: userJWT.refreshToken!);
  }

  Future<UserJWT> updateTokenFromStorage() async {
    clog('-- METHOD RUNNING [updateTokenFromStorage] --');

    final access = await _secureStorage.read(key: NetworkEnums.accessToken.path);
    final refresh = await _secureStorage.read(key: NetworkEnums.refreshToken.path);

    return UserJWT(accessToken: access, refreshToken: refresh);
  }

  Future<String?> getTheme(String value) async => _secureStorage.read(key: value);

  Future<void> savedTheme(String value) async {
    await _secureStorage.write(key: ThemeEnums.themeKey.path, value: value);
  }

  Future<void> clear() async {
    await _secureStorage.deleteAll();
  }
}
