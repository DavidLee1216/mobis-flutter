import 'package:flutter/material.dart';

enum NotificationKind { PURCHASE_REQUEST, PAYMENT_WAITING, PAYMENT_COMPLETE }

class NotificationForm extends StatefulWidget {
  final String title;
  final String date;
  final int count;
  final String orderDetail;
  final String text;
  final NotificationKind kind;
  NotificationForm(
      {Key key,
      this.title,
      this.date,
      this.count,
      this.orderDetail,
      this.text,
      this.kind})
      : super(key: key);
  @override
  _NotificationFormState createState() => _NotificationFormState();
}

class _NotificationFormState extends State<NotificationForm> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    var paymentButton = Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonTheme(
            minWidth: MediaQuery.of(context).size.width / 1.25,
            buttonColor: Color.fromRGBO(0, 63, 114, 1),
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
            child: RaisedButton(
              child: Text(
                '결제하러 가기',
                style: TextStyle(
                    fontFamily: 'HDharmony', fontSize: 14, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              onPressed: () {
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
          Text(
            '결제가 완료되었습니다.',
            style: TextStyle(
                fontFamily: 'HDharmony',
                fontSize: 14,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );

    var contentItem = Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '주문 상품(${widget.count}개)',
            style: TextStyle(
                fontFamily: 'HDharmony',
                fontSize: 15,
                color: const Color(0xFF074B88),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.orderDetail,
            style: TextStyle(
              fontFamily: 'HDharmony',
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.text,
            style: TextStyle(
              fontFamily: 'HDharmony',
              fontSize: 13,
              color: Color(0xff666666),
            ),
          ),
          if (widget.kind == NotificationKind.PAYMENT_WAITING)
            paymentButton
          else if (widget.kind == NotificationKind.PAYMENT_COMPLETE)
            payCompleteMessage
          else
            Container(),
        ],
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 50,
          child: ListTile(
            title: Text(widget.title,
                style: TextStyle(
                    fontFamily: 'HDharmony',
                    fontSize: 14,
                    color: Colors.black)),
            subtitle: Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  widget.date,
                  style: TextStyle(
                      fontFamily: 'HDharmony',
                      fontSize: 12,
                      color: Colors.black54),
                )),
            trailing: isExpanded
                ? Icon(
                    Icons.keyboard_arrow_up,
                    color: Colors.black,
                    size: 30,
                  )
                : Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.black,
                    size: 30,
                  ),
            contentPadding: EdgeInsets.only(left: 8, right: 8),
            onTap: () {
              isExpanded = !isExpanded;
              setState(() {});
            },
          ),
        ),
        isExpanded ? contentItem : Container(),
      ],
    );
  }
}
