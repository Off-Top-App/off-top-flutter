/*I think this class should be deprecated in favor of the settings database
* when it is set up. We can get the theme String from the db and call it in our
* main.dart . Unsure if that will work though*/

import 'package:shared_preferences/shared_preferences.dart';

class ThemePreference {
  static const String THEME = 'THEME';

  Future<bool> setTheme(String theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(THEME, theme);
  }

  Future<String> getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(THEME);
  }
}
