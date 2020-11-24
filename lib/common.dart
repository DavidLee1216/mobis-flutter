import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'model/location_model.dart';
import 'model/market_search_model.dart';
import 'model/notice_model.dart';
import 'model/order_model.dart';
import 'model/simple_search_model.dart';
import 'model/user_model.dart';
import 'model/product_model.dart';
import 'model/cart_model.dart';

dynamic session = '';

DateFormat dateformatter = DateFormat('yyyy.MM.dd');

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
math.Random _rnd = math.Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

void getSession() async {
  session = await FlutterSession().get('mobis_session');
  if (session == null) {
    DateTime time = DateTime.now();
    String ss = getRandomString(10);
    List<int> newCodes = new List<int>();
    List<int> charCodes = time.toString().codeUnits;
    charCodes.forEach((element) {
      if (element >= 0x30 && element < 0x40)
        element += 0x20;
      else
        element += 0x30;
      newCodes.add(element);
    });
    String sss = String.fromCharCodes(newCodes);
    log(sss);
    String sessionStr = ss + sss;
    await FlutterSession().set('mobis_session', sessionStr);
    session = await FlutterSession().get('mobis_session');
  }
}

enum Gender { male, female }

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
bool globalSidoLoaded = false;

int globalRecordCountPerPage = 10;

List<Sido> globalSido = new List<Sido>();

void getSido() async{
  await http.get(API + '/sido').then((response){
    if(response.statusCode==200){
      log('sido success');
      final data = json.decode(utf8.decode(response.bodyBytes)) as List;
      log(data.toString());
      globalSido = data.map((e) => Sido.fromMap(e)).toList();
      getSigungu();
    }
    else{
      log('get sido ${response.statusCode}');
    }
  });
}

Sido findSido(String sido) {
  for (Sido item in globalSido) {
    if (item.sido == sido) return item;
  }
  return null;
}

String findFirstSigungu(String sido) {
  Sido sidoObj = findSido(sido);
  return sidoObj.sigungus[0].sigungu;
}

void getSigungu() async{
  for(Sido sido in globalSido){
    log(sido.seq.toString());
    await http.get(API + '/sigungu?seq=${sido.seq}').then((response){
      if(response.statusCode==200){
        final data = json.decode(utf8.decode(response.bodyBytes)) as List;
        log('get sigungu success '+data.toString());
        sido.sigungus = data.map((e) => Sigungu.fromMap(e)).toList();
      } else{
        log('get sigungu ${response.statusCode}');
      }
    });
    if(sido == globalSido.last)
    {
      log('global sido true');
      globalSidoLoaded = true;
    }
  }
}

bool updateProfile(String addressExtended, String address, String mobile,
    String password, String zipCode, String email) {
  http
      .post(API + '/profile',
          body: jsonEncode({
            'addressExtended': addressExtended,
            'address': address,
            'mobile': mobile,
            'password': password,
            'zipcode': zipCode,
            'email': email
          }))
      .then((response) {
    if (response.statusCode == 200) {
      log('profile success');
    } else {
      log('profile ${response.statusCode}');
    }
  });
}

bool checkUsername(String username) {
  http
      .get(
    API + '/username/{username}?username=$username',
  )
      .then((response) {
    if (response.statusCode == 200) {
      log('success');
      return true;
    } else {
      log(response.statusCode.toString());
      return false;
    }
  });
}

bool checkEmail(String email) {
  http
      .get(
    API + '/email/{email}?email=$email',
  )
      .then((response) {
    if (response.statusCode == 200) {
      log('success');
      return true;
    } else {
      log(response.statusCode.toString());
      return false;
    }
  });
}

bool validateSMS(String mobile) {
  http.get(API + '/validateSMS/{mobile}/mobile=$mobile').then((response) {
    if (response.statusCode == 200) {
      log('validate_SMS success');
      return true;
    } else {
      log('validate_SMS ${response.statusCode}');
      return false;
    }
  });
}

Future<List<CartModel>> loadCart() {
  String url = API + '/carts';
  if(globalUsername != '')
    url = API + '/carts?id=$globalUsername';
  else
    url = API + '/carts?id=$session';
  http.get(url).then((response){
    if(response.statusCode==200){
      log('load cart success');
      final data = json.decode(utf8.decode(response.bodyBytes)) as List;
      return data.map((item){
        return CartModel.fromMap(item);
      });
    } else {
      log('load cart ' + response.statusCode.toString());
      return new List<CartModel>();
    }
  });
}

Future<bool> addToCart(Product product) =>
    http.post(API + '/addCart', body: jsonEncode(product.toMap()), headers: {
      'Content-type': 'application/json',
    }).then((response) {
      if (response.statusCode == 200) {
        log('add_cart success');
        return true;
      } else {
        log('add_cart ${response.statusCode}');
        return false;
      }
    });

Future<bool> delFromCart(int seq) =>
    http.post(API + '/delCart', body: jsonEncode({'seq': seq}), headers: {
      'Content-type': 'application/json',
    }).then((response) {
      if (response.statusCode == 200) {
        log('del cart success');
        return true;
      } else {
        log('del cart ${response.statusCode}');
        return false;
      }
    });

bool validateEmail(String email) {
  http.get(API + '/validateEmail/{email}/email=$email').then((response) {
    if (response.statusCode == 200) {
      log('validate_email success');
      return true;
    } else {
      log('validate_email ${response.statusCode}');
      return false;
    }
  });
}

String validateCode(String code) {
  http.get(API + '/validateCode/{code}/code=$code').then((response) {
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['seq'];
    } else
      return '';
  });
}

String getEmail(String code) {
  http.post(API + '/getEmail', body: jsonEncode({'seq': code}), headers: {
    'Content-type': 'application/json',
  }).then((response) {
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['email'];
    }
  });
}

bool resetPassword(String password, String seq) {
  http.post(API + '/resetPassword',
      body: jsonEncode({'password': password, 'seq': seq}),
      headers: {
        'Content-type': 'application/json',
      }).then((response) {
    if (response.statusCode == 200) {
      log('success');
      return true;
    } else {
      log(response.statusCode.toString());
      return false;
    }
  });
}

Future<bool> signin(String username, String password) =>
    http.post(API + '/signin',
        body: jsonEncode({'password': password, 'username': username}),
        headers: {
          'Content-type': 'application/json',
        }).then((response) {
      if (response.statusCode == 200) {
        log('success');
        globalUsername = username;
        return true;
      } else {
        log(response.statusCode.toString());
        return false;
      }
    });

Future<bool> signup(User user) =>
    http.post(API + '/signup', body: jsonEncode(user.toMap()), headers: {
      'Content-type': 'application/json',
    }).then((response) {
      if (response.statusCode == 200) {
        log('success');
        return true;
      } else {
        log(response.statusCode.toString());
        return false;
      }
    });

Future<bool> order(Order order) =>
    http.post(API + '/order', body: jsonEncode(order.toMap()), headers: {
      'Content-type': 'application/json',
    }).then((response) {
      if (response.statusCode == 200) {
        log('order success');
        return true;
      } else {
        log('order' + response.statusCode.toString());
        return false;
      }
    });

Future<List<String>> getModelsFromRemote(String hkgb, String vtpy) async {
  final response = await http.get(API + '/models?hkgb=$hkgb&vtyp=$vtpy');
  if(response.statusCode==200){
    log('model success');
    final data = json.decode(utf8.decode(response.bodyBytes)) as List;
    return data.map((item){
      return item['cpnm'].toString();
    }).toList();
  }else{
    log('model '+ response.statusCode.toString());
    throw Exception('error');
  }
}

Future<List<SimpleSearchResultModel>> simpleSearchPart(
    String hkgb,
    String catSeq,
    String vtpy,
    String searchWord,
    int firstIndex,
    int recordCountPerPage) async {
  final response = await http.get(API +
      '/partPrcList?hkgb=$hkgb&catSeq=$catSeq&vtyp=$vtpy&inText=$searchWord&firstIndex=$firstIndex&recordCountPerPage=$recordCountPerPage');
  if (response.statusCode == 200) {
    log('simple search success');
    final data = json.decode(utf8.decode(response.bodyBytes)) as List;
    return data.map((item) {
      return SimpleSearchResultModel.fromMap(item);
    });
  } else {
    log('simple search ' + response.statusCode.toString());
    return null;
  }
}

Future<List<MarketSearchResultModel>> marketSearchPart(
    String hkgb,
    String ptno,
    String sido,
    String sigungu,
    String stype,
    int firstIndex,
    int recordCountPerPage) async {
  final response = await http.get(API +
      '/partInvenList?hkgb=$hkgb&ptno=$ptno&sido=$sido&sigungu=$sigungu&stype=$stype&firstIndex=$firstIndex&recordCountPerPage=$recordCountPerPage');
  if (response.statusCode == 200) {
    log('market search success');
    final data = json.decode(utf8.decode(response.bodyBytes)) as List;
    return data.map((item) {
      return MarketSearchResultModel.fromMap(item);
    });
  } else {
    log('market search ' + response.statusCode.toString());
  }
}

Future<List<SimpleSearchResultModel>> simpleSearchPartPtno(
    String hkgb, String ptno, int firstIndex, int recordCountPerPage) async {
  MarketSearchResultProductInfo productInfo =
      await getProductInfoFromPtno(ptno);
  if (productInfo == null) return null;
  final response = await http.get(API +
      '/partInvenList?hkgb=$hkgb&ptno=$ptno&stype=ALL&firstIndex=$firstIndex&recordCountPerPage=$recordCountPerPage');
  if (response.statusCode == 200) {
    log('simple search ptno success');
    final data = json.decode(response.body) as List;
    return data.map((item) {
      return new SimpleSearchResultModel(
          ptno: item['ptno'],
          krname: productInfo.krname,
          enname: productInfo.enname,
          price: productInfo.price,
          seq: productInfo.seq,
          hkgb: productInfo.hkgb,
          totalCnt: item['tot_cnt'],
          rnum: item['rnum']);

    });
  } else {
    log('simple search ptno' + response.statusCode.toString());
    return null;
  }
}

Future<MarketSearchResultProductInfo> getProductInfoFromPtno(
    String ptno) async {
  final response = await http.get(API + '/part?ptno=$ptno');
  if (response.statusCode == 200) {
    log('get product info success');
    final data = json.decode(utf8.decode(response.bodyBytes));
    log(data.toString());
    return MarketSearchResultProductInfo.fromMap(data);
  } else {
    log('get product info ${response.statusCode}');
    return null;
  }
}
                    
Future<List<Notice>> getTitleNoticeStream({String title, int page=1, int limit=10}) async {
  final response = await http.get(API+'/notice?kind=title&limit=$limit&page=$page&search=$title');
  if(response.statusCode==200){
    final data = json.decode(utf8.decode(response.bodyBytes))['content'] as List;
    return data.map((e) {
      return Notice(
        title: e['title'],
        content: e['content'],
        seq: e['Seq'],
        date: DateTime.parse(e['createdDate']),
      );
    }).toList();
  }
  else{
    throw Exception('error');
  }
}

Future<List<Notice>> getContentNoticeStream({String keyword, int page=1, int limit=10}) async {
  final response = await http.get(API+'/notice?kind=content&limit=$limit&page=$page&search=$keyword');
  if(response.statusCode==200){
    final data = json.decode(utf8.decode(response.bodyBytes))['content'] as List;
    return data.map((e) {
      return Notice(
        title: e['title'],
        content: e['content'],
        seq: e['Seq'],
        date: DateTime.parse(e['createdDate']),
      );
    }).toList();
  }else{
    throw Exception('error');
  }
}

                    
