import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobispartsearch/ui/widget/navigation_bar.dart';
import 'package:mobispartsearch/utils/navigation.dart';
import 'alert_service.dart';

checkIfUserExists() async {
  return await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).get();
}

signInWithGoogle(BuildContext context) async {
  try {
    showLoading(context);
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult = await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoURL != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    Navigator.of(context, rootNavigator: true).pop('dialog');
    pushTo(context, NavigationBar(index: 1));
  } catch (e) {
    print(e);
    showToastMessage(text:'오류가 발생하였습니다.');
    //closeDialog(context);
  }
}
