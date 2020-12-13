import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopo/kopo.dart';
import 'package:mobispartsearch/bloc/user_history_bloc.dart';
import 'package:mobispartsearch/common.dart';
import 'package:mobispartsearch/ui/widget/loading.dart';
import 'package:mobispartsearch/ui/widget/loading_indication.dart';

import '../../app_config.dart';

class MyInfoScreen extends StatefulWidget {
  @override
  _MyInfoScreenState createState() => _MyInfoScreenState();
}

class _MyInfoScreenState extends State<MyInfoScreen> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repasswordController = TextEditingController();
  final _emailController = TextEditingController();
  final _address1Controller = TextEditingController();
  final _address2Controller = TextEditingController();
  final _postCodeController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    _nameController.text = globalUser.legalName ?? '';
    _emailController.text = globalUser.email ?? '';
    _address1Controller.text = globalUser.address ?? '';
    _address2Controller.text = globalUser.addressExtended ?? '';
    _postCodeController.text = globalUser.zipcode ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    var userNameItem = Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          Container(
              width: screenWidth * 0.25,
              height: 30,
              padding: EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '성명',
                    style: TextStyle(
                      fontFamily: 'HDharmony',
                      fontSize: 14,
                    ),
                  ),
                ],
              )),
          Container(
            width: screenWidth * 0.75,
            height: 50,
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: TextField(
              readOnly: true,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                contentPadding: EdgeInsets.only(left: 10),
              ),
              keyboardType: TextInputType.text,
              style: TextStyle(
                fontFamily: 'HDharmony',
                fontSize: 12,
              ),
              textAlign: TextAlign.left,
              controller: _nameController,
            ),
          )
        ],
      ),
    );

    var passwordItem = Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          Container(
              width: screenWidth * 0.25,
              height: 30,
              padding: EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '비밀번호',
                    style: TextStyle(
                      fontFamily: 'HDharmony',
                      fontSize: 14,
                    ),
                  ),
                ],
              )),
          Container(
            width: screenWidth * 0.75,
            height: 50,
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                contentPadding: EdgeInsets.only(left: 10),
              ),
              obscureText: true,
              keyboardType: TextInputType.text,
              style: TextStyle(
                fontFamily: 'HDharmony',
                fontSize: 12,
              ),
              textAlign: TextAlign.left,
              controller: _passwordController,
            ),
          )
        ],
      ),
    );

    var repasswordItem = Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          Container(
              width: screenWidth * 0.25,
              height: 30,
              padding: EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '비밀번호 확인',
                    style: TextStyle(
                      fontFamily: 'HDharmony',
                      fontSize: 14,
                    ),
                  ),
                ],
              )),
          Container(
            width: screenWidth * 0.75,
            height: 50,
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                contentPadding: EdgeInsets.only(left: 10),
              ),
              obscureText: true,
              keyboardType: TextInputType.text,
              style: TextStyle(
                fontFamily: 'HDharmony',
                fontSize: 12,
              ),
              textAlign: TextAlign.left,
              controller: _repasswordController,
            ),
          )
        ],
      ),
    );

    var phoneNumberItem = Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          Container(
              width: screenWidth * 0.25,
              height: 30,
              padding: EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '전화번호',
                    style: TextStyle(
                      fontFamily: 'HDharmony',
                      fontSize: 14,
                    ),
                  ),
                ],
              )),
          Container(
            padding: EdgeInsets.fromLTRB(30, 10, 0, 10),
            child: Text(
              globalUser.mobile ?? '',
              style: TextStyle(
                fontFamily: 'HDharmony',
                fontSize: 14,
              ),
            ),
          )
        ],
      ),
    );

    var emailItem = Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          Container(
              width: screenWidth * 0.25,
              height: 30,
              padding: EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '이메일',
                    style: TextStyle(
                      fontFamily: 'HDharmony',
                      fontSize: 14,
                    ),
                  ),
                ],
              )),
          Container(
            width: screenWidth * 0.75,
            height: 50,
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: TextField(
              readOnly: true,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                contentPadding: EdgeInsets.only(left: 10),
              ),
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                fontFamily: 'HDharmony',
                fontSize: 12,
              ),
              textAlign: TextAlign.left,
              controller: _emailController,
            ),
          )
        ],
      ),
    );

    var addressItem = Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(
                width: screenWidth * 0.25,
                height: 30,
                padding: EdgeInsets.only(left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '',
                      style: TextStyle(fontFamily: 'HDharmony', fontSize: 14),
                    ),
                  ],
                )),
            Container(
              width: screenWidth * 0.75,
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: TextField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  contentPadding: EdgeInsets.only(left: 10),
                ),
                keyboardType: TextInputType.text,
                style: TextStyle(
                  fontFamily: 'HDharmony',
                  fontSize: 12,
                ),
                textAlign: TextAlign.left,
                controller: _address1Controller,
              ),
            ),
          ]),
          SizedBox(
            height: 10,
          ),
          Container(
            width: screenWidth * 0.65,
            height: 50,
            margin: EdgeInsets.only(left: screenWidth * 0.25 + 20),
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                contentPadding: EdgeInsets.only(left: 10),
              ),
              keyboardType: TextInputType.text,
              style: TextStyle(
                fontFamily: 'HDharmony',
                fontSize: 12,
              ),
              textAlign: TextAlign.left,
              controller: _address2Controller,
            ),
          ),
        ],
      ),
    );

    var postCodeItem = Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          Container(
              width: screenWidth * 0.25,
              height: 30,
              padding: EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '주소',
                    style: TextStyle(
                      fontFamily: 'HDharmony',
                      fontSize: 14,
                    ),
                  ),
                ],
              )),
          Container(
            width: screenWidth * 0.33,
            height: 50,
            margin: EdgeInsets.only(
              left: 20,
            ),
            child: TextField(
              readOnly: true,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                contentPadding: EdgeInsets.only(left: 10),
              ),
              style: TextStyle(
                fontFamily: 'HDharmony',
                fontSize: 12,
              ),
              textAlign: TextAlign.left,
              controller: _postCodeController,
            ),
          ),
          Container(
            width: screenWidth * 0.3,
            height: 50,
            margin: EdgeInsets.only(left: 10),
            child: OutlineButton(
              borderSide: BorderSide(
                color: Color.fromRGBO(0, 63, 114, 1),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1),
              ),
              child: Text(
                '우편번호검색',
                style: TextStyle(
                  fontFamily: 'HDharmony',
                  fontSize: 15,
                  color: Color.fromRGBO(0, 63, 114, 1),
                ),
                textAlign: TextAlign.center,
              ),
              onPressed: () async {
                KopoModel kopoModel = await Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => Kopo(),
                  ),
                );
                if (kopoModel != null) {
                  setState(() {
                    _postCodeController.text = kopoModel.zonecode;
                    _address1Controller.text = kopoModel.address;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );

    var changeButton = Container(
      width: double.infinity,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(top: 25),
      child: RaisedButton(
        padding: EdgeInsets.all(10.0),
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        color: Color.fromRGBO(0, 63, 114, 1),
        child: Text(
          '정보변경',
          style: TextStyle(
              fontFamily: 'HDharmony', fontSize: 18, color: Colors.white),
        ),
        onPressed: () async {
          String addressExtended = _address2Controller.text.trim();
          String address = _address1Controller.text.trim();
          String email = _emailController.text.trim();
          String password = _passwordController.text.trim();
          String repassword = _repasswordController.text.trim();
          String zipCode = _postCodeController.text.trim();
          String mobile = globalUser.mobile;
          if (password == '') {
            showToastMessage(text: '비밀번호를 입력하세요.');
            return;
          } else if (repassword == '') {
            showToastMessage(text: '비밀번호 확인을 입력하세요.');
            return;
          }
          if (password == repassword) {
            setState(() {
              isLoading = true;
            });
            await updateProfile(addressExtended, address, mobile,
                encryptPassword(password), zipCode, email);
            setState(() {
              isLoading = false;
            });
          } else
            showToastMessage(text: '비밀번호와 비밀번호 확인이 일치하지 않습니다.');
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text(
          'My info',
          style: TextStyle(
            fontFamily: 'HDharmony',
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(children: [
        ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            userNameItem,
            passwordItem,
            repasswordItem,
            phoneNumberItem,
            emailItem,
            postCodeItem,
            addressItem,
            changeButton,
            SizedBox(
              height: 50,
            ),
          ],
        ),
//        isLoading ? LoadingData() : Container(),//
        Positioned(
          child: LoadingIndicator(isLoading: isLoading), //
        ),
      ]),
    );
  }
}
