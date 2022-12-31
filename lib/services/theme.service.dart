import 'package:flutter/material.dart';

class ThemeService extends ChangeNotifier {
  bool _isDark = false;

  bool get isDark => _isDark;

  setIsDark(bool value) {
    print(value);
    _isDark = value;
    notifyListeners();
  }

  toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}
