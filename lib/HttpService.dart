import 'dart:convert';
import 'package:off_top_mobile/models/UserSettings.dart';
import 'package:http/http.dart';

class HttpService{
  final String userSettingsUrl = "http://localhost:3000/api/userSettings";

  Future<List<UserSettings>> getSettings() async{
    Response res = await get(postUrl);
    if(res.statusCode == 200){
      List<dynamic> body = jsonDecode(res.body);

      List<UserSettings> settings = body.map((map))

    }

  }
}