import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeForm extends StatefulWidget {
  @override
  _HomeFormState createState() => _HomeFormState();

}

class _HomeFormState extends State<HomeForm> {
  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if(index==0)
        Navigator.of(context).pushNamed('/notice');
      else if(index==0)
        Navigator.of(context).pushNamed('/home');
//      else if(index==0)
//        Navigator.of(context).pushNamed('/my_page');
//      else if(index==0)
//        Navigator.of(context).pushNamed('/support');

    });
  }
  double countItemSize(double parentWidth, double parentHeight){
    double width = (parentWidth-40)/2;
    double height = (parentHeight*2/3 - 40 - kBottomNavigationBarHeight)/2-10;
    return min(width, height);
  }
  @override
  Widget build(BuildContext context) {
    var itemSize = countItemSize(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    var imageSize = itemSize/2.0;
    return Scaffold(
        body: Container(
          child: Stack(
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Color.fromRGBO(0, 71, 135, 1),
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height/3.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Image.asset('images/mark.png'),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text('지속가능한 친환경 기술을 선도합니다.', style: TextStyle(fontSize: 18, color: Colors.white),),
                                      SizedBox(height: 10,),
                                      Text('현대모비스는 무한하고 청정한 미래자동차의', style: TextStyle(fontSize: 14, color: Colors.white),),
                                      Text('전동화 부품기술을 만들어 갑니다.', style: TextStyle(fontSize: 14, color: Colors.white),),
                                    ]
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 0),
                                child:
                                  Image.asset('images/car.png'),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(40.0),
                                topRight: const Radius.circular(40.0),
                              ),
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(height: 20,),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('안녕하세요, 고객님.'),
                                      SizedBox(width: MediaQuery.of(context).size.width/5.0,),
                                      Container(
                                        width: 90,//MediaQuery.of(context).size.width/5.0,
                                        height: 30,
                                        child: RaisedButton(
                                          color: Color.fromRGBO(0, 63, 114, 1),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15.0),
                                            side: BorderSide(color: Colors.blueGrey, width: 1.0, style: BorderStyle.solid),
                                          ),
                                          child: Text('로그인', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 14),),
                                          onPressed: () {
                                            Navigator.of(context).pushNamed('/login');
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: itemSize,
                                          height: itemSize,
                                          padding: EdgeInsets.all(10),
                                          child: RaisedButton(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
//                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Image.asset('images/notice_home.png', width: imageSize, height: imageSize,),
                                                Text('공지사항', textAlign: TextAlign.center, style: TextStyle(fontSize: 12),)
                                              ],
                                            ),
                                            color: Colors.white,
                                            onPressed: () {
                                              Navigator.of(context).pushNamed('/notice');
                                            },
                                          ),
                                        ),
                                        Container(
                                          width: itemSize,
                                          height: itemSize,
                                          padding: EdgeInsets.all(10),
                                          child: RaisedButton(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
//                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Image.asset('images/search_home.png', width: imageSize, height: imageSize),
                                                Text('부품판매점검색', textAlign: TextAlign.center, style: TextStyle(fontSize: 12),)
                                              ],
                                            ),
                                            color: Colors.white,
                                            onPressed: () {},
                                          ),
                                        ),
                                      ]
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:[
                                      Container(
                                        width: itemSize,
                                        height: itemSize,
                                        padding: EdgeInsets.all(10),
                                        child: RaisedButton(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
//                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Image.asset('images/car_home.png', width: imageSize, height: imageSize),
                                              Text('부품검색', textAlign: TextAlign.center, style: TextStyle(fontSize: 12),)
                                            ],
                                          ),
                                          color: Colors.white,
                                          onPressed: () {},
                                        ),
                                      ),
                                      Container(
                                        width: itemSize,
                                        height: itemSize,
                                        padding: EdgeInsets.all(10),
                                        child: RaisedButton(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
//                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Image.asset('images/profile_home.png', width: imageSize, height: imageSize),
                                              Text('마이페이지', textAlign: TextAlign.center, style: TextStyle(fontSize: 12),)
                                            ],
                                          ),
                                          color: Colors.white,
                                          onPressed: () {},
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                )

              ]),
        ),
        bottomNavigationBar:
          BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage('images/alarm.png'), color: Colors.grey,),
                  activeIcon: ImageIcon(AssetImage('images/alarm.png'), color: Colors.black,),
                  title: Text('알람', style: TextStyle(fontSize: 12),),
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('images/home.png'), color: Colors.grey),
                activeIcon: ImageIcon(AssetImage('images/home.png'), color: Colors.black),
                title: Text('홈', style: TextStyle(fontSize: 12)),
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('images/person.png'), color: Colors.grey),
                activeIcon: ImageIcon(AssetImage('images/person.png'), color: Colors.black),
                title: Text('마이페이지', style: TextStyle(fontSize: 12)),
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('images/support.png'), color: Colors.grey),
                activeIcon: ImageIcon(AssetImage('images/support.png'), color: Colors.black),
                title: Text('고객센터', style: TextStyle(fontSize: 12)),
              ),
            ],
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.black,
            showUnselectedLabels: true,
            onTap: _onItemTapped,
         ),
    );
  }
}
