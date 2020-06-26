import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserAuthentication {
  GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<dynamic> firebaseAuthentication() async {
    dynamic user;
    final bool isSignedIn = await googleSignIn.isSignedIn();
    if (isSignedIn) {
      user = await firebaseAuth.currentUser();
    } else {
      user = authenticateUser();
    }

    return user;
  }

  Future<FirebaseUser> authenticateUser() async {
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    return (await firebaseAuth.signInWithCredential(credential)).user;
  }

  Future<String> signInWithGoogle(BuildContext context) async {
    final dynamic user = await firebaseAuthentication();
    return user.email.toString();
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
  }
}
