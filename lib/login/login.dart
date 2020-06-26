import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:off_top_mobile/recordingSession.dart';

import 'package:http/http.dart' as http;
import 'package:off_top_mobile/components/footer/bottomNavigationTabs.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:off_top_mobile/login/googleSignIn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int userId;
  String userEmail;
  String name;
  bool showLoading = false;
  UserAuthentication auth;

  @override
  void initState() {
    super.initState();
    auth = UserAuthentication();
  }

  Future<void> getUserData() async {
    final String userEmail = this.userEmail;
    final String url = 'http://localhost:9000/user/$userEmail';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: ModalProgressHUD(
        inAsyncCall: showLoading,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            displayProfilePic(context),
            Container(
              padding: const EdgeInsets.all(50),
              child: Align(
                alignment: Alignment.center,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () async => signInRequest(),
                  color: Colors.lightBlue,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.account_circle, color: Colors.white),
                        const SizedBox(width: 10),
                        const Text('Sign in with Google!'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget displayProfilePic(BuildContext context) {
    return Container(
      child: Image.asset(
        'assets/images/Off-Top_Logo.jpg',
        height: 275,
        width: 275,
        fit: BoxFit.fitWidth,
      ),
    );
  }

  Future<void> signInRequest() async {
    try {
      setState(
        () {
          showLoading = true;
        },
      );
      userEmail = await auth.signInWithGoogle(context);
      await getUserData();

      await Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => BottomNavigationTabs(
            RecordingPage(userId: userId),
          ),
        ),
      );
      setState(() {
        showLoading = false;
      });
    } catch (e) {
      setState(() {
        showLoading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
