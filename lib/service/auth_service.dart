import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobispartsearch/bloc/auth_bloc.dart';
import 'package:mobispartsearch/ui/screen/register_screen.dart';
import 'package:mobispartsearch/utils/navigation.dart';
import 'package:mobispartsearch/common.dart' as common;
import 'alert_service.dart';

checkIfUserExists() async {
  return await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).get();
}

class MyGoogleSignin{
  GoogleSignInAccount  _currentUser;
  String _contactText;

  Future<void> _handleGetContact() async {
    final http.Response response = await http.get(
        'https://people.googleapis.com/v1/people/me/connections'
            '?requestMask.includeField=person.names',
        headers: await _currentUser.authHeaders);

    if (response.statusCode != 200) {
      print("People API ${response.statusCode} response: ${response.body}");
      return;
    }

    final Map<String, dynamic> data = json.decode(response.body);
    final String namedContact = _pickFirstNamedContact(data);
    if (namedContact != null) {
      _contactText = "I see you know $namedContact";
    } else {
      _contactText = "No contacts to display.";
    }
  }

  String _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic> connections = data['connections'];
    final Map<String, dynamic> contact = connections?.firstWhere(
          (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    );
    if (contact != null) {
      final Map<String, dynamic> name = contact['names'].firstWhere(
            (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      );
      if (name != null) {
        return name['displayName'];
      }
    }
    return null;
  }

  signInWithGoogle(BuildContext context) async {
    try {
      showLoading(context);
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final GoogleSignIn googleSignIn = GoogleSignIn();
//      final GoogleSignIn googleSignIn = GoogleSignIn(scopes: <String>[
//        'email',
//        'https://www.googleapis.com/auth/contacts.readonly',
//      ]);

      _currentUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await _currentUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult = await _auth.signInWithCredential(credential);
      common.googleUser = authResult.user;

      assert(common.googleUser.email != null);
      assert(common.googleUser.displayName != null);
      assert(common.googleUser.photoURL != null);
      assert(!common.googleUser.isAnonymous);
      assert(await common.googleUser.getIdToken() != null);

      Navigator.of(context, rootNavigator: true).pop('dialog');


      return true;
    } catch (e) {
      common.googleUser = null;
      Navigator.of(context, rootNavigator: true).pop('dialog');
      common.showToastMessage(text: '구글계정이 연결되지 않았습니다.');
      return false;
    }
  }

}
