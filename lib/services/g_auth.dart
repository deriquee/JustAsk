import 'package:chat_gh/views/chat_signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

getCurrentUser() async {
  return await auth.currentUser;
}

gsignin(BuildContext context) async {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();

  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken);
  print(googleSignInAuthentication.accessToken);
  SharedPreferences token_g = await SharedPreferences.getInstance();
  token_g.setString('g_token', googleSignInAuthentication.accessToken);
  print('token set');
}
