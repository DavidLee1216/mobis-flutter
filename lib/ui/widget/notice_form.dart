import 'package:flutter/material.dart';

class NoticeForm extends StatefulWidget {
  final String title;
  final String date;
  final String text;
  NoticeForm({Key key, this.title, this.date, this.text}) : super(key: key);
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListTile(
            title: Text(widget.title,
                style: TextStyle(
                    fontFamily: 'HDharmony',
                    fontWeight:
                        isExpanded ? FontWeight.bold : FontWeight.normal,
                    color: Colors.black)),
            subtitle: Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  widget.date,
                  style: TextStyle(
                      fontFamily: 'HDharmony',
                      fontSize: 10,
                      color: Colors.black54),
                )),
            trailing: isExpanded
                ? Icon(
                    Icons.keyboard_arrow_up,
                    color: Colors.black,
                    size: 25,
                  )
                : Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.black,
                    size: 25,
                  ),
            contentPadding: EdgeInsets.only(left: 8, right: 8),
            onTap: () {
              isExpanded = !isExpanded;
              setState(() {});
            },
          ),
        ),
        isExpanded
            ? Container(
                padding: EdgeInsets.fromLTRB(30, 15.0, 0, 0),
                child: Text(
                  widget.text,
                  style: TextStyle(
                    fontFamily: 'HDharmony',
                    fontSize: 14,
                  ),
                ),
                alignment: Alignment.centerLeft,
              )
            : Container(),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
          child: Divider(
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
