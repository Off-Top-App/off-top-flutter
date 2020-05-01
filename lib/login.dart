import 'package:flutter/material.dart';
import 'package:off_top_mobile/recordingSession.dart';
import 'package:off_top_mobile/routing/routing_constants.dart';
import 'package:off_top_mobile/components/offTopTitle.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: offTopTitle,
        body: Center(
            child: Container(
          child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                Text(
                  'Off-Top Login',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w800,
                      color: Colors.black54),
                ),
                SizedBox(height: 20.0),
                usernameField,
                SizedBox(height: 10.0),
                passwordField,
                SizedBox(height: 15.0),
                loginButton(context),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      forgotPassword(context),
                      createAccount(context),
                    ]),
              ]))),
        )));
  }

  final usernameField = TextField(
    obscureText: false,
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Username",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
  );

  final passwordField = TextField(
    obscureText: true,
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
  );

//temporarily goes to main page
  Widget forgotPassword(BuildContext context) {
    return FlatButton(
      child: Text('forgot password?'),
      onPressed: () {
        Navigator.pushNamed(context, RecordingRoute);
      },
    );
  }

//temporarily goes to main page
  Widget createAccount(BuildContext context) {
    return FlatButton(
      child: Text('create account'),
      onPressed: () {
        Navigator.pushNamed(context, RecordingRoute);
      },
    );
  }

  //String url = 'http://localhost:9000/user/john.doe@email.com';
  String url = "http://10.0.2.2:9000/user/john.doe@email.com/";
  Future<int> makeLoginRequest() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var userData = json.decode(response.body);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("name", userData['firstName']);
    int userId = userData['Id'];
    
    return userId;
  }

  Widget loginButton(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(18.0),
      ),
      color: Colors.deepPurple,
      child: Text('SIGN IN'),
      textColor: Colors.white,
      onPressed: () async {
        int userId = await makeLoginRequest();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecordingPage(userId: userId),
          ),
        );
      },
    );
  }
}
