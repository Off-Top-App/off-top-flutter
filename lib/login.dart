import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:off_top_mobile/recordingSession.dart';
import 'package:off_top_mobile/routing/routing_constants.dart';
import 'package:off_top_mobile/components/offTopTitle.dart';

import 'package:http/http.dart' as http;
import 'package:off_top_mobile/components/footer/bottomNavigationTabs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController loginController = TextEditingController();
  int userId;
  int loginAttempts = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: offTopTitle(context),
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text(
                    'Off-Top Login',
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w800,
                        color: Colors.black54),
                  ),
                  const SizedBox(height: 20.0),
                  usernameField(),
                  const SizedBox(height: 10.0),
                  passwordField,
                  isEmailValid(),
                  const SizedBox(height: 15.0),
                  loginButton(context),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      forgotPassword(context),
                      createAccount(context),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget isEmailValid() {
    if (userId == null && loginAttempts > 0) {
      return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text('Invalid Email. Try again!',
              style: TextStyle(color: Colors.red)));
    } else {
      return const Text('');
    }
  }

  Widget usernameField() {
    return TextField(
      controller: loginController,
      obscureText: false,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'Username',
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
  }

  Widget passwordField = TextField(
    obscureText: true,
    decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Password',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
  );

  Widget forgotPassword(BuildContext context) {
    return FlatButton(
      child: const Text('forgot password?'),
      onPressed: () {
        Navigator.pushNamed(context, RecordingRoute);
      },
    );
  }

  Widget createAccount(BuildContext context) {
    return FlatButton(
      child: const Text('create account'),
      onPressed: () {
        Navigator.pushNamed(context, RecordingRoute);
      },
    );
  }

  Future<void> makeLoginRequest() async {
    final String userEmail = loginController.text;
    final String url = 'http://localhost:9000/user/$userEmail';
    //String url = 'http://10.0.2.2:9000/user/${userEmail}/';
    final http.Response response = await http.get(Uri.encodeFull(url),
        headers: <String, String>{'Accept': 'application/json'});
    final dynamic userData = json.decode(response.body);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
      'name',
      userData['firstName'].toString(),
    );
    setState(
      () {
        userId = int.parse(userData['Id'].toString());
      },
    );
  }

  Widget loginButton(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      color: Theme.of(context).primaryColor,
      child: const Text('SIGN IN'),
      textColor: Colors.white,
      onPressed: () {
        setState(
          () {
            loginAttempts += 1;
          },
        );
        makeLoginRequest();
        if (userId != null) {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => BottomNavigationTabs(
                RecordingPage(userId: userId),
              ), //changed route to include initial page
            ),
          );
        }
      },
    );
  }
}
