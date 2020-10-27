import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class User {
  String email;
  String uid;
  String displayName;
  String phoneNumber;
  String address1;
  String address2;
  String postCode;
  String id;

  User({
    this.uid,
    this.id,
    this.email,
    this.displayName,
    this.phoneNumber,
    this.address1,
    this.address2,
    this.postCode,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'id': id,
      'email': email,
      'displayName': displayName,
      'phoneNumber': phoneNumber,
      'address1': address1,
      'address2': address2,
      'postCode': postCode,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) => User(
    uid: map['uid'],
    id: map['id'],
    email: map['email'],
    displayName: map['displayName'],
    phoneNumber: map['phoneNumber'],
    address1: map['address1'],
    address2: map['address2'],
    postCode: map['postCode'],
  );

  factory User.fromFirebaseUser(auth.User user) => User(
    uid: user.uid,
    email: user.email,
    displayName: user.displayName,
    phoneNumber: user.phoneNumber,
  );
}