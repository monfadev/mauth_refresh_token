import 'package:flutter/material.dart';

import '../../../ui/constants/app_string.dart';
import '../../../ui/constants/app_style.dart';
import '../../models/enum/theme_enums.dart';
import '../../utils/cache/cache_manager.dart';

class ThemeProvider with ChangeNotifier {
  ///=========================
  /// Property Sections
  ///=========================

  /// Theme status
  String _currentTheme = AppString.systemText;
  String get currentTheme => _currentTheme;

  ///=========================
  /// Getter Sections
  ///=========================
  ThemeMode get themeMode {
    if (_currentTheme == AppString.lightText) {
      return ThemeMode.light;
    } else if (_currentTheme == AppString.darkText) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  ///=========================
  /// Function Logic Sections
  ///=========================
  Future<void> changeTheme(String theme) async {
    await CacheManager.instance.savedTheme(theme);

    AppStyle.setStatusBar(theme);
    _currentTheme = theme;
    notifyListeners();
  }

  Future<void> initialized() async {
    _currentTheme = await CacheManager.instance.getTheme(ThemeEnums.themeKey.path) ?? AppString.darkText;
    notifyListeners();
  }
}
