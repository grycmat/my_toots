import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@singleton
class ThemeService extends ChangeNotifier {
  List<MaterialColor> availableColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.purple,
    Colors.orange,
    Colors.pink,
    Colors.teal,
    Colors.cyan,
    Colors.lime,
    Colors.indigo,
    Colors.brown,
    Colors.blueGrey,
  ];
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
