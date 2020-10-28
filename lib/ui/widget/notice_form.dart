import 'package:flutter/material.dart';

class NoticeForm extends StatefulWidget {
  final String title;
  final String date;
  final String text;
  NoticeForm({Key key, this.title, this.date, this.text}):super(key: key);
  @override
  _NoticeFormState createState() => _NoticeFormState();
}

class _NoticeFormState extends State<NoticeForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ListTile(
        title: Text(widget.title, style: TextStyle(fontSize: 14, color: Colors.black)),
        subtitle: Padding(padding: EdgeInsets.only(left: 8), child: Text(widget.date, style: TextStyle(fontSize: 10, color: Colors.black54),)),
        trailing: Icon(Icons.keyboard_arrow_down, color: Colors.black,),
        contentPadding: EdgeInsets.only(left: 8, right: 8),
        onTap: (){

        },
      ),
    );
  }
}
