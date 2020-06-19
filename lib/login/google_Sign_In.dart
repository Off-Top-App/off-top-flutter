import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserAuth {
  UserAuth({
    @required this.googleSignIn,
    @required this.firebaseAuth,
  });

  GoogleSignIn googleSignIn;
  FirebaseAuth firebaseAuth;

  Future<FirebaseUser> signInWithGoogle() async {
    FirebaseUser user;
    final bool isSignedIn = await googleSignIn.isSignedIn();
    if (isSignedIn) {
      user = await firebaseAuth.currentUser();
    } else {
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

      user = (await firebaseAuth.signInWithCredential(credential)).user;
    }

    return user;
  }

  Future<String> onGoogleSignIn(BuildContext context) async {
    final FirebaseUser user = await signInWithGoogle();
    return user.email;
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
  }
}
