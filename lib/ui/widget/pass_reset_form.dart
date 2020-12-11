import 'package:flutter/material.dart';
import 'package:mobispartsearch/common.dart';
import 'package:mobispartsearch/service/alert_service.dart';
import 'package:mobispartsearch/ui/screen/id_login_screen.dart';
import 'package:mobispartsearch/utils/navigation.dart';

import 'loading.dart';

class GetPassForm extends StatefulWidget {
  @override
  _GetPassFormState createState() => _GetPassFormState();
}

class _GetPassFormState extends State<GetPassForm> {
  int birthYear = 1980;
  int birthMonth = 1;
  int birthDay = 1;
  String phoneCode = '+82';
  int authStep = 1;
  bool mobileAuth = false; //if false, then email auth
  bool findEmail = true; //if false, then password reset
  int authSeq = -1;
  String foundEmail = '';
  bool sentPass = false;
  bool isLoading = false;

  final _phoneNumberController = TextEditingController();

  final _authNumberController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();
  final _repasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    circleNumber(int number) {
      return Container(
        width: 25,
        height: 25,
        decoration: new BoxDecoration(
          color: kPrimaryColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            number.toString(),
            style: TextStyle(
                fontFamily: 'HDharmony', fontSize: 14, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    var emailOrPasswordItem = Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(0, 20, 40, 20),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
              ),
              circleNumber(1),
              SizedBox(
                width: 10,
              ),
              Text(
                '아이디 또는 비밀번호',
                style: TextStyle(
                  fontFamily: 'HDharmony',
                  color: const Color(0xFF004B87),
                  fontSize: 15,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 30),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Text(
                          '* 아이디를 찾으시려면 아래 버튼을 선택하세요.',
                          style: TextStyle(
                            fontFamily: 'HDharmony',
                            fontSize: 12,
                            color: Color(0xff7f7f7f),
                          ),
                        )),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.72,
                          child: RaisedButton(
                            color: mobileAuth && findEmail
                                ? kPrimaryColor
                                : Colors.white,
                            shape: mobileAuth && findEmail
                                ? Border.all(
                                    color: Color.fromRGBO(0, 63, 114, 1),
                                    width: 1)
                                : Border.all(
                                    color: Colors.transparent, width: 1),
                            child: Text(
                              '아이디 찾기',
                              style: TextStyle(
                                  fontFamily: 'HDharmony',
                                  fontSize: 14,
                                  color: mobileAuth && findEmail
                                      ? Colors.white
                                      : Color(0xff7f7f7f)),
                            ),
                            onPressed: () {
                              if (authStep == 1)
                                setState(() {
                                  findEmail = true;
                                  mobileAuth = true;
                                  authStep++;
                                });
                              else
                                showToastMessage(
                                    text: '선택단계가 아닙니다.', position: 1);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            child: Text(
                          '* 비밀번호를 초기화하시려면 이메일 또는 모바일로 인증하세요.',
                          style: TextStyle(
                            fontFamily: 'HDharmony',
                            fontSize: 12,
                            color: Color(0xff7f7f7f),
                          ),
                        )),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: 40,
                              child: RaisedButton(
                                color: !mobileAuth && !findEmail
                                    ? kPrimaryColor
                                    : Colors.white,
                                shape: !mobileAuth && !findEmail
                                    ? Border.all(
                                        color: Color.fromRGBO(0, 63, 114, 1),
                                        width: 1)
                                    : Border.all(
                                        color: Colors.transparent, width: 1),
                                child: Text(
                                  '이메일 인증',
                                  style: TextStyle(
                                      fontFamily: 'HDharmony',
                                      fontSize: 14,
                                      color: !mobileAuth && !findEmail
                                          ? Colors.white
                                          : Color(0xff7f7f7f)),
                                ),
                                onPressed: () {
                                  if (authStep == 1)
                                    setState(() {
                                      mobileAuth = false;
                                      findEmail = false;
                                      authStep++;
                                    });
                                  else
                                    showToastMessage(
                                        text: '선택단계가 아닙니다.', position: 1);
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: RaisedButton(
                                color: mobileAuth && !findEmail
                                    ? kPrimaryColor
                                    : Colors.white,
                                shape: mobileAuth && !findEmail
                                    ? Border.all(
                                        color: Color.fromRGBO(0, 63, 114, 1),
                                        width: 1)
                                    : Border.all(
                                        color: Colors.transparent, width: 1),
                                child: Text(
                                  '모바일 인증',
                                  style: TextStyle(
                                      fontFamily: 'HDharmony',
                                      fontSize: 14,
                                      color: mobileAuth && !findEmail
                                          ? Colors.white
                                          : Color(0xff7f7f7f)),
                                ),
                                onPressed: () {
                                  if (authStep == 1) {
                                    setState(() {
                                      mobileAuth = true;
                                      findEmail = false;
                                      authStep = 2;
                                    });
                                  } else {
                                    showToastMessage(
                                        text: '선택단계가 아닙니다.', position: 1);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );

    var emptyCircleItem = Container(
      width: 20,
      height: 20,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.black,
        ),
      ),
    );

    var yearDropdownmenu = Container(
        width: MediaQuery.of(context).size.width * 0.23,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<int>(
            value: birthYear,
//            decoration: InputDecoration(
//                labelText: '[선택]'
//            ),
            hint: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                '[선택]',
                style: TextStyle(
                  fontFamily: 'HDharmony',
                ),
              ),
            ),
            icon: Icon(Icons.keyboard_arrow_down),
            iconSize: 14,
            onChanged: (int newValue) {
              setState(() {
                birthYear = newValue;
              });
            },
            items: List.generate(200, (index) => index + 1900)
                .map<DropdownMenuItem<int>>((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Container(
                  width: 60,
                  child: Text(
                    value.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'HDharmony',
                      fontSize: 14,
                    ),
                  ),
                  alignment: Alignment.center,
                ),
              );
            }).toList(),
          ),
        ));

    var monthDropdownmenu = Container(
        width: MediaQuery.of(context).size.width * 0.23,
        height: 40,
        margin: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<int>(
            value: birthMonth,
//            decoration: InputDecoration(
//                labelText: '[선택]'
//            ),
            hint: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                '[선택]',
                style: TextStyle(
                  fontFamily: 'HDharmony',
                ),
              ),
            ),
            icon: Icon(Icons.keyboard_arrow_down),
            iconSize: 14,
            onChanged: (int newValue) {
              setState(() {
                birthMonth = newValue;
              });
            },
            items: List.generate(12, (index) => index + 1)
                .map<DropdownMenuItem<int>>((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Container(
                  width: 60,
                  child: Text(
                    value.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'HDharmony',
                      fontSize: 14,
                    ),
                  ),
                  alignment: Alignment.center,
                ),
              );
            }).toList(),
          ),
        ));

    getDaysFromYearMonth(int year, int month) {
      if (month == 1 ||
          month == 3 ||
          month == 5 ||
          month == 7 ||
          month == 8 ||
          month == 10 ||
          month == 12) return 31;
      if (month == 4 || month == 6 || month == 9 || month == 11) return 30;
      if (month == 2 && year % 4 != 0) return 28;
      if (month == 2 && year % 4 == 0) return 29;
    }

    dayDropdownmenu(int year, int month) {
      int days = getDaysFromYearMonth(year, month);
      if (birthDay > getDaysFromYearMonth(year, month)) birthDay = 1;
      return Container(
          width: MediaQuery.of(context).size.width * 0.23,
          height: 40,
          margin: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: birthDay,
//            decoration: InputDecoration(
//                labelText: '[선택]'
//            ),
              hint: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  '[선택]',
                  style: TextStyle(
                    fontFamily: 'HDharmony',
                  ),
                ),
              ),
              icon: Icon(Icons.keyboard_arrow_down),
              iconSize: 14,
              onChanged: (int newValue) {
                setState(() {
                  birthDay = newValue;
                });
              },
              items: List.generate(days, (index) => index + 1)
                  .map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Container(
                    width: 60,
                    child: Text(
                      value.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'HDharmony',
                        fontSize: 14,
                      ),
                    ),
                    alignment: Alignment.center,
                  ),
                );
              }).toList(),
            ),
          ));
    }

    var phoneCodes = ['+82'];

    var phoneCodeDropdownmenu = Container(
        width: MediaQuery.of(context).size.width * 0.23,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: phoneCode,
            icon: Icon(Icons.keyboard_arrow_down),
            iconSize: 14,
            onChanged: (String newValue) {
              setState(() {
                phoneCode = newValue;
              });
            },
            items: phoneCodes.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Container(
                  width: 60,
                  child: Text(
                    value,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'HDharmony',
                      fontSize: 14,
                    ),
                  ),
                  alignment: Alignment.center,
                ),
              );
            }).toList(),
          ),
        ));

    var phoneNumberItem = Container(
      height: 40,
      width: MediaQuery.of(context).size.width *
          0.7, //MediaQuery.of(context).size.width * 0.49,
      margin: EdgeInsets.only(left: 10),
      child: TextField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(color: Colors.black, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
          hintText: '휴대폰 번호',
          contentPadding: EdgeInsets.only(left: 10),
        ),
        keyboardType: TextInputType.number,
        style: TextStyle(
          fontFamily: 'HDharmony',
          fontSize: 14.0,
        ),
        textAlign: TextAlign.left,
        controller: _phoneNumberController,
      ),
    );

    var phoneItem = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                '* 휴대폰 번호',
                style: TextStyle(
                  fontFamily: 'HDharmony',
                  fontSize: 12,
                  color: Color(0xff7f7f7f),
                ),
              )),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
//              phoneCodeDropdownmenu,
              phoneNumberItem,
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Row(
              children: [
                Icon(
                  Icons.warning,
                  color: kPrimaryColor,
                ),
                Text(
                  '공백 특수기호 없이 문자만 입력하세요',
                  style: TextStyle(
                      fontFamily: 'HDharmony',
                      color: kPrimaryColor,
                      fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    var emailItem = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                '* 이메일',
                style: TextStyle(fontFamily: 'HDharmony', fontSize: 12),
              )),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 40,
            width: 200,
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: BorderSide(color: Colors.black, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: BorderSide(color: Colors.black, width: 1),
                ),
                hintText: '가입하신 이메일을 입력하세요.',
                contentPadding: EdgeInsets.only(left: 10),
              ),
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                fontFamily: 'HDharmony',
                fontSize: 14.0,
              ),
              textAlign: TextAlign.left,
              controller: _emailController,
            ),
          )
        ],
      ),
    );

    var checkedItem = Container(
      child: Image.asset('assets/images/check_icon.png'),
    );

    var authRequestItem = Container(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
              ),
              (authStep == 1) ? emptyCircleItem : circleNumber(2),
              SizedBox(
                width: 10,
              ),
              Text(
                '인증 요청',
                style: TextStyle(
                  fontFamily: 'HDharmony',
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 30),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
//                        Container(
//                            child: Text(
//                          '* 생년월일',
//                          style: TextStyle(
//                            fontFamily: 'HDharmony',
//                            fontSize: 12,
//                            color: Color(0xff7f7f7f),
//                          ),
//                        )),
//                        SizedBox(
//                          height: 10,
//                        ),
//                        Row(
//                          children: [
//                            yearDropdownmenu,
//                            monthDropdownmenu,
//                            dayDropdownmenu(birthYear, birthMonth),
//                          ],
//                        ),
                        mobileAuth ? phoneItem : emailItem,
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.36,
                              child: OutlineButton(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                                child: Text(
                                  '이전',
                                  style: TextStyle(
                                      fontFamily: 'HDharmony', fontSize: 14),
                                ),
                                onPressed: () {
                                  if (authStep == 2) {
                                    setState(() {
                                      authStep--;
                                    });
                                  } else {
                                    showToastMessage(
                                        text: '인증요청 단계가 아닙니다.', position: 1);
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.36,
                              child: RaisedButton(
                                color: kPrimaryColor,
                                child: Text(
                                  '발송하기',
                                  style: TextStyle(
                                      fontFamily: 'HDharmony',
                                      fontSize: 14,
                                      color: Colors.white),
                                ),
                                onPressed: () async {
                                  if ((mobileAuth &&
                                          _phoneNumberController.text.trim() ==
                                              '') ||
                                      (!mobileAuth &&
                                          _emailController.text.trim() == '')) {
                                    if (mobileAuth)
                                      showToastMessage(text: '휴대폰번호를 입력해주세요.');
                                    else
                                      showToastMessage(text: '이메일을 입력해주세요.');
                                    return;
                                  }
                                  if (authStep == 2) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    bool sentCode = false;
                                    if (mobileAuth) {
                                      String phoneNumber =
                                          _phoneNumberController.text;
                                      sentCode = await validateSMS(phoneNumber);
                                    } else
                                      sentCode = await validateEmail(
                                          _emailController.text);
                                    setState(() {
                                      isLoading = false;
                                    });
                                    if (sentCode)
                                      setState(() {
                                        authStep++;
                                      });
                                  } else {
                                    showToastMessage(
                                        text: '인증요청 단계가 아닙니다.', position: 1);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          isLoading && authStep == 2
              ? LoadingData()
              : Container(),
        ],
      ),
    );

    var mobileAuthConfirmItem = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            child: Text(
          '* 인증번호',
          style: TextStyle(
            fontFamily: 'HDharmony',
            fontSize: 12,
            color: Color(0xff7f7f7f),
          ),
        )),
        SizedBox(
          height: 10,
        ),
        Container(
//          width: MediaQuery.of(context).size.width * 0.7,
          height: 50,
          child: TextField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: BorderSide(color: Colors.black, width: 1),
              ),
              hintText: '6자의 숫자 인증번호',
              contentPadding: EdgeInsets.only(left: 10),
            ),
            keyboardType: TextInputType.number,
            style: TextStyle(fontFamily: 'HDharmony', fontSize: 14.0),
            controller: _authNumberController,
          ),
        ),
      ],
    );

    var authConfirmItem = Container(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
              ),
              (authStep < 3) ? emptyCircleItem : circleNumber(3),
              SizedBox(
                width: 10,
              ),
              Text(
                '인증 확인',
                style: TextStyle(
                  fontFamily: 'HDharmony',
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 30),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      mobileAuthConfirmItem, //mobileAuth ? mobileAuthConfirmItem : emailAuthConfirmItem,
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.36,
                            child: OutlineButton(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                              child: Text(
                                '이전',
                                style: TextStyle(
                                    fontFamily: 'HDharmony', fontSize: 14),
                              ),
                              onPressed: () {
                                if (authStep == 3)
                                  setState(() {
                                    authStep--;
                                  });
                                else
                                  showToastMessage(
                                      text: '인증확인 단계가 아닙니다.', position: 1);
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.36,
                              child: RaisedButton(
                                color: kPrimaryColor,
                                child: Text(
                                  '인증',
                                  style: TextStyle(
                                      fontFamily: 'HDharmony',
                                      fontSize: 14,
                                      color: Colors.white),
                                ),
                                onPressed: () async {
                                  if (authStep == 3) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    authSeq = await validateCode(
                                        _authNumberController.text.trim());
                                    setState(() {
                                      isLoading = false;
                                    });
                                    if (authSeq == -1) {
                                      showToastMessage(
                                          text: '인증번호가 일치하지 않습니다.',
                                          position: 1);
                                      return;
                                    }

                                    if (findEmail) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      foundEmail = await getUsername(41);
                                      if (foundEmail != null) {
                                        print(foundEmail);
                                        setState(() {
                                          authStep++;
                                        });
                                      }
                                      setState(() {
                                        isLoading = false;
                                      });
                                    } else
                                      setState(() {
                                        authStep++;
                                      });
                                  } else {
                                    showToastMessage(
                                        text: '인증확인 단계가 아닙니다.', position: 1);
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          isLoading && authStep == 3 ? LoadingData() : Container(),
        ],
      ),
    );

    var passField = Container(
        height: 40,
        child: TextFormField(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide(color: Colors.grey, width: 1),
            ),
            contentPadding: EdgeInsets.only(left: 10),
          ),
          obscureText: true,
          style: TextStyle(fontFamily: 'HDharmony', fontSize: 16.0),
          validator: (value) => value.isEmpty
              ? "암호를 입력하세요."
              : validatePassword(value)
                  ? null
                  : "8-20자의 영문 대/소문자, 숫자, 특수문자 중 3가지 이상 혼용하여 입력해주세요.",
          controller: _passwordController,
        ));
    var repassField = Container(
        height: 40,
        child: TextFormField(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide(color: Colors.grey, width: 1),
            ),
            contentPadding: EdgeInsets.only(left: 10),
          ),
          obscureText: true,
          style: TextStyle(fontFamily: 'HDharmony', fontSize: 16.0),
          validator: (value) => value.isEmpty
              ? "암호를 입력하세요."
              : validatePassword(value)
                  ? null
                  : "8-20자의 영문 대/소문자, 숫자, 특수문자 중 3가지 이상 혼용하여 입력해주세요.",
          controller: _repasswordController,
        ));

    var passwordResetItem = Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  sentPass
                      ? Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.warning,
                                color: kPrimaryColor,
                              ),
                              Expanded(
                                  child: Text(
                                '임시 비밀번호가 발급되었습니다. 문자메세지나 이메일을 확인해주세요.',
                                style: TextStyle(
                                    fontFamily: 'HDharmony',
                                    color: kPrimaryColor,
                                    fontSize: 12),
                              )),
                            ],
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: RaisedButton(
                      color: kPrimaryColor,
                      child: Text(
                        !sentPass ? '비밀번호 발급' : '확인',
                        style: TextStyle(
                            fontFamily: 'HDharmony',
                            fontSize: 14,
                            color: Colors.white),
                      ),
                      onPressed: () async {
                        if (authSeq != -1) {
                          if (!sentPass) {
                            setState(() {
                              isLoading = true;
                            });
                            sentPass = await resetPassword('', authSeq);
                            setState(() {
                              isLoading = false;
                            });
                          } else {
                            pushTo(context, IdLoginScreen());
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            )),
        isLoading && authStep == 4 ? LoadingData() : Container(),
      ],
    );

    var emailConfirmItem = Container(
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                child: Text(
              '* 아이디',
              style: TextStyle(
                fontFamily: 'HDharmony',
                fontSize: 12,
                color: Color(0xff7f7f7f),
              ),
            )),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                emptyCircleItem,
                SizedBox(
                  width: 20,
                ),
                Container(
                  child: Text(
                    foundEmail ?? '찾고 있는 아이디가 없습니다.',
                    style: TextStyle(
                        fontFamily: 'HDharmony',
                        fontSize: 14,
                        color: Colors.black),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );

    var infoConfirmOrChangeItem = Container(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
              ),
              (authStep < 4) ? emptyCircleItem : circleNumber(4),
              SizedBox(
                width: 10,
              ),
              Text(
                '정보 확인 또는 변경',
                style: TextStyle(
                  fontFamily: 'HDharmony',
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 30),
              ),
              findEmail ? emailConfirmItem : passwordResetItem
            ],
          ),
        ],
      ),
    );

    var gotoLoginButton = Center(
      child: FlatButton(
        shape: Border(bottom: BorderSide(color: Color(0xff7f7f7f), width: 1)),
        child: Text(
          '로그인 페이지로 이동',
          style: TextStyle(
              fontFamily: 'HDharmony', fontSize: 14, color: Color(0xff7f7f7f)),
        ),
        onPressed: () {
          pushTo(context, IdLoginScreen());
        },
      ),
    );

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text(
              '아이디 찾기 및 비밀번호 초기화',
              style: TextStyle(fontFamily: 'HDharmony', fontSize: 16),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text(
              '아이디 찾기 또는 비밀번호 초기화를 진행합니다.',
              style: TextStyle(
                fontFamily: 'HDharmony',
                fontSize: 12,
                color: const Color(0x4FF7F7F7F),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
            height: 10,
            color: Colors.black54,
          ),
          emailOrPasswordItem,
          authStep == 1 ? Container() : authRequestItem,
          authStep < 3 ? Container() : authConfirmItem,
          authStep < 4 ? Container() : infoConfirmOrChangeItem,
          SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.black,
          ),
          SizedBox(
            height: 10,
          ),
          gotoLoginButton,
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
