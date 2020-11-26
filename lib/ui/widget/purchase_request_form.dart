import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobispartsearch/bloc/cart_bloc.dart';
import 'package:mobispartsearch/model/order_model.dart';
import 'package:mobispartsearch/ui/screen/cart_screen.dart';
import 'package:mobispartsearch/ui/screen/delivery_screen.dart';
import 'package:mobispartsearch/ui/screen/visit_screen.dart';
import 'package:mobispartsearch/ui/widget/custom_radio_button.dart';
import 'package:mobispartsearch/utils/navigation.dart';
import 'package:mobispartsearch/common.dart';
import 'package:mobispartsearch/model/product_model.dart';

class PurchaseRequestForm extends StatefulWidget {
  final String partNumber;
  final String koreanPartName;
  final String englishPartName;
  final int price;
  final String companyMark;
  final String agentCode;

  const PurchaseRequestForm(
      {Key key,
      this.partNumber,
      this.koreanPartName,
      this.englishPartName,
      this.price,
      this.companyMark,
      this.agentCode})
      : super(key: key);
  @override
  _PurchaseRequestFormState createState() => _PurchaseRequestFormState();
}

class _PurchaseRequestFormState extends State<PurchaseRequestForm> {
  int count = 1;
  List<RadioModel> optionData = new List<RadioModel>();

  @override
  void initState() {
    super.initState();
    optionData.add(RadioModel(false, '', '택배로 받기'));
    optionData.add(RadioModel(false, '', '방문 수령'));
  }

  @override
  Widget build(BuildContext context) {
    final CartBloc bloc = BlocProvider.of<CartBloc>(context);

    var firstColumnWidth = MediaQuery.of(context).size.width * 0.3;
    var secondColumnWidth = MediaQuery.of(context).size.width * 0.6;
    var screenWidth = MediaQuery.of(context).size.width;

    Future<void> addToCart() async {
      String deliveryCode = optionData[0].isSelected ? 'P' : 'V';
      Product product = new Product(widget.agentCode, deliveryCode,
          widget.partNumber, globalUsername, count);
      bloc.add(AddCartEvent(product));
    }

    Future<bool> orderNow() async {
      DateTime timeNow = DateTime.now();
      String deliveryCode = optionData[0].isSelected ? 'D' : 'P';
      Product product = new Product(widget.agentCode, deliveryCode,
          widget.partNumber, globalUsername, count);
      Order orderObject = new Order(
          globalUser.username,
          globalUser.legalName,
          globalUser.mobile,
          globalUser.zipcode,
          globalUser.addressExtended,
          timeNow.toString(),
          globalUser.address,
          product);
      if (await order(orderObject) == true) {
        return true;
      } else
        return false;
    }

    var partNumberItem = Container(
//      padding: EdgeInsets.all(10.0),
      child: Row(
        children: [
          Container(
            color: Color(0xffccccc),
            width: firstColumnWidth,
            child: Text(
              '부품 번호',
              style: TextStyle(
                  fontFamily: 'HDharmony',
                  fontSize: 12,
                  color: Color(0xff66666),
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Container(
              width: secondColumnWidth,
              padding: EdgeInsets.only(left: 10),
              child: Text(
                widget.partNumber,
                style: TextStyle(
                  fontFamily: 'HDharmony',
                  fontSize: 12,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ],
      ),
    );

    var koreanPartNameItem = Container(
//      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          Container(
            width: firstColumnWidth,
            child: Text(
              '한글 부품명',
              style: TextStyle(
                  fontFamily: 'HDharmony',
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Container(
              width: secondColumnWidth,
              padding: EdgeInsets.only(left: 10),
              child: Text(
                widget.koreanPartName,
                style: TextStyle(
                  fontFamily: 'HDharmony',
                  fontSize: 12,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ],
      ),
    );

    var englishPartNameItem = Container(
//      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          Container(
            width: firstColumnWidth,
            child: Text(
              '영어 부품명',
              style: TextStyle(
                  fontFamily: 'HDharmony',
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Container(
              width: secondColumnWidth,
              padding: EdgeInsets.only(left: 10),
              child: Text(
                widget.englishPartName,
                style: TextStyle(
                  fontFamily: 'HDharmony',
                  fontSize: 12,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ],
      ),
    );

    var priceItem = Container(
//      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          Container(
            width: firstColumnWidth,
            child: Text(
              '가격(부가세포함)',
              style: TextStyle(
                  fontFamily: 'HDharmony',
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Container(
              width: secondColumnWidth,
              padding: EdgeInsets.only(left: 10),
              child: Text(
                widget.price.toString() + "원",
                style: TextStyle(
                  fontFamily: 'HDharmony',
                  fontSize: 12,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ],
      ),
    );

    var companyMarkItem = Container(
//      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          Container(
            width: firstColumnWidth,
            child: Text(
              '판매점 상호명',
              style: TextStyle(
                  fontFamily: 'HDharmony',
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Container(
              width: secondColumnWidth,
              padding: EdgeInsets.only(left: 10),
              child: Text(
                widget.companyMark,
                style: TextStyle(
                  fontFamily: 'HDharmony',
                  fontSize: 12,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ],
      ),
    );

    var totalPrice = widget.price * count;

    var ticketItem = Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          Container(
            width: screenWidth * 0.96,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
            child: Row(children: [
              Container(
                child: IconButton(
                  icon: Icon(Icons.remove_circle),
                  color: Colors.black26,
                  onPressed: () {
                    setState(() {
                      if (count > 1) count--;
                    });
                  },
                ),
              ),
              Container(
//                  width: 12,
//                  height: 12,
                  child: Text(
                count.toString(),
                style: TextStyle(
                    fontFamily: 'HDharmony', fontSize: 12, color: Colors.black),
              )),
              Container(
                child: IconButton(
                  icon: Icon(Icons.add_circle),
                  color: Colors.black26,
                  onPressed: () {
                    setState(() {
                      count++;
                    });
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Text(
                  totalPrice.toString() + "원",
                  style: TextStyle(fontFamily: 'HDharmony', fontSize: 12),
                ),
              )
            ]),
          ),
          Container(
            width: screenWidth * 0.96,
            padding: EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
            child: Row(children: [
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  '총 수량  ',
                  style: TextStyle(
                      fontFamily: 'HDharmony',
                      fontSize: 14,
                      color: Colors.black),
                ),
              ),
              Text(
                count.toString(),
                style: TextStyle(
                    fontFamily: 'HDharmony', fontSize: 14, color: Colors.red),
              ),
              Text(
                '개',
                style: TextStyle(
                    fontFamily: 'HDharmony', fontSize: 14, color: Colors.black),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Row(
                    children: [
                      Text(
                        '총 금액   ',
                        style: TextStyle(
                            fontFamily: 'HDharmony',
                            fontSize: 14,
                            color: Colors.black),
                      ),
                      Text(
                        totalPrice.toString() + " 원",
                        style: TextStyle(
                            fontFamily: 'HDharmony',
                            fontSize: 14,
                            color: Colors.red),
                      ),
                    ],
                  ))
            ]),
          ),
        ],
      ),
    );

    var optionItem = Container(
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
                    child: RadioItem(optionData[0]),
                    onPressed: () {
                      setState(() {
                        optionData
                            .forEach((element) => element.isSelected = false);
                        optionData[0].isSelected = true;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                ButtonTheme(
                  minWidth: 0,
                  height: 0,
                  child: FlatButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    child: RadioItem(optionData[1]),
                    onPressed: () {
                      setState(() {
                        optionData
                            .forEach((element) => element.isSelected = false);
                        optionData[1].isSelected = true;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning,
                  color: kPrimaryColor,
                ),
                Text(
                  '공백 특수기호 없이 특수문자만 입력하세요',
                  style: TextStyle(
                      fontFamily: 'HDharmony',
                      color: kPrimaryColor,
                      fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    var buyItem = Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonTheme(
            buttonColor: kPrimaryColor,
            child: RaisedButton(
              child: Text(
                '장바구니',
                style: TextStyle(
                    fontFamily: 'HDharmony', fontSize: 12, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              onPressed: () async {
                if (optionData[0].isSelected == false &&
                    optionData[1].isSelected == false) return;
                bool kind = optionData[0].isSelected ? true : false;
//                await addToCart();
                pushTo(
                    context,
                    CartScreen(
                      deliveryKind: kind,
                    ));
              },
            ),
          ),
          SizedBox(
            width: 50,
          ),
          Container(
//            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: OutlineButton(
              borderSide: BorderSide(
                color: kPrimaryColor, //Color of the border
                style: BorderStyle.solid, //Style of the border
                width: 1, //width of the border
              ),
              child: Text(
                '바로구매',
                style: TextStyle(
                    fontFamily: 'HDharmony',
                    fontSize: 12,
                    color: kPrimaryColor),
              ),
              onPressed: () async {
                if (optionData[0].isSelected) {
                  pushTo(
                      context,
                      DeliveryScreen(
                          productName: "플레이트 & 그로메트 - 에이컨 쿨러 라인",
                          companyMark: "강원부품(주)",
                          count: count));
                } else if (optionData[1].isSelected) {
                  pushTo(
                      context,
                      VisitScreen(
                          productName: "플레이트 & 그로메트 - 에이컨 쿨러 라인",
                          companyMark: "강원부품(주)",
                          count: count));
                }
              },
            ),
          )
        ],
      ),
    );

    return Container(
      child: Column(
        children: [
          Container(
            width: screenWidth * 0.7,
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: Text(
              '차량부품 특성상 임의로 부품을 교체할 경우 문제가 발생할 수 있으므로 부품 구입 전 정확한 부품번호를 확인하시기 바랍니다.',
              style: TextStyle(
                fontFamily: 'HDharmony',
                fontSize: 12,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                partNumberItem,
                koreanPartNameItem,
                englishPartNameItem,
                priceItem,
                companyMarkItem,
                ticketItem,
                optionItem,
                buyItem,
              ],
            ),
          )
        ],
      ),
    );
  }
}
