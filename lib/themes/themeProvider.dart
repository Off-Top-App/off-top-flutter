import 'package:flutter/material.dart';
import 'package:off_top_mobile/themes/themeSharedPreferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemePreference themePreference = ThemePreference();
  String _theme = 'blue';

  String get theme => _theme;

  set theme(String value) {
    _theme = value;
    themePreference.setTheme(value);
    notifyListeners();
  }
}
