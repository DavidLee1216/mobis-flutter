import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyundai_mobis/bloc/auth_bloc.dart';
import 'package:hyundai_mobis/ui/widget/notice_form.dart';
import 'package:hyundai_mobis/ui/widget/loading_indication.dart';

class NoticeScreen extends StatefulWidget {
  @override
  _NoticeScreenState createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0)
        Navigator.of(context).pushNamed('notification');
      else if (index == 0)
        Navigator.of(context).pushNamed('home');
      else if (index == 0)
        Navigator.of(context).pushNamed('my_page');
      else if (index == 0) Navigator.of(context).pushNamed('support');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text('공지사항'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: NoticeListWidget(), //
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

class NoticeListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        NoticeForm(title: '시스템 개선 작업 안내', date: '2020.10.09', text: '서버에 따른 시스템 정기 점검이 있습니다.\n 작업 일정 : 2020.10.31\n 작업 시간 : 오전 5시 ~ 오전 6시\n 시스템 개선 작업이 종료될 때까지 일부 서비스가 제한될 수 있으니 이점 양해 부탁드립니다.',),
        Divider(color: Colors.black54,),
        NoticeForm(
          title: '[이벤트]미세먼지 이겨내요',
          date: '2020.10.09',
          text: '서버에 따른 시스템 정기 점검이 있습니다.\n 작업 일정 : 2020.10.31\n 작업 시간 : 오전 5시 ~ 오전 6시\n 시스템 개선 작업이 종료될 때까지 일부 서비스가 제한될 수 있으니 이점 양해 부탁드립니다.',
        ),
        Divider(color: Colors.black54,),
        NoticeForm(
          title: '시스템 개선 작업 안내',
          date: '2020.10.09',
          text: '서버에 따른 시스템 정기 점검이 있습니다.\n 작업 일정 : 2020.10.31\n 작업 시간 : 오전 5시 ~ 오전 6시\n 시스템 개선 작업이 종료될 때까지 일부 서비스가 제한될 수 있으니 이점 양해 부탁드립니다.',
        ),
        Divider(color: Colors.black54,),
        NoticeForm(
          title: '시스템 개선 작업 안내',
          date: '2020.10.09',
          text: '서버에 따른 시스템 정기 점검이 있습니다.\n 작업 일정 : 2020.10.31\n 작업 시간 : 오전 5시 ~ 오전 6시\n 시스템 개선 작업이 종료될 때까지 일부 서비스가 제한될 수 있으니 이점 양해 부탁드립니다.',
        ),
        Divider(color: Colors.black54,),
        NoticeForm(
          title: '시스템 개선 작업 안내',
          date: '2020.10.09',
          text: '서버에 따른 시스템 정기 점검이 있습니다.\n 작업 일정 : 2020.10.31\n 작업 시간 : 오전 5시 ~ 오전 6시\n 시스템 개선 작업이 종료될 때까지 일부 서비스가 제한될 수 있으니 이점 양해 부탁드립니다.',
        ),
        Divider(color: Colors.black54,),
        NoticeForm(
          title: '시스템 개선 작업 안내',
          date: '2020.10.09',
          text: '서버에 따른 시스템 정기 점검이 있습니다.\n 작업 일정 : 2020.10.31\n 작업 시간 : 오전 5시 ~ 오전 6시\n 시스템 개선 작업이 종료될 때까지 일부 서비스가 제한될 수 있으니 이점 양해 부탁드립니다.',
        ),
        Divider(color: Colors.black54,),
        NoticeForm(
          title: '시스템 개선 작업 안내',
          date: '2020.10.09',
          text: '서버에 따른 시스템 정기 점검이 있습니다.\n 작업 일정 : 2020.10.31\n 작업 시간 : 오전 5시 ~ 오전 6시\n 시스템 개선 작업이 종료될 때까지 일부 서비스가 제한될 수 있으니 이점 양해 부탁드립니다.',
        ),
        Divider(color: Colors.black54,),
        NoticeForm(
          title: '시스템 개선 작업 안내',
          date: '2020.10.09',
          text: '서버에 따른 시스템 정기 점검이 있습니다.\n 작업 일정 : 2020.10.31\n 작업 시간 : 오전 5시 ~ 오전 6시\n 시스템 개선 작업이 종료될 때까지 일부 서비스가 제한될 수 있으니 이점 양해 부탁드립니다.',
        ),
      ],
    );
  }
}
