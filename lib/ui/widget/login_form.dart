import 'package:flutter/material.dart';
import 'package:mobispartsearch/ui/screen/id_login_screen.dart';
import 'package:mobispartsearch/utils/navigation.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Stack(children: <Widget>[
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'images/login_background.png',
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
                height: 40,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.25),
                      ),
                      Image.asset('images/naver_icon.png',
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
                height: 40,
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
                        'images/kakao_icon.png',
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
                height: 40,
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
                      Image.asset('images/google_icon.png',
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
                  onPressed: () {},
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
                height: 40,
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
