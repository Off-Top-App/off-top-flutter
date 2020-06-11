import 'package:flutter/material.dart';
import 'package:off_top_mobile/themes/themeSharedPreferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemePreference themePreference = ThemePreference();
  int _primaryColor = 0xFF9505E3;
  int _secondaryColor = 0xFFB4FEE7;
  int _accentColor = 0xFF3D393B;
  int _backgroundColor = 0xFFFFFFFF;

  int get primaryColor => _primaryColor;

  set primaryColor(int value) {
    _primaryColor = value;
    themePreference.setPrimaryTheme(value);
    notifyListeners();
  }

  int get secondaryColor => _secondaryColor;

  set secondaryColor(int value) {
    _secondaryColor = value;
    themePreference.setSecondaryTheme(value);
    notifyListeners();
  }

  int get accentColor => _accentColor;

  set accentColor(int value) {
    _accentColor = value;
    themePreference.setAccentTheme(value);
    notifyListeners();
  }

  int get backgroundColor => _backgroundColor;

  set backgroundColor(int value) {
    _backgroundColor = value;
    themePreference.setBackgroundTheme(value);
    notifyListeners();
  }
}
