import 'package:flutter/material.dart';
import 'package:mauth_refresh_token/core/models/auth/user_jwt.dart';
import 'package:mauth_refresh_token/core/models/auth/user_profile.dart';
import 'package:mauth_refresh_token/core/services/http/auth/auth_interface.dart';
import 'package:mauth_refresh_token/core/utils/cache/cache_manager.dart';

import '../../utils/globals/toast.dart';

class UserProvider extends ChangeNotifier {
  final AuthInterface authInterface;
  UserProvider(this.authInterface);

  bool isDisposed = false;

  UserJWT? _userJWT;
  UserJWT? get userJWT => _userJWT;

  UserProfile? _userProfile;
  UserProfile? get userProfile => _userProfile;

  Future<void> login(String email, String password) async {
    final resp = await authInterface.login(email, password);

    resp.fold((error) {
      _userJWT = null;
      Toasts.showToast(error.message!);
    }, (response) async {
      _userJWT = response;
      await CacheManager.instance.updateLoggedIn(true);
      await CacheManager.instance.updateToken(_userJWT!);
    });
    notifyListeners();
  }

  Future<void> authProfile() async {
    final resp = await authInterface.authProfile();

    resp.fold((error) {
      _userProfile = null;
      Toasts.showToast(error.message!);
    }, (response) async {
      _userProfile = response;
      Toasts.showToast('Welcome ${response.name}');
    });
    notifyListeners();
  }

  @override
  void notifyListeners() {
    if (!isDisposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}
