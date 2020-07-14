import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:off_top_mobile/models/User.dart';
import 'package:http/http.dart' as http;


class UserService{

  User setUserData(
    String age, 
    String city, 
    String createdAt,
    String deletedAt,
    String email,
    String firstName,
    String gender,
    String lastName,
    String profession,
    String userName){
    
    return User(
      age,
      city,
      createdAt,
      deletedAt,
      email,
      firstName,
      gender,
      lastName,
      profession,
      userName
    );
  }

  Future<void> insertNewUser(User user) async{
    const String address = 'http://localhost:8000/setUser';
    final Map<String, String> headers = <String, String>{
      'Content-type': 'application/json'
    };
    debugPrint('Inserting new user: $user');
    final http.Response call = await http.post(address,
        headers: headers, body: json.encode(user.toJson()));

    final int checkCode = call.statusCode;
    if (checkCode == 200) {
      debugPrint('call accepted');
    } else {
      debugPrint(checkCode.toString());
      throw Exception('Response failed to load');
    }
  }

}