import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobispartsearch/bloc/notice_bloc.dart';

class NoticeForm extends StatefulWidget {
  final String title;
  final String date;
  final String text;
  NoticeForm({Key key, this.title, this.date, this.text}):super(key: key);
  @override
  _NoticeFormState createState() => _NoticeFormState();
}

class _NoticeFormState extends State<NoticeForm> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
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
        isExpanded ? Container(
          padding: EdgeInsets.all(15.0),
          child: Text(widget.text, style: TextStyle(fontSize: 14,),),
        ) : Container(),
      ],
    );
  }
}
