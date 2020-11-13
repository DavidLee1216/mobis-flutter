import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/order_model.dart';
import 'model/user_model.dart';
import 'model/product_model.dart';

enum Gender{male, female}

const kPrimaryColor = Color.fromRGBO(0, 71, 135, 1);
const kTitleStyle = TextStyle(fontSize: 18, color: Colors.white);
const kSubtitleStyle = TextStyle(fontSize: 14, color: Colors.white);
const kButtonTextStyle = TextStyle(fontSize: 14, color: Colors.white);
const kMenuTextStyle = TextStyle(fontSize: 12);
const kMarginSpace = 40.0;
const kImageWidth = 80.0;

const API = 'http://141.164.51.190:8080';

String globalUsername = '';

User globalUser = new User();

bool check_username(String username){
  http.get(API + '/username/{username}?username=$username',).then((value){
    if(value.statusCode==200)
    {
      log('success');
      return true;
    }
    else{
      log(value.statusCode.toString());
      return false;

    }
  });
}

bool check_email(String email){
  http.get(API + '/email/{email}?email=$email',).then((value) {
    if(value.statusCode==200){
      log('success');
      return true;
    }
    else {
      log(value.statusCode.toString());
      return false;
    }
  });
}

bool validate_SMS(String mobile){
  http.get(API + '/validateSMS/{mobile}/mobile=$mobile').then((value) {
    if(value.statusCode==200){
      log('validate_SMS success');
      return true;
    }
    else{
      log('validate_SMS ${value.statusCode}');
      return false;
    }
  } );
}

Future<bool> add_to_cart(Product product)=>
  http.post(API+'/addCart', body: jsonEncode(product.toMap()), headers: { 'Content-type': 'application/json',}).then((value) {
    if(value.statusCode==200)
    {
      log('add_cart success');
      return true;
    }
    else{
      log('add_cart ${value.statusCode}');
      return false;
    }
  });
  

bool validate_email(String email){
  http.get(API + '/validateEmail/{email}/email=$email').then((value) {
    if(value.statusCode==200)
    {
      log('validate_email success');
      return true;
    }
    else
    {
      log('validate_email ${value.statusCode}');
      return false;
    }
  } );
}

String validate_code(String code){
  http.get(API + '/validateCode/{code}/code=$code').then((value) {
    if(value.statusCode==200)
    {
      final jsonData = json.decode(value.body);
      return jsonData['seq'];
    }
    else
      return '';
  } );
}

String get_email(String code){
  http.post(API+'/getEmail', body: jsonEncode({'seq': code}), headers: { 'Content-type': 'application/json',}).then((value){
    if(value.statusCode==200){
      final jsonData = json.decode(value.body);
      return jsonData['email'];
    }
  });
}

bool reset_password(String password, String seq){
  http.post(API+'/resetPassword', body: jsonEncode({'password':password, 'seq': seq}), headers: { 'Content-type': 'application/json',}).then((value){
    if(value.statusCode==200) {
      log('success');
      return true;
    }
    else{
      log(value.statusCode.toString());
      return false;
    }

  });
}

Future<bool> signin(String username, String password)=>
    http.post(API+'/signin', body: jsonEncode({'password':password, 'username':username}), headers: { 'Content-type': 'application/json',}).then((value) {
      if(value.statusCode==200) {
        log('success');
        return true;
      }
      else {
        log(value.statusCode.toString());
        return false;
      }
    });

Future<bool> signup(User user) =>
  http.post(API + '/signup', body: jsonEncode(user.toMap()), headers: { 'Content-type': 'application/json',}).then((data){
    if(data.statusCode==200){
      log('success');
      return true;
    }
    else
    {
      log(data.statusCode.toString());
      return false;
    }
  });

Future<bool> order(Order order) =>
    http.post(API + '/order', body: jsonEncode(order.toMap()), headers: { 'Content-type': 'application/json',}).then((data){
      if(data.statusCode==200){
        log('order success');
        return true;
      }
      else
      {
        log('order' + data.statusCode.toString());
        return false;
      }
    });
