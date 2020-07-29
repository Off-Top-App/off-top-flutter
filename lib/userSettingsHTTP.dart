import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:off_top_mobile/models/UserSettings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class HttpSettings {
  int responseCode;
  String email = '';

  HttpSettings(this.email);

  Future<void> getUserData(UserSettings _userSettings) async {
    final String url = 'http://localhost:3000/api/userSettings/email?user_email=$email';
    final http.Response response = await http.get(Uri.encodeFull(url),
        headers: <String, String>{'Accept': 'application/json'});
    responseCode = response.statusCode;
    if (response.statusCode == 200) {
      debugPrint('Code is working response accepted');
    } else if (responseCode == 404) {
      throw Exception('Response failed to load code 404');
    } else {
      debugPrint('ResponseCode is: ' + responseCode.toString());
      return;
    }

    dynamic jsonObject = json.decode(response.body);
    _userSettings.setUserSettingsData(jsonObject);
    print(_userSettings.appColor);
  }
}
