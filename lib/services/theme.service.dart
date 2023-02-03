import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

const IS_DARK = 'application';

@singleton
class ThemeService extends ChangeNotifier {
  late SharedPreferences _prefs;
  bool _isDark = false;
  bool _fabVisible = true;

  ThemeService({required SharedPreferences prefs, required isDark})
      : _prefs = prefs;

  @factoryMethod
  factory ThemeService.init(SharedPreferences prefs) {
    final isDark = prefs.getBool(IS_DARK) ?? false;
    return ThemeService(prefs: prefs, isDark: isDark);
  }

  bool get isDark => _isDark;
  bool get fabVisible => _fabVisible;

  setFabVisible(bool value) {
    _fabVisible = value;
    notifyListeners();
  }

  setIsDark(bool value) {
    _isDark = value;
    _prefs.setBool(IS_DARK, value);
    notifyListeners();
  }

  toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}
