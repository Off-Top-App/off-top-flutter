import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:off_top_mobile/recordingSession.dart';
import 'package:off_top_mobile/routing/routing_constants.dart';
import 'package:off_top_mobile/components/offTopTitle.dart';

import 'package:http/http.dart' as http;
import 'package:off_top_mobile/components/footer/bottomNavigationTabs.dart';
import 'package:off_top_mobile/settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController loginController = TextEditingController();
  int userId;
  int loginAttempts = 0;
  String userEmail;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<FirebaseUser> _handleSignIn() async {
    FirebaseUser user;
    bool isSignedIn = await _googleSignIn.isSignedIn();
    if (isSignedIn) {
      user = await _auth.currentUser();
    } else {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

      user = (await _auth.signInWithCredential(credential)).user;
    }
    return user;
  }

  Future<void> onGoogleSignIn(BuildContext context) async {
    FirebaseUser user = await _handleSignIn();
    userEmail = user.email;
    if (userId == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => BottomNavigationTabs(
          RecordingPage(userId: userId),
        ), //changed route to include initial page
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(50),
        child: Align(
          alignment: Alignment.center,
          child: FlatButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPressed: () {
              makeLoginRequest();
              onGoogleSignIn(context);
            },
            color: Colors.blueAccent,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.account_circle, color: Colors.white),
                  SizedBox(width: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> makeLoginRequest() async {
    final String userEmail = this.userEmail;
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
  /*
  Widget loginButton(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      color: Theme.of(context).primaryColor,
      child: const Text('SIGN IN'),
      textColor: Theme.of(context).secondaryHeaderColor,
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

   */
}

class WelcomeUserWidget extends StatelessWidget {
  GoogleSignIn _googleSignIn;
  FirebaseUser _user;

  WelcomeUserWidget(FirebaseUser user, GoogleSignIn signIn) {
    _user = user;
    _googleSignIn = signIn;
  }
  @override
  Widget build(BuildContext context) {
    ClipOval(
        child: Image.network(_user.photoUrl,
            width: 100, height: 100, fit: BoxFit.cover));
    Text(_user.displayName,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25));

    FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: () {
          _googleSignIn.signOut();
          Navigator.pop(context);
        });
  }
}
