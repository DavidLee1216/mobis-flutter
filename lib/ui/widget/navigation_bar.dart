import 'package:flutter/material.dart';
import 'package:mobispartsearch/ui/screen/home_screen.dart';
import 'package:mobispartsearch/ui/screen/my_coupon_screen.dart';
import 'package:mobispartsearch/ui/screen/my_info_screen.dart';
import 'package:mobispartsearch/ui/screen/my_page_query_screen.dart';
import 'package:mobispartsearch/ui/screen/my_page_screen.dart';
import 'package:mobispartsearch/ui/screen/notice_screen.dart';
import 'package:mobispartsearch/ui/screen/notification_screen.dart';
import 'package:mobispartsearch/ui/screen/part_market_search_screen.dart';
import 'package:mobispartsearch/ui/screen/part_simple_search_screen.dart';
import 'package:mobispartsearch/ui/screen/cart_screen.dart';
import 'package:mobispartsearch/ui/screen/user_history_screen.dart';

class NavigationBar extends StatefulWidget {
  final int
      index; //0:notice, 1:home, 2:my_page, 3: support, 4: market_search, 5: simple_search

  const NavigationBar({Key key, this.index}) : super(key: key);
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int _selectedIndex = 1;
  bool _initState = true;
  final List<Widget> _screens = [
    NotificationScreen(),
    HomeScreen(),
    MyPageScreen(),
    MyPageScreen(),
    PartMarketSearchScreen(),
    PartSimpleSearchScreen(),
    NoticeScreen(),
    CartScreen(),
    MyCouponScreen(),
    UserHistoryScreen(),
  ];
  @override
  void initState() {
    super.initState();
    _selectedIndex = (widget.index < 4)
        ? widget.index
        : (widget.index != 8)
            ? 1
            : 2;
  }

  @override
  Widget build(BuildContext context) {
    final ModalQueryScreen queryModal = new ModalQueryScreen();

    showCustomerCenter() {
      queryModal.mainModalBottomSheet(context);
    }

    return Scaffold(
      body: (_initState && widget.index >= 4)
          ? _screens[widget.index]
          : _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 30.0,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/images/1507.png'),
            ),
            label: '알람',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/images/Home_icon.png'),
            ),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/images/Profile_icon.png'),
            ),
            label: '마이페이지',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/images/support_icon.png'),
            ),
            label: '고객센터',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
            _initState = false;
            if (_selectedIndex == 3) {
              showCustomerCenter();
            }
          });
        },
      ),
    );
  }
}
