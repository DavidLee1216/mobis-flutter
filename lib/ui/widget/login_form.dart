import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Image.asset('images/login_background.png',
                    fit: BoxFit.fill,
                    color: Color.fromRGBO(255, 255, 255, 1),
                    colorBlendMode: BlendMode.modulate,
                  )
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 50,),
                      Text(
                        '새로운 공간경험을 선사합니다.',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      Padding(padding: EdgeInsets.only(top: 20),),
                      Text('현대모비스는 세상과 교감하는 미래자동차의',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      Padding(padding: EdgeInsets.only(top: 5),),
                      Text('커넥티비티 기술을 만들어 갑니다.',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width-50,
                        height: 50,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                          color: Colors.green,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset('images/naver_icon.png'),
                              SizedBox(width: 10,),
                              Text('네이버로그인',
                                style: TextStyle(fontSize: 14, color: Colors.white),
                              ),
                            ],
                          ),
                          onPressed: (){

                          },
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width-50,
                        height: 50,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                          color: Colors.yellow,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset('images/kakao_icon.png'),
                              SizedBox(width: 10,),
                              Text('카카오톡 로그인',
                                style: TextStyle(fontSize: 14, color: Colors.white),
                              ),
                            ],
                          ),
                          onPressed: (){

                          },
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width-50,
                        height: 50,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset('images/google_icon.png'),
                              SizedBox(width: 10,),
                              Text('구글 로그인',
                                style: TextStyle(fontSize: 14, color: Colors.white),
                              ),
                            ],
                          ),
                          onPressed: (){

                          },
                        ),
                      ),
                      SizedBox(height: 30,),
                      Container(
                        width: 250,
                        height: 50,
                        child: FlatButton(
                          child: Text('아이디로 로그인하기', style: TextStyle(fontSize: 14, color: Colors.white),),
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed('/idlogin');
                          },
                        ),
                      )

                    ],
                  ),

          ]),
        ));
  }
}
