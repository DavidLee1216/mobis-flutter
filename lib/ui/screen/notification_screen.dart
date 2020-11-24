import 'package:flutter/material.dart';
import 'package:mobispartsearch/ui/widget/notification_form.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.black),
          title: Text('알람'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  '알림을 통해서 구매 단계를 확인하세요.',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Divider(
                color: Colors.black54,
              ),
              Expanded(child: NotificationListWidget()),
            ],
          ),
        ));
  }
}

class NotificationListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        NotificationForm(
          title: '양 * * 고객님, 구매 요청 완료 알림이 있습니다.',
          date: '2020.10.09',
          count: 1,
          text:
              '플레이트 & 그로메트－에어컨 쿨러 라인 / 3개\n 강원부품(주) | 택배로 받기\n 양 ** / 010-1234-5678\n 배송지 서울시 강남구 **로 125',
          kind: NotificationKind.PURCHASE_REQUEST,
        ),
        Divider(
          color: Colors.black54,
        ),
        NotificationForm(
          title: '양 * * 고객님, 결제대기 알림이 있습니다.',
          date: '2020.10.09',
          count: 1,
          text:
              '플레이트 & 그로메트－에어컨 쿨러 라인 / 3개\n 강원부품(주) | 방문수령\n 양 ** / 010-1234-5678\n 수령예정일 10월 23일 9:30',
          kind: NotificationKind.PAYMENT_WAITING,
        ),
        Divider(
          color: Colors.black54,
        ),
        NotificationForm(
          title: '양 * * 고객님, 결제 완료 알림이 있습니다.',
          date: '2020.10.09',
          count: 1,
          text:
              '플레이트 & 그로메트－에어컨 쿨러 라인 / 3개\n 강원부품(주) | 방문수령\n 양 ** / 010-1234-5678\n수령예정일 10월 23일 9:30',
          kind: NotificationKind.PAYMENT_COMPLETE,
        ),
      ],
    );
  }
}
