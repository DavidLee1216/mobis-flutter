import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobispartsearch/common.dart';

class MyInfoScreen extends StatefulWidget {
  @override
  _MyInfoScreenState createState() => _MyInfoScreenState();
}

class _MyInfoScreenState extends State<MyInfoScreen> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repasswordController = TextEditingController();

  var _emailController = TextEditingController();

  var _address1Controller = TextEditingController();
  var _address2Controller = TextEditingController();

  var _postCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    _nameController.text = globalUsername ?? '';
    _emailController.text = globalUser.email ?? '';
    _address1Controller.text = globalUser.address ?? '';
    _address2Controller.text = globalUser.addressExtended ?? '';
    _postCodeController.text = globalUser.zipcode ?? '';

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
              onPressed: () {
                showToastMessage(text: '아직 기능이 구현되지 않았습니다.', position: 1);
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
        onPressed: () {
          String addressExtended = _address2Controller.text;
          String address = _address1Controller.text;
          String email = _emailController.text;
          String password = _passwordController.text;
          String zipCode = _postCodeController.text;
          updateProfile(addressExtended, address, password, zipCode, email);
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
      body: SafeArea(
        child: ListView(
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
          ],
        ), //
      ),
    );
  }
}
