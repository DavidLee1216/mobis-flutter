import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'model/carModel_model.dart';
import 'model/location_model.dart';
import 'model/market_search_model.dart';
import 'model/notice_model.dart';
import 'model/order_model.dart';
import 'model/simple_search_model.dart';
import 'model/user_model.dart';
import 'model/product_model.dart';
import 'model/cart_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

dynamic session = '';
String accessToken = '';
String refreshToken = '';
DateFormat dateformatter = DateFormat('yyyy.MM.dd');
const List<String> hkgb_list = ['H', 'K'];
const List<String> vtpy_list = ['P', 'R', 'C'];

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
math.Random _rnd = math.Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

String encryptPassword(String password) {
  return md5.convert(utf8.encode(password)).toString();
}

bool validatePassword(String password) {
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,20}$';
  RegExp regExp = new RegExp(pattern);
  bool res = false;
  bool res1 = regExp.hasMatch(password);
  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,20}$';
  regExp = new RegExp(pattern);
  bool res2 = regExp.hasMatch(password);
  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[!@#\$&*~]).{8,20}$';
  regExp = new RegExp(pattern);
  bool res3 = regExp.hasMatch(password);
  pattern = r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,20}$';
  regExp = new RegExp(pattern);
  bool res4 = regExp.hasMatch(password);
  pattern = r'^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,20}$';
  regExp = new RegExp(pattern);
  bool res5 = regExp.hasMatch(password);
  if (res1 || res2 || res3 || res4 || res5) res = true;
  return res;
}

bool validateEmailString(String email) {
  String pattern = r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[A-Za-z]+$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(email);
}

bool validateMobileString(String mobile) {
  String pattern = r'^([0-9]{3})-([0-9]{3,4})-([0-9]{4})$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(mobile);
}

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
        element += 0x45;
      newCodes.add(element);
    });
    String sss = String.fromCharCodes(newCodes);
    String sessionStr = ss + sss;
    await FlutterSession().set('mobis_session', sessionStr);
    session = await FlutterSession().get('mobis_session');
  }
}

enum Gender { male, female }

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

void messageBox(String string, BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(string),
        );
      });
}

void showToastMessage({String text, int position = 0}) {
  if(position==0)
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0,
    );
  else if(position==1)
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER, // also possible "TOP" and "CENTER"
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  else if(position==2)
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  else
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0,
    );
}

const API = 'http://141.164.51.190:8080';

String globalUsername = '';

User globalUser = new User();
bool globalSidoLoaded = false;
bool globalModelsLoaded = false;

int globalRecordCountPerPage = 10;

List<Sido> globalSido = new List<Sido>();
var globalModels = List.generate(2, (i) => List(3), growable: false);

Future<List<ModelSeq>> getModels({String hkgb, String vtpy}) async {
  return await getModelsFromRemote(hkgb, vtpy);
}

void getGloablModels() async {
  for (int i = 0; i < 2; i++) {
    for (int j = 0; j < 3; j++) {
      List<ModelSeq> models =
          await getModelsFromRemote(hkgb_list[i], vtpy_list[j]);
      models.insert(0, ModelSeq(seq: 0, modelname: '전체'));
      globalModels[i][j] = models;
    }
    if (i == 1) globalModelsLoaded = true;
  }
}

void getSido() async {
  await http.get(API + '/sido').then((response) {
    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes)) as List;
      globalSido = data.map((e) => Sido.fromMap(e)).toList();
      getSigungu();
    } else {}
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

void getSigungu() async {
  int len = globalSido.length;
  for (int i = 0; i < len; i++) {
    Sido sido = globalSido[i];
    await http.get(API + '/sigungu?seq=${sido.seq}').then((response) {
      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes)) as List;
        sido.sigungus = data.map((e) => Sigungu.fromMap(e)).toList();
        sido.sigungus.insert(0, Sigungu(seq: 0, sigungu: '전체'));
      } else {}
    });
    if (i == len - 1) {
      globalSido.insert(
          0, Sido(seq: 0, sido: '전체', sigungus: new List<Sigungu>()));
      globalSido[0].sigungus.add(Sigungu(seq: 0, sigungu: '전체'));
      globalSidoLoaded = true;
    }
  }
}

// ignore: missing_return
Future<bool> updateProfile(String addressExtended, String address,
    String password, String zipCode, String email) {
  http
      .post(API + '/profile',
          body: jsonEncode({
            'addressExtended': addressExtended,
            'address': address,
            'password': password,
            'zipcode': zipCode,
            'email': email
          }))
      .then((response) {
    if (response.statusCode == 200) {
      log('profile success');
      return true;
    } else {
      log('profile ${response.statusCode}');
      return false;
    }
  });
}

// ignore: missing_return
Future<bool> checkUsername(String username) =>
    http.get(API + '/username/$username').then((response) {
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    });

// ignore: missing_return
Future<bool> checkEmail(String email) =>
    http.get(API + '/email/$email').then((response) {
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    });

// ignore: missing_return
Future<bool> validateSMS(String mobile) =>
    http.get(API + '/validateSMS/$mobile').then((response) {
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    });

// ignore: missing_return
Future<List<CartModel>> loadCart() async {
  String url = API + '/carts';
  if (globalUsername != '')
    url = API + '/carts?id=$globalUsername';
  else
    url = API + '/carts?id=$session';
  final response = await http.get(url);
  if (response.statusCode == 200) {
    try {
      final data = json.decode(utf8.decode(response.bodyBytes)) as List;
      return data.map((item) {
        return CartModel.fromMap(item);
      }).toList();
    } catch (e) {
      return null;
    }
  } else {
    return null;
  }
}

Future<bool> addToCart(Product product) =>
    http.post(API + '/addCart', body: jsonEncode(product.toMap()), headers: {
      'Content-type': 'application/json',
    }).then((response) {
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    });

Future<bool> delFromCart(int seq) =>
    http.post(API + '/delCart', body: jsonEncode({'seq': seq}), headers: {
      'Content-type': 'application/json',
    }).then((response) {
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    });

// ignore: missing_return
Future<bool> validateEmail(String email) =>
    http.get(API + '/validateEmail/$email').then((response) {
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    });

Future<int> validateCode(String code) =>
    http.get(API + '/validateCode/$code').then((response) {
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return jsonData['seq'];
      } else
        return -1;
    });

// ignore: missing_return
Future<String> getEmail(String code) async {
  http.post(API + '/getEmail', body: jsonEncode({'seq': code}), headers: {
    'Content-type': 'application/json',
  }).then((response) {
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['email'];
    }
  });
}

// ignore: missing_return
Future<bool> resetPassword(String password, int seq) async {
  await http.post(API + '/resetPassword',
      body: jsonEncode({'password': password, 'seq': seq}),
      headers: {
        'Content-type': 'application/json',
      }).then((response) {
    if (response.statusCode == 200) {
      showToastMessage(text: '비밀번호 변경 성공', position: 1);
      return true;
    } else {
      showToastMessage(text: '비밀번호 변경 실패', position: 1);
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
        globalUsername = username;
        final jsonData = json.decode(response.body);
        accessToken = jsonData['accessToken'];
        refreshToken = jsonData['refreshToken'];
        return true;
      } else {
        showToastMessage(text: '로그인 실패', position: 1);
        return false;
      }
    });

Future<bool> signup(User user) =>
    http.post(API + '/signup', body: jsonEncode(user.toMap()), headers: {
      'Content-type': 'application/json',
    }).then((response) {
      if (response.statusCode == 200) {
        return true;
      } else {
        showToastMessage(text: '가입 실패', position: 1);
        return false;
      }
    });

Future<void> signout() async {}

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

Future<List<ModelSeq>> getModelsFromRemote(String hkgb, String vtpy) async {
  final response = await http.get(API + '/models?hkgb=$hkgb&vtyp=$vtpy');
  if (response.statusCode == 200) {
    final data = json.decode(utf8.decode(response.bodyBytes)) as List;
    return data.map((item) {
      return ModelSeq.fromMap(item);
    }).toList();
  } else {
    throw Exception('error');
  }
}

Future<List<SimpleSearchResultModel>> simpleSearchPartByName(
    String hkgb,
    int catSeq,
    String vtpy,
    String searchWord,
    int firstIndex,
    int recordCountPerPage) async {
  String url = API +
      '/partPrcList?hkgb=$hkgb&firstIndex=$firstIndex&recordCountPerPage=$recordCountPerPage';
  if (vtpy != '') url = url + '&vtyp=$vtpy';
  if (catSeq != 0) url = url + '&catSeq=$catSeq';
  if (searchWord != '') url = url + '&inText=$searchWord';
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final data = json.decode(utf8.decode(response.bodyBytes)) as List;
    return data.map((item) {
      return SimpleSearchResultModel.fromMap(item);
    }).toList();
  } else {
    showToastMessage(text: '검색 실패', position: 1);
    return null;
  }
}

Future<List<SimpleSearchResultModel>> simpleSearchPartByPtno(
    String hkgb, String ptno, int firstIndex, int recordCountPerPage) async {
  String url = API +
      '/partPrcList?hkgb=$hkgb&firstIndex=$firstIndex&recordCountPerPage=$recordCountPerPage';
  if (ptno != '') url = url + '&ptno=$ptno';
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final data = json.decode(utf8.decode(response.bodyBytes)) as List;
    return data.map((item) {
      return SimpleSearchResultModel.fromMap(item);
    }).toList();
  } else {
    showToastMessage(text: '검색 실패', position: 1);
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
  String url = API +
      '/partInvList?hkgb=$hkgb&stype=$stype&firstIndex=$firstIndex&recordCountPerPage=$recordCountPerPage';
  if (ptno != '') url = url + '&ptno=$ptno';
  if (sido != '' && sido != null && sido != '전체') {
    url = url + '&sido=$sido';
    if (sigungu != null && sigungu != '전체') url = url + '&sigungu=$sigungu';
  }
  final response = await http.get(url);
  if (response.statusCode == 200) {
    if (response.body.isNotEmpty) {
      final data = json.decode(utf8.decode(response.bodyBytes)) as List;
      if (data.length == 0) return null;
      return data.map((item) {
        return MarketSearchResultModel.fromMap(item);
      }).toList();
    } else {
      return null;
    }
  } else {
    showToastMessage(text: '서버 접속 오류', position: 1);
    return null;
  }
}

Future<MarketSearchResultProductInfo> getProductInfoFromPtno(
    String ptno) async {
  final response = await http.get(API + '/part?ptno=$ptno');
  if (response.statusCode == 200) {
    if (response.body != '') {
      final data = json.decode(utf8.decode(response.bodyBytes));
      return MarketSearchResultProductInfo.fromMap(data);
    } else {
      return null;
    }
  } else {
    showToastMessage(text: '서버 접속 오류', position: 1);
    return null;
  }
}

Future<List<Notice>> getTitleNoticeStream(
    {String title, int page = 1, int limit = 10}) async {
  final response = await http
      .get(API + '/notice?kind=title&limit=$limit&page=$page&search=$title');
  if (response.statusCode == 200) {
    final data =
        json.decode(utf8.decode(response.bodyBytes))['content'] as List;
    return data.map((e) {
      return Notice(
        title: e['title'],
        content: e['content'],
        seq: e['Seq'],
        date: DateTime.parse(e['createdDate']),
      );
    }).toList();
  } else {
    showToastMessage(text: '서버 접속 오류', position: 1);
    throw Exception('error');
  }
}

Future<List<Notice>> getContentNoticeStream(
    {String keyword, int page = 1, int limit = 10}) async {
  final response = await http.get(
      API + '/notice?kind=content&limit=$limit&page=$page&search=$keyword');
  if (response.statusCode == 200) {
    final data =
        json.decode(utf8.decode(response.bodyBytes))['content'] as List;
    return data.map((e) {
      return Notice(
        title: e['title'],
        content: e['content'],
        seq: e['Seq'],
        date: DateTime.parse(e['createdDate']),
      );
    }).toList();
  } else {
    showToastMessage(text: '서버 접속 오류', position: 1);
    throw Exception('error');
  }
}

Future<bool> getToken() => http.post(API + '/token',
        body: jsonEncode({'refreshToken': refreshToken}),
        headers: {'Content-type': 'application/json'}).then((response) {
      if (response.statusCode == 200) {
        accessToken = json.decode(response.body)['accessToken'];
        return true;
      } else {
        showToastMessage(text: '서버 접속 오류', position: 1);
        return false;
      }
    });
