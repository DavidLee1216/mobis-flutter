import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobispartsearch/ui/screen/home_screen.dart';

class MyCouponScreen extends StatefulWidget {
  @override
  _MyCouponScreenState createState() => _MyCouponScreenState();
}

class _MyCouponScreenState extends State<MyCouponScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0)
        Navigator.of(context).pushNamed('/notification');
      else if (index == 1)
        Navigator.of(context).pushNamed('/home');
      else if (index == 2)
        Navigator.of(context).pushNamed('/my_page');
      else if (index == 3) Navigator.of(context).pushNamed('/support');
    });
  }

  @override
  Widget build(BuildContext context) {
    _selectedIndex = 2;

    var screenWidth = MediaQuery.of(context).size.width;

    var subjectItem = Center(
      child: Text('발급 쿠폰 조회', style: TextStyle(fontSize: 14), textAlign: TextAlign.center,),
    );

    couponItem(String couponSubject, String fromDate, String toDate, String target, String couponNumber){
      return Container(
        width: screenWidth*0.9,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 10,),
            Text('$couponSubject 쿠폰 (유효기간: $fromDate ~ $toDate)', style: TextStyle(fontSize: 14), textAlign: TextAlign.center,),
            SizedBox(height: 10,),
            Text('대상제목 : $target', style: TextStyle(fontSize: 14), textAlign: TextAlign.center,),
            SizedBox(height: 10,),
            Text('쿠폰 번호 : $couponNumber', style: TextStyle(fontSize: 14), textAlign: TextAlign.center,),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(child: SizedBox(width: 10,)),
                GestureDetector(
                  child: Icon(Icons.clear),
                  onTap: (){
                    
                  },
                ),
              ],
            )
          ],
        ),
      );
    }
     return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text('마이페이지'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(height: 20,),
            subjectItem,
            Column(
              children: [
                SizedBox(height: 20,),
                couponItem('소모품 할인', '2020년 10월', '2020년 11월', '워셔액, 와이퍼, 에어컨 필터', '0000-0000-0000-0000'),
                SizedBox(height: 10,),
                couponItem('미세먼지 이겨내요', ' 2020년 10월', '2020년 11월', '에어컨 필터', '0000-0000-0000-0000'),
              ],
            ),
          ],
        ), //
      ),
       bottomNavigationBar: BottomNavigationBar(
         items: const <BottomNavigationBarItem>[
           BottomNavigationBarItem(
             icon: ImageIcon(
               AssetImage('images/alarm.png'),
               color: Colors.grey,
             ),
             activeIcon: ImageIcon(
               AssetImage('images/alarm.png'),
               color: Colors.black,
             ),
             title: Text(
               '알람',
               style: TextStyle(fontSize: 12),
             ),
           ),
           BottomNavigationBarItem(
             icon: ImageIcon(AssetImage('images/home.png'), color: Colors.grey),
             activeIcon:
             ImageIcon(AssetImage('images/home.png'), color: Colors.black),
             title: Text('홈', style: TextStyle(fontSize: 12)),
           ),
           BottomNavigationBarItem(
             icon:
             ImageIcon(AssetImage('images/person.png'), color: Colors.grey),
             activeIcon:
             ImageIcon(AssetImage('images/person.png'), color: Colors.black),
             title: Text('마이페이지', style: TextStyle(fontSize: 12)),
           ),
           BottomNavigationBarItem(
             icon:
             ImageIcon(AssetImage('images/support.png'), color: Colors.grey),
             activeIcon: ImageIcon(AssetImage('images/support.png'),
                 color: Colors.black),
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
