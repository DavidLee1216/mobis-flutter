import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/all.dart' as kakao;
import 'package:intl/intl.dart';
import 'package:mobispartsearch/model/signin_information.dart';

import 'model/user_model.dart';

const API = 'http://172.29.190.10:8080'; //'https://pss.mobis.co.kr'; //
DateFormat dateformatter = DateFormat('yyyy.MM.dd');
const List<String> hkgb_list = ['H', 'K'];
const List<String> vtpy_list = ['P', 'R', 'C'];
enum Gender { male, female }
int globalRecordCountPerPage = 10;


String globalUsername = '';

firebase.User googleUser;
kakao.User kakaoUser;

User globalUser = new User();
SigninInformation globalSigninInformation = new SigninInformation();

Map<String, String> requestHeader(String token){
  if(token != '')
    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  else
    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
}

const kPrimaryColor = Color.fromRGBO(0, 71, 135, 1);
const kTitleStyle =
TextStyle(fontFamily: 'HDharmony', fontSize: 18, color: Colors.white);
const kSubtitleStyle =
TextStyle(fontFamily: 'HDharmony', fontSize: 14, color: Colors.white);
const kButtonTextStyle =
TextStyle(fontFamily: 'HDharmony', fontSize: 14, color: Colors.white);
const kMenuTextStyle = TextStyle(fontFamily: 'HDharmony', fontSize: 12);
const kMarginSpace = 40.0;
const kImageWidth = 80.0;



class AppConfig{


}