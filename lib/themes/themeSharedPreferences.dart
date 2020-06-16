/*I think this class should be deprecated in favor of the settings database
* when it is set up. We can get the theme String from the db and call it in our
* main.dart . Unsure if that will work though*/

import 'package:shared_preferences/shared_preferences.dart';

class ThemePreference {
  static const String PRIMARY_THEME = 'PRIMARY_THEME';
  static const String SECONDARY_THEME = 'SECONDARY_THEME';
  static const String ACCENT_THEME = 'ACCENT_THEME';
  static const String BACKGROUND_THEME = 'BACKGROUND_THEME';

  Future<bool> setPrimaryTheme(int theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(PRIMARY_THEME, theme);
  }

  Future<int> getPrimaryTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(PRIMARY_THEME);
  }

  Future<bool> setSecondaryTheme(int theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(SECONDARY_THEME, theme);
  }

  Future<int> getSecondaryTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(SECONDARY_THEME);
  }

  Future<bool> setAccentTheme(int theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(ACCENT_THEME, theme);
  }

  Future<int> getAccentTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(ACCENT_THEME);
  }

  Future<bool> setBackgroundTheme(int theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(BACKGROUND_THEME, theme);
  }

  Future<int> getBackgroundTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(BACKGROUND_THEME);
  }
}
