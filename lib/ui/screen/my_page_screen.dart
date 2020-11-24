import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobispartsearch/bloc/auth_bloc.dart';
import 'package:mobispartsearch/bloc/notice_bloc.dart';
import 'package:mobispartsearch/ui/screen/login_screen.dart';
import 'package:mobispartsearch/ui/screen/my_coupon_screen.dart';
import 'package:mobispartsearch/ui/screen/my_info_screen.dart';
import 'package:mobispartsearch/ui/screen/notification_screen.dart';
import 'package:mobispartsearch/ui/widget/notice_form.dart';
import 'package:mobispartsearch/ui/widget/loading_indication.dart';
import 'package:mobispartsearch/ui/screen/my_page_query_screen.dart';
import 'package:mobispartsearch/utils/navigation.dart';

class MyPageScreen extends StatefulWidget {
  @override
  _MyPageScreenState createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  bool searchIconClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text('마이페이지'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            MyPageWidget(),
          ],
        ),
      ),
    );
  }
}

class MyPageWidget extends StatelessWidget {
  var loggedin = false;
  ModalQueryScreen queryModal = new ModalQueryScreen();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    var loginButton = Container(
      child: ButtonTheme(
        minWidth: screenWidth * 0.25,
        height: 40,
        buttonColor: Color.fromRGBO(0, 63, 114, 1),
        child: RaisedButton(
          padding: EdgeInsets.only(left: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(
                color: Color.fromRGBO(0, 63, 114, 1),
                width: 1.0,
                style: BorderStyle.solid),
          ),
          child: Text('로그인',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              )),
          onPressed: () {
            pushTo(context, LoginScreen());
          },
        ),
      ),
    );

    var greetingUnauthenticated = Text(
      '안녕하세요, 고객님.',
      style: TextStyle(
        fontSize: 14,
      ),
      textAlign: TextAlign.center,
    );

    greetingAuthentcated(String name) {
      return Text(
        '안녕하세요, $name고객님.',
        style: TextStyle(
          fontSize: 14,
        ),
        textAlign: TextAlign.center,
      );
    }

//    askDialog() {
//      showDialog(context: context, builder: (_){
//        return Container(
//          child: Column(
//            children: [
//              ListTile(
//                title: Text('앱 관련 문의하기', style: TextStyle(fontSize: 16,),),
//              ),
//              Divider(color: Colors.black26,),
//              ListTile(
//                title: Text('그 외 사항 문의하기', style: TextStyle(fontSize: 16,),),
//              )
//            ],
//          ),
//        );
//      });
//    }

    return BlocBuilder<AuthBloc, AuthState>(
        cubit: BlocProvider.of<AuthBloc>(context),
        builder: (BuildContext context, state) {
          return Column(
            children: [
              SizedBox(
                height: 30,
              ),
              state.isAuthenticated()
                  ? greetingAuthentcated('양**')
                  : greetingUnauthenticated,
              SizedBox(
                height: 20,
              ),
              state.isAuthenticated()
                  ? Container()
                  : Column(children: [
                      loginButton,
                      SizedBox(
                        height: 20,
                      ),
                    ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth * 0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(1.0, 3.0),
                            blurRadius: 8.0,
                            spreadRadius: 1.0,
                          )
                        ]),
                    child: Column(
                      children: [
                        state.isAuthenticated()
                            ? Column(
                                children: [
                                  Container(
                                    height: 50,
                                    child: ListTile(
                                      title: Text(
                                        'My info (차량 정보 등 고객 정보 수정)',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      trailing: Icon(
                                        Icons.keyboard_arrow_right,
                                        color: Colors.black,
                                      ),
                                      onTap: () {
                                        pushTo(context, MyInfoScreen());
                                      },
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.black54,
                                  ),
                                ],
                              )
                            : Container(),
                        Container(
                          height: 50,
                          child: ListTile(
                            title: Text(
                              '문의하기',
                              style: TextStyle(fontSize: 14),
                            ),
                            trailing: Icon(
                              Icons.keyboard_arrow_right,
                              color: Colors.black,
                            ),
                            onTap: () {
                              queryModal.mainModalBottomSheet(context);
                            }, //askDialog(),
                          ),
                        ),
                        Divider(
                          color: Colors.black54,
                        ),
                        state.isAuthenticated()
                            ? Column(
                                children: [
                                  Container(
                                    height: 50,
                                    child: ListTile(
                                      title: Text(
                                        'My 쿠폰',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      trailing: Icon(
                                        Icons.keyboard_arrow_right,
                                        color: Colors.black,
                                      ),
                                      onTap: () {
                                        pushTo(context, MyCouponScreen());
                                      },
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.black54,
                                  ),
                                ],
                              )
                            : Container(),
                        Container(
                          height: 50,
                          child: ListTile(
                            title: Text(
                              '알림',
                              style: TextStyle(fontSize: 14),
                            ),
                            trailing: Icon(
                              Icons.keyboard_arrow_right,
                              color: Colors.black,
                            ),
                            onTap: () {
                              pushTo(context, NotificationScreen());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: screenWidth * 0.9,
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: 20,
                      ),
                    ),
                    FlatButton(
                        child: Text(
                      '로그아웃',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                      onPressed: (){

                      },
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }
}
