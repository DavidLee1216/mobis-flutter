import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobispartsearch/ui/screen/login_screen.dart';
import 'package:mobispartsearch/ui/widget/navigation_bar.dart';
import 'package:mobispartsearch/utils/navigation.dart';
import 'package:mobispartsearch/common.dart';

const kPrimaryColor = Color.fromRGBO(7, 75, 136, 1);
const kTitleStyle =
    TextStyle(fontFamily: 'HDharmony', fontSize: 18, color: Colors.white);
const kSubtitleStyle =
    TextStyle(fontFamily: 'HDharmony', fontSize: 14, color: Colors.white);
const kButtonTextStyle =
    TextStyle(fontFamily: 'HDharmony', fontSize: 15, color: Colors.white);
const kMenuTextStyle = TextStyle(fontFamily: 'HDharmony', fontSize: 15);
const kMarginSpace = 40.0;
const kImageWidth = 50.0;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final double topHeight = MediaQuery.of(context).size.height / 3.0;

    return Container(
      height: double.infinity,
      child: Stack(children: <Widget>[
        Container(
          height: topHeight + kMarginSpace,
          width: double.infinity,
          color: kPrimaryColor,
          padding: const EdgeInsets.only(top: 10),
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 70),
                    child: Image.asset('assets/images/logo2.png'),
                    width: 270,
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Image.asset('assets/images/car_white.png'),
                width: 320,
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: topHeight),
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(kMarginSpace),
              topRight: const Radius.circular(kMarginSpace),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '안녕하세요, 고객님.',
                        style: kMenuTextStyle,
                      ),
                      RaisedButton(
                        color: kPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Text('로그인', style: kButtonTextStyle),
                        onPressed: () {
                          pushTo(context, LoginScreen());
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(15),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 38),
                              ),
                              Image.asset(
                                'assets/images/notice_H.png',
                                width: kImageWidth,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '공지사항',
                                style: kMenuTextStyle,
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => NavigationBar(
                                  index: 6,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                              ),
                              Image.asset(
                                'assets/images/search_store_H.png',
                                width: kImageWidth,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '부품판매점검색',
                                textAlign: TextAlign.center,
                                style: kMenuTextStyle,
                              )
                            ],
                          ),
                          onPressed: () {
                            if (globalSidoLoaded)
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                      pageBuilder: (_, __, ___) =>
                                          NavigationBar(
                                            index: 4,
                                          )));
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                              ),
                              Image.asset(
                                'assets/images/search_H.png',
                                width: kImageWidth,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '부품검색',
                                textAlign: TextAlign.center,
                                style: kMenuTextStyle,
                              )
                            ],
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => NavigationBar(
                                  index: 5,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 28),
                              ),
                              Image.asset(
                                'assets/images/my_page_H.png',
                                width: kImageWidth,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '마이페이지',
                                textAlign: TextAlign.center,
                                style: kMenuTextStyle,
                              )
                            ],
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => NavigationBar(
                                  index: 2,
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
          ),
        ),
      ]),
    );
  }
}
