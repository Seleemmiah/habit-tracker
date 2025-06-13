import 'package:flutter/material.dart';
import 'package:habit_app/theme/dark_mode.dart';
import 'package:habit_app/theme/light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  // initally light mode
  ThemeData _themeData = lightMode;

  // get current theme
  ThemeData get themeData => _themeData;

  // is current dark mode
  bool get isDarkMode => _themeData == darkMode;

  // set theme
  set ThemeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners(); // notify listeners to rebuild widgets that depend on this theme
  }

  // toggle theme
  void toggleTheme() {
    if (_themeData == lightMode) {
      _themeData = darkMode;
    } else {
      _themeData = lightMode;
    }
    notifyListeners(); // notify listeners to rebuild widgets that depend on this theme
  }
}
