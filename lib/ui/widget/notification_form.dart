import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobispartsearch/bloc/notice_bloc.dart';

enum NotificationKind{PURCHASE_REQUEST, PAYMENT_WAITING, PAYMENT_COMPLETE}

class NotificationForm extends StatefulWidget {
  final String title;
  final String date;
  final int count;
  final String text;
  final NotificationKind kind;
  NotificationForm({Key key, this.title, this.date, this.count, this.text, this.kind}):super(key: key);
  @override
  _NotificationFormState createState() => _NotificationFormState();
}

class _NotificationFormState extends State<NotificationForm> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {

    var paymentButton = Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonTheme(
            buttonColor: Color.fromRGBO(0, 63, 114, 1),
            child: RaisedButton(
              child: Text('결제하러 가기', style: TextStyle(fontSize: 12, color: Colors.white), textAlign: TextAlign.center,),
              onPressed: (){
//                Navigator.of(context).pushNamed('/purchase');
              },
            ),
          ),
        ],
      ),
    );

    var payCompleteMessage = Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('결제가 완료되었습니다.', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
        ],
      ),
    );

    var contentItem = Container(
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('주문 상품(${widget.count}개)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), ),
          SizedBox(height: 10,),
          Text(widget.text, style: TextStyle(fontSize: 14,),),
          if(widget.kind==NotificationKind.PAYMENT_WAITING) paymentButton
          else if(widget.kind==NotificationKind.PAYMENT_COMPLETE) payCompleteMessage
          else Container(),
        ],
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 50,
          child: ListTile(
            title: Text(widget.title, style: TextStyle(fontSize: 14, color: Colors.black)),
            subtitle: Padding(padding: EdgeInsets.only(left: 8), child: Text(widget.date, style: TextStyle(fontSize: 10, color: Colors.black54),)),
            trailing: isExpanded?Icon(Icons.keyboard_arrow_up, color: Colors.black,):Icon(Icons.keyboard_arrow_down, color: Colors.black,),
            contentPadding: EdgeInsets.only(left: 8, right: 8),
            onTap: (){
              isExpanded = !isExpanded;
              setState(() {
              });
            },
          ),
        ),
        isExpanded ? contentItem : Container(),
      ],
    );
  }
}
