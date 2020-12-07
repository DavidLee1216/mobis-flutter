import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobispartsearch/service/auth_service.dart';
import 'package:mobispartsearch/ui/screen/id_login_screen.dart';
import 'package:mobispartsearch/utils/navigation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

import '../../common.dart';
import 'navigation_bar.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  void initState() {
    if(getStringValueSF() != '' && tokenExpired)
      checkLocalAuth();
  }

  Future<void> checkLocalAuth() async {
    var localAuth = LocalAuthentication();
    bool canCheckBiometrics = await localAuth.canCheckBiometrics;
    if(!mounted) return;
    if (canCheckBiometrics) {
      List<BiometricType> availableBiometrics =
          await localAuth.getAvailableBiometrics();
      try {
        bool didAuthenticate = await localAuth.authenticateWithBiometrics(
            localizedReason: '계속하려면 인증해주세요.',
          useErrorDialogs: true,
          stickyAuth: false,
        );
        if(didAuthenticate)
        {
          pushTo(context, NavigationBar(index: 1));
        }
      } on PlatformException catch (e) {
        if (e.code == auth_error.notAvailable) {
          print(e);
        }
      }
    } else{
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Stack(children: <Widget>[
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/images/login_background.png',
              fit: BoxFit.fill,
              color: Color.fromRGBO(255, 255, 255, 1),
              colorBlendMode: BlendMode.modulate,
            )),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 6,
              ),
              Text(
                '지속가능한 친환경 기술을 선도합니다.',
                style: TextStyle(
                    fontFamily: 'HDharmony', fontSize: 20, color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
              ),
              Text(
                '현대모비스는 무한하고 청정한 미래자동차의',
                style: TextStyle(
                    fontFamily: 'HDharmony', fontSize: 14, color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
              ),
              Text(
                '전동화 부품기술을 만들어 갑니다.',
                style: TextStyle(
                    fontFamily: 'HDharmony', fontSize: 14, color: Colors.white),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 7,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 50,
                height: 48,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  color: Color(0xff1ec800),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.25),
                      ),
                      Image.asset('assets/images/naver_icon.png',
                          width: 20, height: 20),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '네이버 로그인',
                        style: TextStyle(
                          fontFamily: 'HDharmony',
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 50,
                height: 48,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  color: Color.fromRGBO(241, 208, 49, 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.25),
                      ),
                      Image.asset(
                        'assets/images/kakao_icon.png',
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '카카오톡 로그인',
                        style: TextStyle(
                            fontFamily: 'HDharmony',
                            fontSize: 14,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 50,
                height: 48,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(
                          color: Colors.red,
                          width: 1.0,
                          style: BorderStyle.solid)),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.25),
                      ),
                      Image.asset('assets/images/google_icon.png',
                          width: 20, height: 20),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '구글 로그인',
                        style: TextStyle(
                            fontFamily: 'HDharmony',
                            fontSize: 14,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  onPressed: () {
                    signInWithGoogle(context);
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 250,
                height: 40,
                child: FlatButton(
                  child: Text(
                    '아이디로 로그인하기',
                    style: TextStyle(
                        fontFamily: 'HDharmony',
                        fontSize: 14,
                        color: Colors.white),
                  ),
                  onPressed: () {
                    pushTo(context, IdLoginScreen());
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 50,
                height: 48,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(
                          color: Colors.indigo,
                          width: 1.0,
                          style: BorderStyle.solid)),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '로그인 없이 살펴보기',
                        style: TextStyle(
                            fontFamily: 'HDharmony',
                            fontSize: 14,
                            color: Colors.indigo),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Expanded(
                  child: SizedBox(
                height: 20,
              )),
            ],
          ),
        ),
      ]),
    ));
  }
}
