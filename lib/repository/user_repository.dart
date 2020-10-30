import 'dart:async';
import 'dart:developer';
import 'package:hyundai_mobis/model/user_model.dart';

class UserRepository {

  UserRepository();

  Future<User> signInWithCredentials({String id, String password}) async {
//    auth.UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
//      email: email,
//      password: password,
//    );
//    auth.User fbUser = userCredential.user;
    User user = User(uid:"001" , id:"testUser", email:'Anonymous@gmail.com', displayName:'AnonymousName', phoneNumber:'0022222', address1:'address_line1', address2:'address_line2', postCode:'0011');
    return user;//User.fromFirebaseUser(user);
  }

//  Future<User> signUp({String email, String password}) async {
//      email: email,
//      password: password,
//    );
//      'uid': fbUser.uid,
//      'email': fbUser.email,
//      'displayName': fbUser.displayName,
//      'phoneNumber': fbUser.phoneNumber,
//    });
//    return User.fromFirebaseUser(fbUser);
//  }
//
//  Future<void> signOut() async {
//    return Future.wait([
//      _firebaseAuth.signOut(),
//    ]);
//  }
//
//  Future<bool> isSignedIn() async {
//    final currentUser = await _firebaseAuth.currentUser;
//    return currentUser != null;
//  }
//
//  Future<User> getUser() async {
//    return User.fromFirebaseUser(await _firebaseAuth.currentUser);
//  }
//
//  Stream<QuerySnapshot> getUserStream() {
//    return _firestore
//        .collection('users')
//        .snapshots();
//  }
//
}
