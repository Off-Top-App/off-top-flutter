import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserAuthentication {
  UserAuthentication({
    @required this.googleSignIn,
    @required this.firebaseAuth,
  });

  GoogleSignIn googleSignIn;
  FirebaseAuth firebaseAuth;

  Future<FirebaseUser> firebaseAuthentication() async {
    FirebaseUser user;
    final bool isSignedIn = await googleSignIn.isSignedIn();
    if (isSignedIn) {
      user = await firebaseAuth.currentUser();
    }
    else {
      user = authenticateUser() as FirebaseUser;
    }

    return user;
  }
  Future<FirebaseUser> authenticateUser() async{
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    return (await firebaseAuth.signInWithCredential(credential)).user;
  }


  Future<String> signInWithGoogle(BuildContext context) async {
    final FirebaseUser user = await firebaseAuthentication();
    return user.email;
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
  }
}
