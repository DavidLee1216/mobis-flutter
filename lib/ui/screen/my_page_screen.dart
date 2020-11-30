import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobispartsearch/bloc/auth_bloc.dart';
import 'package:mobispartsearch/ui/screen/login_screen.dart';
import 'package:mobispartsearch/ui/screen/my_info_screen.dart';
import 'package:mobispartsearch/ui/screen/notification_screen.dart';
import 'package:mobispartsearch/ui/screen/my_page_query_screen.dart';
import 'package:mobispartsearch/ui/widget/navigation_bar.dart';
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
        title: Text(
          '마이페이지',
          style: TextStyle(
            fontFamily: 'HDharmony',
          ),
        ),
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
  final ModalQueryScreen queryModal = new ModalQueryScreen();

  @override
  Widget build(BuildContext context) {
    final AuthBloc bloc = BlocProvider.of<AuthBloc>(context);

    var screenWidth = MediaQuery.of(context).size.width;

    var loginButton = Container(
      child: ButtonTheme(
        minWidth: screenWidth * 0.9,
        height: 50,
        buttonColor: Color.fromRGBO(0, 63, 114, 1),
        child: RaisedButton(
          padding: EdgeInsets.only(left: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: BorderSide(
                color: Color.fromRGBO(0, 63, 114, 1),
                width: 1.0,
                style: BorderStyle.solid),
          ),
          child: Text('로그인',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'HDharmony',
                color: Colors.white,
                fontSize: 18,
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
        fontFamily: 'HDharmony',
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );

    greetingAuthentcated(String name) {
      return Text(
        '안녕하세요, $name고객님.',
        style: TextStyle(
          fontFamily: 'HDharmony',
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      );
    }

    return BlocBuilder<AuthBloc, AuthState>(
        cubit: BlocProvider.of<AuthBloc>(context),
        builder: (BuildContext context, state) {
          return Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  state.isAuthenticated()
                      ? greetingAuthentcated(state.id)
                      : greetingUnauthenticated,
                  SizedBox(
                    height: 50,
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
                            if (state.isAuthenticated())
                              Column(
                                children: [
                                  Container(
                                    height: 50,
                                    child: ListTile(
                                      title: Text(
                                        'My info (차량 정보 등 고객 정보 수정)',
                                        style: TextStyle(
                                            fontFamily: 'HDharmony',
                                            fontSize: 16),
                                      ),
                                      trailing: Padding(
                                        padding: EdgeInsets.all(14),
                                        child: Image.asset(
                                            'assets/images/arrow.png'),
                                      ),
                                      onTap: () {
                                        pushTo(context, MyInfoScreen());
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Divider(
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            Container(
                              height: 50,
                              child: ListTile(
                                title: Text(
                                  '문의하기',
                                  style: TextStyle(
                                    fontFamily: 'HDharmony',
                                    fontSize: 16,
                                  ),
                                ),

                                trailing: Padding(
                                  padding: EdgeInsets.all(14),
                                  child: Image.asset('assets/images/arrow.png'),
                                ),

                                onTap: () {
                                  queryModal.mainModalBottomSheet(context);
                                }, //askDialog(),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Divider(
                                color: Colors.black54,
                              ),
                            ),
                            if (state.isAuthenticated())
                              Column(
                                children: [
                                  Container(
                                    height: 50,
                                    child: ListTile(
                                      title: Text(
                                        'My 쿠폰',
                                        style: TextStyle(
                                            fontFamily: 'HDharmony',
                                            fontSize: 16),
                                      ),
                                      trailing: Padding(
                                        padding: EdgeInsets.all(14),
                                        child: Image.asset(
                                            'assets/images/arrow.png'),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (_, __, ___) =>
                                                NavigationBar(
                                              index: 8,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Divider(
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            Container(
                              height: 50,
                              margin: const EdgeInsets.only(bottom: 10),
                              child: ListTile(
                                title: Text(
                                  '알림',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'HDharmony', fontSize: 16),
                                ),
                                trailing: Padding(
                                  padding: EdgeInsets.all(14),
                                  child: Image.asset('assets/images/arrow.png'),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (_, __, ___) =>
                                          NavigationBar(
                                        index: 0,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (state.isAuthenticated())
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
                              style: TextStyle(
                                  fontFamily: 'HDharmony',
                                  fontSize: 14,
                                  color: Colors.black54),
                            ),
                            onPressed: () => bloc.add(AuthEventSignOut()),
                          ),
                        ],
                      ),
                    )
                ],
              ),
            ),
          );
        });
  }
}
