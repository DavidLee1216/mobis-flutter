import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kopo/kopo.dart';
import 'package:mobispartsearch/common.dart';
import 'package:mobispartsearch/model/cart_model.dart';

import '../../app_config.dart';

class DeliveryInfoForm extends StatefulWidget {
  final CartModel item;
  final count;

  const DeliveryInfoForm(
      {Key key, this.item, this.count})
      : super(key: key);

  @override
  _DeliveryInfoFormState createState() => _DeliveryInfoFormState();
}

class _DeliveryInfoFormState extends State<DeliveryInfoForm> {
  var addressController = TextEditingController(text: globalUsername != '' ? globalUser.zipcode : '');

  var addressController2 = TextEditingController(text: globalUsername != '' ? globalUser.address : '');

  var addressController3 = TextEditingController(text: globalUsername != '' ? globalUser.addressExtended : '');

  var buyerController = TextEditingController(text: globalUsername);
  
  var _phoneNumber1Controller = TextEditingController();
  var _phoneNumber2Controller = TextEditingController();

  var phoneCode = '010';

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    var phoneCodes = ['010', '011', '012'];

    var phoneCodeDropdownmenu = Container(
        width: (screenWidth - 60) / 3,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
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
                      fontFamily: 'HDharmony',
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
      height: 40,
      width: (screenWidth - 60) * 2 / 3 + 10,
      margin: EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Container(
            width: (screenWidth - 60) / 3,
            child: TextFormField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(4),
                ],
                decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: BorderSide(color: Colors.redAccent, width: 1),
                ),
                contentPadding: EdgeInsets.only(left: 10),
              ),
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontFamily: 'HDharmony',
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
            child: TextFormField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(4),
              ],
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: BorderSide(color: Colors.redAccent, width: 1),
                ),
                contentPadding: EdgeInsets.only(left: 10),
              ),
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontFamily: 'HDharmony',
                fontSize: 14.0,
              ),
              textAlign: TextAlign.left,
              controller: _phoneNumber2Controller,
            ),
          ),
        ],
      ),
    );

    var productInfoItem = Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              '주문 상품(1개)',
              style: TextStyle(
                  fontFamily: 'HDharmony',
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              '${widget.item.krname} / ${widget.count}개',
              style: TextStyle(fontFamily: 'HDharmony', fontSize: 14),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              '${widget.item.mutual} | ',
              style: TextStyle(
                fontFamily: 'HDharmony',
                fontSize: 14,
              ),
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
                    fontFamily: 'HDharmony',
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
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

    var deliveryInfoItem = Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '배송지 정보',
              style: TextStyle(
                  fontFamily: 'HDharmony',
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '주소',
              style: TextStyle(
                  fontFamily: 'HDharmony',
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: screenWidth * 0.6,
                    height: 40,
                    child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                        contentPadding: EdgeInsets.only(left: 10),
                      ),
                      controller: addressController,
                      style: TextStyle(
                        fontFamily: 'HDharmony',
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width * 0.3,
                  height: 40,
                  child: OutlineButton(
                    padding: EdgeInsets.only(left: 8.0),
                    borderSide: BorderSide(
                      color: kPrimaryColor,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(
                          color: kPrimaryColor,
                          width: 1.0,
                          style: BorderStyle.solid),
                    ),
                    child: Text('우편번호 검색',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'HDharmony',
                          color: kPrimaryColor,
                        )),
                    onPressed: () async {
                      KopoModel kopoModel = await Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => Kopo(),
                        ),
                      );
                      if(kopoModel != null){
                        setState(() {
                          addressController.text = kopoModel.zonecode;
                          addressController2.text = kopoModel.address;
                        });
                      }
                    },
                  ),
                ),
              ],
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
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  contentPadding: EdgeInsets.only(left: 10),
                ),
                controller: addressController2,
                style: TextStyle(fontFamily: 'HDharmony', fontSize: 14),
                keyboardType: TextInputType.text,
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
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  hintText: '상세주소',
                  contentPadding: EdgeInsets.only(left: 10),
                ),
                controller: addressController3,
                style: TextStyle(fontFamily: 'HDharmony', fontSize: 14),
                keyboardType: TextInputType.text,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '수령인',
              style: TextStyle(
                  fontFamily: 'HDharmony',
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
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
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  contentPadding: EdgeInsets.only(left: 10),
                ),
                controller: buyerController,
                style: TextStyle(
                  fontFamily: 'HDharmony',
                  fontSize: 14,
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            phoneItem,
          ],
        ));

    var buyItem = Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonTheme(
            buttonColor: kPrimaryColor,
            child: RaisedButton(
              child: Text(
                '구매요청',
                style: TextStyle(
                    fontFamily: 'HDharmony', fontSize: 12, color: Colors.white),
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

    return ListView(
      children: [
        productInfoItem,
        Divider(
          color: Colors.black54,
        ),
        deliveryInfoItem,
        Divider(
          color: Colors.black54,
        ),
        buyItem,
      ],
    );
  }
}
