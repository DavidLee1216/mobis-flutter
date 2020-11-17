import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/market_search_model.dart';
import 'model/order_model.dart';
import 'model/simple_search_model.dart';
import 'model/user_model.dart';
import 'model/product_model.dart';
import 'model/cart_model.dart';

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

int globalRecordCountPerPage = 10;

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

Future<List<CartModel>> load_cart(){
  String url = API + '/carts';
  if(globalUsername != '')
    url = API + '/carts?id=$globalUsername';
  http.get(url).then((response){
    if(response.statusCode==200){
      log('load cart success');
      final data = json.decode(response.body) as List;
      return data.map((item){
        return CartModel.fromMap(item);
      });
    }
    else{
      log('load cart ' + response.statusCode.toString());
      return new List<CartModel>();
    }
  });
}

Future<bool> add_to_cart(Product product)=>
  http.post(API+'/addCart', body: jsonEncode(product.toMap()), headers: { 'Content-type': 'application/json',}).then((response) {
    if(response.statusCode==200)
    {
      log('add_cart success');
      return true;
    }
    else{
      log('add_cart ${response.statusCode}');
      return false;
    }
  });
  
Future<bool> del_from_cart(int seq) =>
  http.post(API+'/delCart', body: jsonEncode({'seq': seq}), headers: {'Content-type': 'application/json',}).then((response){
    if(response.statusCode==200){
      log('del cart success');
      return true;
    } else{
      log('del cart ${response.statusCode}');
      return false;
    }
  });

bool validate_email(String email){
  http.get(API + '/validateEmail/{email}/email=$email').then((response) {
    if(response.statusCode==200)
    {
      log('validate_email success');
      return true;
    }
    else
    {
      log('validate_email ${response.statusCode}');
      return false;
    }
  } );
}

String validate_code(String code){
  http.get(API + '/validateCode/{code}/code=$code').then((response) {
    if(response.statusCode==200)
    {
      final jsonData = json.decode(response.body);
      return jsonData['seq'];
    }
    else
      return '';
  } );
}

String get_email(String code){
  http.post(API+'/getEmail', body: jsonEncode({'seq': code}), headers: { 'Content-type': 'application/json',}).then((response){
    if(response.statusCode==200){
      final jsonData = json.decode(response.body);
      return jsonData['email'];
    }
  });
}

bool reset_password(String password, String seq){
  http.post(API+'/resetPassword', body: jsonEncode({'password':password, 'seq': seq}), headers: { 'Content-type': 'application/json',}).then((response){
    if(response.statusCode==200) {
      log('success');
      return true;
    }
    else{
      log(response.statusCode.toString());
      return false;
    }

  });
}

Future<bool> signin(String username, String password)=>
    http.post(API+'/signin', body: jsonEncode({'password':password, 'username':username}), headers: { 'Content-type': 'application/json',}).then((response) {
      if(response.statusCode==200) {
        log('success');
        return true;
      }
      else {
        log(response.statusCode.toString());
        return false;
      }
    });

Future<bool> signup(User user) =>
  http.post(API + '/signup', body: jsonEncode(user.toMap()), headers: { 'Content-type': 'application/json',}).then((response){
    if(response.statusCode==200){
      log('success');
      return true;
    }
    else
    {
      log(response.statusCode.toString());
      return false;
    }
  });

Future<bool> order(Order order) =>
    http.post(API + '/order', body: jsonEncode(order.toMap()), headers: { 'Content-type': 'application/json',}).then((response){
      if(response.statusCode==200){
        log('order success');
        return true;
      }
      else
      {
        log('order' + response.statusCode.toString());
        return false;
      }
    });

Future<List<String>> get_models(String hkgb, String vtpy) async {
//  final response = await http.get(API + '/models/$hkgb/$vtpy');
  final response = await http.get(API + '/models?hkgb=$hkgb&vtpy=$vtpy');
  if(response.statusCode==200){
    log('model success');
    final data = json.decode(response.body) as List;
    return data.map((item){
      return item['cpnm'];
    });
  }else{
    log('model '+ response.statusCode.toString());
    throw Exception('error');
  }
}

Future<List<SimpleSearchResultModel>> simple_search_part(String hkgb, String catSeq, String vtpy, String searchWord, int firstIndex, int recordCountPerPage) async {
  final response = await http.get(API + '//partPrcList?hkgb=$hkgb&catSeq=$catSeq&vtyp=$vtpy&inText=$searchWord&firstIndex=$firstIndex&recordCountPerPage=$recordCountPerPage');
  if(response.statusCode==200){
    log('simple search success');
    final data = json.decode(response.body) as List;
    return data.map((item){
      return SimpleSearchResultModel.fromMap(item);
    });
  }else{
    log('simple search '+response.statusCode.toString());
  }
}

Future<List<MarketSearchResultModel>> market_search_part(String hkgb, String ptno, String sido, String sigungu, String stype, int firstIndex, int recordCountPerPage) async {
  final response = await http.get(API + '//partPrcList?hkgb=$hkgb&ptno=$ptno&sido=$sido&sigungu=$sigungu&firstIndex=$firstIndex&recordCountPerPage=$recordCountPerPage');
  if(response.statusCode==200){
    log('market search success');
    final data = json.decode(response.body) as List;
    return data.map((item){
      return MarketSearchResultModel.fromMap(item);
    });
  }else{
    log('market search '+response.statusCode.toString());
  }
}
