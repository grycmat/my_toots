import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@singleton
class ThemeService extends ChangeNotifier {
  bool _isDark = false;
  bool _fabVisible = true;

  MaterialColor primarySwatch = Colors.blue;
  bool get isDark => _isDark;
  bool get fabVisible => _fabVisible;

  setFabVisible(bool value) {
    _fabVisible = value;
    notifyListeners();
  }

  setPrimarySwatch(MaterialColor color) {
    primarySwatch = color;
    notifyListeners();
  }

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
