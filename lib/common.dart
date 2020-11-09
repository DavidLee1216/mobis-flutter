import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum Gender{male, female}

const kPrimaryColor = Color.fromRGBO(0, 71, 135, 1);
const kTitleStyle = TextStyle(fontSize: 18, color: Colors.white);
const kSubtitleStyle = TextStyle(fontSize: 14, color: Colors.white);
const kButtonTextStyle = TextStyle(fontSize: 14, color: Colors.white);
const kMenuTextStyle = TextStyle(fontSize: 12);
const kMarginSpace = 40.0;
const kImageWidth = 80.0;

const API = 'http://api.com';

bool check_username(String username){
  http.get(API + '/username/{$username}',).then((value) => value.statusCode==200?true:false);
}

bool check_email(String email){
  http.get(API + '/email/{$email}',).then((value) => value.statusCode==200?true:false);
}

bool validate_SMS(String mobile){
  http.get(API + '/validateSMS/{$mobile}').then((value) {
    if(value.statusCode==200)
      return true;
    else
      return false;
  } );
}

bool validate_email(String email){
  http.get(API + '/validateEmail/{$email}').then((value) {
    if(value.statusCode==200)
      return true;
    else
      return false;
  } );
}

String validate_code(String code){
  http.get(API + '/validateCode/{$code}').then((value) {
    if(value.statusCode==200)
    {
      final jsonData = json.decode(value.body);
      return jsonData['code'];
    }
    else
      return '';
  } );
}

String get_email(String code){
  http.post(API+'/getEmail', body: {'seq': code}).then((value){
    if(value.statusCode==200){
      final jsonData = json.decode(value.body);
      return jsonData['email'];
    }
  });
}

bool reset_password(String password, String seq){
  http.post(API+'/resetPassword', body: {'password':password, 'seq': seq}).then((value){
    if(value.statusCode==200) {
      return true;
    }
    else
      return false;
  });
}

bool signup(String id, String mobile, String legalName, String vin, String zipcode, String dateOfBirth, String vlp, String address, String addressExtended, String password, String sexCode, String email){
  http.post(API + '/signup', body: {
    'username': id,
    'ntoken': '',
    'mobile': mobile,
    'legalName': legalName,
    'vin': vin,
    'zipcode': zipcode,
    'gtoken': '',
    'dateOfBirth': dateOfBirth,
    'ktoken': '',
    'vlp': vlp,
    'address': address,
    'addressExtended': addressExtended,
    'password': password,
    'sexCode': sexCode,
    'email': email
  }).then((data){
    if(data.statusCode==200){
      return true;
    }
    else
      return false;
  });
}

