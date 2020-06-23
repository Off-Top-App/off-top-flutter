import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:off_top_mobile/accountCreation.dart';
import 'package:off_top_mobile/recordingSession.dart';
import 'package:off_top_mobile/routing/routing_constants.dart';
import 'package:off_top_mobile/components/offTopTitle.dart';
//import 'package:off_top_mobile/lib/settings_page.dart'; // will edit to sign-up page

import 'package:http/http.dart' as http;
import 'package:off_top_mobile/components/footer/bottomNavigationTabs.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

int repoNumber;

//String userEmail;
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

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  Future<FirebaseUser> _handleSignIn() async {
    FirebaseUser user;
    final bool isSignedIn = await _googleSignIn.isSignedIn();
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
    final FirebaseUser user = await _handleSignIn();
    userEmail = user.email;
    name = user.displayName;
  }

  Future<void> makeLoginRequest() async {
    final String userEmail = this.userEmail;
    //userEmail = this.userEmail;
    final String url = 'http://localhost:9000/user/$userEmail';
    debugPrint('working before lines 68 and 69');
    //String url = 'http://10.0.2.2:9000/user/${userEmail}/';
    final http.Response response = await http.get(
        Uri.encodeFull(
            url), //lines 68-69 breaks when a google sign-in email does not exist in db
        headers: <String, String>{'Accept': 'application/json'});

    repoNumber = response.statusCode;
    debugPrint('This is the respone number: ' + repoNumber.toString());
    if (response.statusCode == 200) {
      debugPrint('Code is working respone accpted');
    } else {
      //throw Exception('Response failed to load');
      return;
    }
    final dynamic userData = json.decode(response.body);
    /*Create a way to check if the user google email is in our database(db)*/
    //if(userData == null){// needs fixing

    //}
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
        child: Container(
          padding: const EdgeInsets.all(50),
          child: Align(
            alignment: Alignment.center,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: () async {
                try {
                  setState(
                    () {
                      showLoading = true;
                    },
                  );
                  //debugPrint('working before google sign in');
                  await onGoogleSignIn(context);
                  // debugPrint('Will shoot error after google sign-in');
                  await makeLoginRequest();
                  debugPrint('jumped out of method');

                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => BottomNavigationTabs(
                        RecordingPage(userId: userId),
                      ),
                    ),
                  );
                  if (repoNumber != 200) {
                    // jumps to signup
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignUp(email: userEmail)),
                    );
                    debugPrint('is in SignUp');
                  }
                  setState(() {
                    showLoading = false;
                  });
                } catch (e) {
                  print(e);
                  setState(() {
                    showLoading = false;
                  });
                }
              },
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
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
