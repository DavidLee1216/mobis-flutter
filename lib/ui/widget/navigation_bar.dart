import 'package:flutter/material.dart';
import 'package:hyundai_mobis/ui/screen/home_screen.dart';
import 'package:hyundai_mobis/ui/screen/my_page_screen.dart';
import 'package:hyundai_mobis/ui/screen/notice_screen.dart';
import 'package:hyundai_mobis/ui/screen/notification_screen.dart';
import 'package:hyundai_mobis/ui/screen/part_market_search_screen.dart';
import 'package:hyundai_mobis/ui/screen/part_simple_search_screen.dart';

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
    HomeScreen(),
    PartMarketSearchScreen(),
    PartSimpleSearchScreen(),
    NoticeScreen(),
  ];
  @override
  void initState() {
    super.initState();
    _selectedIndex = (widget.index < 4) ? widget.index : 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (_initState && widget.index >= 4)
          ? _screens[widget.index]
          : _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('images/1507.png'),
            ),
            label: '알람',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('images/Home_icon.png'),
            ),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('images/Profile_icon.png'),
            ),
            label: '마이페이지',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('images/support_icon.png'),
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
          });
        },
      ),
    );
  }
}
