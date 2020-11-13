import 'package:flutter/material.dart';
import 'package:hyundai_mobis/ui/widget/custom_radio_button.dart';
import 'package:hyundai_mobis/common.dart';

class GetPassForm extends StatefulWidget {
  @override
  _GetPassFormState createState() => _GetPassFormState();
}

class _GetPassFormState extends State<GetPassForm> {
  int birthYear = 1980;
  int birthMonth = 1;
  int birthDay = 1;
  String phoneCode = '+1';
  int authStep = 1;
  bool mobileAuth = true; //if false, then email auth
  bool findEmail = true; //if false, then password reset
  String authSeq = '';
  String foundEmail = '';

  final _phoneNumberController = TextEditingController();

  final _authNumberController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();
  final _repasswordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    circleNumber(int number) {
      return Container(
        width: 20,
        height: 20,
        decoration: new BoxDecoration(
          color: kPrimaryColor,
          shape: BoxShape.circle,
        ),
        child: Text(
          number.toString(),
          style: TextStyle(fontSize: 14, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      );
    }

    var emailOrPasswordItem = Container(
      padding: EdgeInsets.only(top: 20),
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
                '이메일 또는 비밀번호',
                style: TextStyle(
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
                        Container(
                            child: Text(
                          '* 이메일 아이디를 찾으시려면 아래 버튼을 선택하세요.',
                          style: TextStyle(fontSize: 12),
                        )),
                        OutlineButton(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          child: Text(
                            '이메일 찾기',
                            style: TextStyle(fontSize: 14),
                          ),
                          onPressed: () {
                            if (authStep == 1)
                              setState(() {
                                findEmail = true;
                                mobileAuth = true;
                                authStep++;
                              });
                          },
                        ),
                        Container(
                            child: Text(
                          '* 비밀번호를 초기화하시려면 이메일 또는 모바일로 인증하세요.',
                          style: TextStyle(fontSize: 12),
                        )),
                        Row(
                          children: [
                            OutlineButton(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                              child: Text(
                                '이메일 인증',
                                style: TextStyle(fontSize: 14),
                              ),
                              onPressed: () {
                                if (authStep == 1)
                                  setState(() {
                                    mobileAuth = false;
                                    findEmail = false;
                                    authStep++;
                                  });
                              },
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            OutlineButton(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                              child: Text(
                                '모바일 인증',
                                style: TextStyle(fontSize: 14),
                              ),
                              onPressed: () {
                                if (authStep == 1) {
                                  setState(() {
                                    mobileAuth = true;
                                    findEmail = false;
                                    authStep = 2;
                                  });
                                }
                              },
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
        width: 80,
        height: 30,
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
                )),
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
        width: 80,
        height: 30,
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
                )),
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
      return Container(
          width: 80,
          height: 30,
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
                  )),
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

    var phoneCodes = ['+1', '+82', '+59', '+123'];

    var phoneCodeDropdownmenu = Container(
        width: 80,
        height: 30,
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
      height: 30,
      width: 200,
      margin: EdgeInsets.only(left: 10),
      child: TextField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: BorderSide(color: Colors.black, width: 1),
          ),
          hintText: '휴대폰 번호',
          contentPadding: EdgeInsets.only(left: 10),
        ),
        keyboardType: TextInputType.text,
        style: TextStyle(
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
          Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                '* 휴대폰 번호',
                style: TextStyle(fontSize: 12),
              )),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              phoneCodeDropdownmenu,
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
                  '공백 특수기호 없이 특수문자만 입력하세요',
                  style: TextStyle(
                      color: kPrimaryColor, fontSize: 12),
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
                style: TextStyle(fontSize: 12),
              )),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 30,
            width: 200,
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: Colors.black, width: 1),
                ),
                hintText: '가입하신 이메일을 입력하세요.',
                contentPadding: EdgeInsets.only(left: 10),
              ),
              keyboardType: TextInputType.text,
              style: TextStyle(
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
      child: Image.asset('images/check_icon.png'),
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
              (authStep == 1) ? emptyCircleItem : checkedItem,
              SizedBox(
                width: 10,
              ),
              Text(
                '인증 요청',
                style: TextStyle(
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
                        Container(
                            child: Text(
                          '* 생년월일',
                          style: TextStyle(fontSize: 12),
                        )),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            yearDropdownmenu,
                            monthDropdownmenu,
                            dayDropdownmenu(birthYear, birthMonth),
                          ],
                        ),
                        mobileAuth ? phoneItem : emailItem,
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: OutlineButton(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                                child: Text(
                                  '이전',
                                  style: TextStyle(fontSize: 14),
                                ),
                                onPressed: () {
                                  if (authStep == 2) {
                                    setState(() {
                                      authStep--;
                                    });
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: RaisedButton(
                                color: kPrimaryColor,
                                child: Text(
                                  '발송하기',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                                onPressed: () {
                                  if (authStep == 2) {
                                    if(mobileAuth)
                                    {
                                      String phoneNumber = phoneCode.substring(1) + "-" + _phoneNumberController.text;
                                      print(phoneNumber);
                                      validate_SMS(phoneNumber);
                                    }
                                    else
                                      validate_email(_emailController.text);
                                    setState(() {
                                      authStep++;
                                    });
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

    var mobileAuthConfirmItem = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            child: Text(
          '* 인증번호',
          style: TextStyle(fontSize: 12),
        )),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 30,
          width: 200,
          child: TextField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3),
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              hintText: '6자의 숫자 인증번호',
              contentPadding: EdgeInsets.only(left: 10),
            ),
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: 14.0),
            controller: _authNumberController,
          ),
        ),
      ],
    );

    var emailAuthConfirmItem = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '* 입력한 이메일로 이동하여 이메일 인증을 완료해주세요.',
          style: TextStyle(fontSize: 12, color: Colors.black),
          textAlign: TextAlign.left,
        ),
        Text(
          '* 이메일 인증 완료 후에 아래 "인증" 버튼을 눌러주세요.',
          style: TextStyle(fontSize: 12, color: Colors.black),
          textAlign: TextAlign.left,
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
              (authStep < 3) ? emptyCircleItem : checkedItem,
              SizedBox(
                width: 10,
              ),
              Text(
                '인증 확인',
                style: TextStyle(
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
                      mobileAuthConfirmItem,//mobileAuth ? mobileAuthConfirmItem : emailAuthConfirmItem,
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: OutlineButton(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                              child: Text(
                                '이전',
                                style: TextStyle(fontSize: 14),
                              ),
                              onPressed: () {
                                if (authStep == 3)
                                  setState(() {
                                    authStep--;
                                  });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: RaisedButton(
                              color: kPrimaryColor,
                              child: Text(
                                '인증',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                              onPressed: () {
                                if (authStep == 3) {
//                                  if(mobileAuth)
//                                  {
                                    authSeq = validate_code(_authNumberController.text);
//                                  }
                                  if(authSeq=='')
                                    return;
//                                  if(findEmail)
//                                    foundEmail = get_email(authSeq);
                                  setState(() {
                                    authStep++;
                                  });
                                }
                              },
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
        ],
      ),
    );

    var passField = Container(
        height: 30,
        child: TextField(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: BorderSide(color: Colors.grey, width: 1),
            ),
            contentPadding: EdgeInsets.only(left: 10),
          ),
          obscureText: true,
          style: TextStyle(fontSize: 16.0),
          controller: _passwordController,
        ));
    var repassField = Container(
        height: 30,
        child: TextField(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: BorderSide(color: Colors.grey, width: 1),
            ),
            contentPadding: EdgeInsets.only(left: 10),
          ),
          obscureText: true,
          style: TextStyle(fontSize: 16.0),
          controller: _repasswordController,
        ));

    var passwordResetItem = Container(
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
              Text(
                '* 비밀번호를 입력하고 변경 버튼을 누르세요.',
                style: TextStyle(fontSize: 12, color: Colors.black),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 10,
              ),
              passField,
              SizedBox(
                height: 10,
              ),
              repassField,
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
                    Expanded(
                        child: Text(
                      '8~20자의 영문 대/소문자, 숫자, 특수문자 중 3가지 이상 혼용하여 입력해주세요.',
                      style: TextStyle(
                          color: kPrimaryColor, fontSize: 12),
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  color: kPrimaryColor,
                  child: Text(
                    '변경하기',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  onPressed: () {
                    if(_passwordController.text!='' && _passwordController.text==_repasswordController.text){
                      reset_password(_passwordController.text, authSeq);
                    }
                  },
                ),
              ),
            ],
          ),
        ));

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
              '* 이메일 주소',
              style: TextStyle(fontSize: 12),
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
                    foundEmail,
                    style: TextStyle(fontSize: 14, color: Colors.black),
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
              (authStep < 4) ? emptyCircleItem : checkedItem,
              SizedBox(
                width: 10,
              ),
              Text(
                '정보 확인 또는 변경',
                style: TextStyle(
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

    var gotoLoginButton = Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
      ),
      child: Center(
        child: FlatButton(
          child: Text(
            '로그인 페이지로',
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed('/login');
          },
        ),
      ),
    );

    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text(
              '이메일 확인 및 비밀번호 초기화',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text(
              '이메일 아이디 찾기 또는 비밀번호 초기화를 진행합니다.',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          Divider(
            height: 10,
            color: Colors.black54,
          ),
          emailOrPasswordItem,
          authRequestItem,
          authConfirmItem,
          infoConfirmOrChangeItem,
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
        ],
      ),
    );
  }
}
