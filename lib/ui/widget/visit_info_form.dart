import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hyundai_mobis/ui/widget/custom_selection_button.dart';
import 'package:hyundai_mobis/ui/widget/box_text_field.dart';

class VisitInfoForm extends StatefulWidget {
  final productName;
  final companyMark;
  final count;

  const VisitInfoForm({Key key, this.productName, this.companyMark, this.count})
      : super(key: key);
  @override
  _VisitInfoFormState createState() => _VisitInfoFormState();
}

class _VisitInfoFormState extends State<VisitInfoForm> {
  var time = '9:30';
  var phoneCode = '010';

  var _phoneNumber1Controller = TextEditingController();
  var _phoneNumber2Controller = TextEditingController();

  var buyerController = TextEditingController();

  List<SelectionButtonModel> selectionDateData =
      new List<SelectionButtonModel>();

  @override
  void initState() {
    super.initState();
    var today = new DateTime.now();
    var tomorrow = today.add(
      Duration(days: 1),
    );
    var twoDaysFromNow = today.add(
      Duration(days: 2),
    );
    var threeDaysFromNow = today.add(
      Duration(days: 3),
    );
    String todayString = '${today.month}월 ${today.day}일';
    String tomorrowString = '${tomorrow.month}월 ${tomorrow.day}일';
    String twoDaysFromNowString =
        '${twoDaysFromNow.month}월 ${twoDaysFromNow.day}일';
    String threeDaysFromNowString =
        '${threeDaysFromNow.month}월 ${threeDaysFromNow.day}일';

    selectionDateData.add(SelectionButtonModel(false, todayString));
    selectionDateData.add(SelectionButtonModel(false, tomorrowString));
    selectionDateData.add(SelectionButtonModel(false, twoDaysFromNowString));
    selectionDateData.add(SelectionButtonModel(false, threeDaysFromNowString));
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    var productInfoItem = Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              '주문 상품(1개)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              '${widget.productName} / ${widget.count}개',
              style: TextStyle(fontSize: 14),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              '${widget.companyMark} | 방문수령',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );

    var phoneCodes = ['010', '011', '012'];

    var times = List.generate(48, (index) {
      String t = (index % 2 == 0) ? '${index ~/ 2}' : '${index ~/ 2}:30';
      return t;
    });

    var phoneCodeDropdownmenu = Container(
        width: (screenWidth - 60) / 3,
        height: 30,
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: phoneCode,
            icon: Icon(Icons.keyboard_arrow_down),
            iconSize: 14,
            onChanged: (String newValue) {
              setState(() {
                phoneCode = newValue;
              });
            },
            items: phoneCodes.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Container(
                  width: 60,
                  child: Text(
                    value,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  alignment: Alignment.center,
                ),
              );
            }).toList(),
          ),
        ));

    var phoneNumberItem = Container(
      height: 30,
      width: (screenWidth - 60) * 2 / 3 + 10,
      margin: EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Container(
            width: (screenWidth - 60) / 3,
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                contentPadding: EdgeInsets.only(left: 10),
              ),
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: 14.0,
              ),
              textAlign: TextAlign.left,
              controller: _phoneNumber1Controller,
            ),
          ),
          Expanded(
              child: SizedBox(
            width: 10,
          )),
          Container(
            width: (screenWidth - 60) / 3,
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                contentPadding: EdgeInsets.only(left: 10),
              ),
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: 14.0,
              ),
              textAlign: TextAlign.left,
              controller: _phoneNumber2Controller,
            ),
          ),
        ],
      ),
    );

    var phoneItem = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                '휴대폰 번호',
                style: TextStyle(
                  fontSize: 14,
                ),
              )),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              phoneCodeDropdownmenu,
              phoneNumberItem,
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );

    var timeSelectionDropdownItem = Container(
        width: (screenWidth - 60) / 3,
        height: 30,
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: time,
            icon: Icon(Icons.keyboard_arrow_down),
            iconSize: 14,
            onChanged: (String newValue) {
              setState(() {
                time = newValue;
              });
            },
            items: times.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Container(
                  width: 60,
                  child: Text(
                    value,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  alignment: Alignment.center,
                ),
              );
            }).toList(),
          ),
        ));

    var timeSelectionItem = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20),
              child: Text(
            '시간대 선택',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: timeSelectionDropdownItem,
          ),
        ],
      ),
    );

    var visitDateItem = Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonTheme(
                  minWidth: 0,
                  height: 0,
                  child: FlatButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    child: SelectionButtonItem(
                        selectionDateData[0], screenWidth * 0.4, 40),
                    onPressed: () {
                      setState(() {
//                        selectionDateData
//                            .forEach((element) => element.isSelected = false);
                        selectionDateData[0].isSelected =
                            !selectionDateData[0].isSelected;
                      });
                    },
                  ),
                ),
                Expanded(
                    child: SizedBox(
                  width: 50,
                )),
                ButtonTheme(
                  minWidth: 0,
                  height: 0,
                  child: FlatButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    child: SelectionButtonItem(
                        selectionDateData[1], screenWidth * 0.4, 40),
                    onPressed: () {
                      setState(() {
//                        selectionDateData
//                            .forEach((element) => element.isSelected = false);
                        selectionDateData[1].isSelected =
                            !selectionDateData[1].isSelected;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonTheme(
                  minWidth: 0,
                  height: 0,
                  child: FlatButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    child: SelectionButtonItem(
                        selectionDateData[2], screenWidth * 0.4, 40),
                    onPressed: () {
                      setState(() {
//                        selectionDateData
//                            .forEach((element) => element.isSelected = false);
                        selectionDateData[2].isSelected =
                            !selectionDateData[2].isSelected;
                      });
                    },
                  ),
                ),
                Expanded(
                    child: SizedBox(
                  width: 50,
                )),
                ButtonTheme(
                  minWidth: 0,
                  height: 0,
                  child: FlatButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    child: SelectionButtonItem(
                        selectionDateData[3], screenWidth * 0.4, 40),
                    onPressed: () {
                      setState(() {
//                        selectionDateData
//                            .forEach((element) => element.isSelected = false);
                        selectionDateData[3].isSelected =
                            !selectionDateData[3].isSelected;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    var visitInfoItem = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          visitDateItem,
          SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.black54,
          ),
          timeSelectionItem,
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );

    var buyerInfoItem = Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '구매자 정보',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '수령인',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                contentPadding: EdgeInsets.only(left: 10),
              ),
              controller: buyerController,
              style: TextStyle(
                fontSize: 14,
              ),
              keyboardType: TextInputType.text,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          phoneItem,
        ],
      ),
    );

    var buyItem = Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonTheme(
            buttonColor: Color.fromRGBO(0, 63, 114, 1),
            child: RaisedButton(
              child: Text('구매요청', style: TextStyle(fontSize: 12, color: Colors.white), textAlign: TextAlign.center,),
              onPressed: (){
//                Navigator.of(context).pushNamed('/purchase');
              },
            ),
          ),
        ],
      ),
    );

    return ListView(
      children: [
        productInfoItem,
        Divider(
          color: Colors.black54,
        ),
        visitInfoItem,
        Divider(
          color: Colors.black54,
        ),
        buyerInfoItem,
        Divider(
          color: Colors.black54,
        ),
        buyItem,
      ],
    );
  }
}
