import 'dart:convert';
import 'package:off_top_mobile/models/UserSettings.dart';
import 'package:http/http.dart';

class HttpService{
  final String userSettingsUrl = "http://localhost:3000/api/userSettings";

  Future<List<UserSettings>> getSettings() async{
    final Response res = await get(userSettingsUrl);
    if(res.statusCode == 200){
      final List<dynamic> body = jsonDecode(res.body) as List;

      List<UserSettings> settings =
      body.map((dynamic item) => UserSettings.fromJson(item as Map<String, dynamic>)).toList();
      return settings;
    }else{
      throw 'Cannot get settings.';
    }
  }
}