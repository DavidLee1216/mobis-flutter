import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hyundai_mobis/ui/screen/login_screen.dart';
import 'package:hyundai_mobis/ui/screen/my_page_screen.dart';
import 'package:hyundai_mobis/ui/screen/notice_screen.dart';
import 'package:hyundai_mobis/ui/screen/part_market_search_screen.dart';
import 'package:hyundai_mobis/ui/screen/part_simple_search_screen.dart';
import 'package:hyundai_mobis/utils/navigation.dart';

const kPrimaryColor = Color.fromRGBO(0, 71, 135, 1);
const kTitleStyle = TextStyle(fontSize: 18, color: Colors.white);
const kSubtitleStyle = TextStyle(fontSize: 14, color: Colors.white);
const kButtonTextStyle = TextStyle(fontSize: 14, color: Colors.white);
const kMenuTextStyle = TextStyle(fontSize: 12);
const kMarginSpace = 40.0;
const kImageWidth = 80.0;

class HomeScreen extends StatelessWidget {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Image.asset('images/mark.jpg'),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text('지속가능한 친환경 기술을 선도합니다.', style: kTitleStyle),
                    SizedBox(height: 5),
                    Text('현대모비스는 무한하고 청정한 미래자동차의', style: kSubtitleStyle),
                    Text('전동화 부품기술을 만들어 갑니다.', style: kSubtitleStyle),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: kMarginSpace),
                child: Image.asset('images/car.png'),
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('안녕하세요, xxx 고객님.'),
                    RaisedButton(
                      color: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text('로그인', style: kButtonTextStyle),
                      onPressed: () {
                        pushTo(context, LoginScreen());
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: RaisedButton(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'images/notice_home.png',
                                width: kImageWidth,
                              ),
                              Text('공지사항', style: kMenuTextStyle)
                            ],
                          ),
                          onPressed: () {
                            pushTo(context, NoticeScreen());
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: RaisedButton(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'images/search_home.png',
                                width: kImageWidth,
                              ),
                              Text(
                                '부품판매점검색',
                                textAlign: TextAlign.center,
                                style: kMenuTextStyle,
                              )
                            ],
                          ),
                          onPressed: () {
                            pushTo(context, PartMarketSearchScreen());
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: RaisedButton(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'images/car_home.png',
                                width: kImageWidth,
                              ),
                              Text(
                                '부품검색',
                                textAlign: TextAlign.center,
                                style: kMenuTextStyle,
                              )
                            ],
                          ),
                          onPressed: () {
                            pushTo(context, PartSimpleSearchScreen());
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: RaisedButton(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'images/profile_home.png',
                                width: kImageWidth,
                              ),
                              Text(
                                '마이페이지',
                                textAlign: TextAlign.center,
                                style: kMenuTextStyle,
                              )
                            ],
                          ),
                          onPressed: () {
                            pushTo(context, MyPageScreen());
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
