import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobispartsearch/bloc/cart_bloc.dart';
import 'package:mobispartsearch/model/cart_model.dart';
import 'package:mobispartsearch/model/market_search_model.dart';
import 'package:mobispartsearch/ui/screen/cart_screen.dart';
import 'package:mobispartsearch/ui/screen/delivery_screen.dart';
import 'package:mobispartsearch/ui/screen/visit_screen.dart';
import 'package:mobispartsearch/ui/widget/custom_radio_button.dart';
import 'package:mobispartsearch/utils/navigation.dart';
import 'package:mobispartsearch/common.dart' as common;
import 'package:mobispartsearch/model/product_model.dart';

import 'loading_indication.dart';

class PurchaseRequestForm extends StatefulWidget {
  final String partNumber;
  final String koreanPartName;
  final String englishPartName;
  final int price;
  final MarketSearchResultModel result;

  const PurchaseRequestForm({
    Key key,
    this.partNumber,
    this.koreanPartName,
    this.englishPartName,
    this.price,
    this.result,
  }) : super(key: key);
  @override
  _PurchaseRequestFormState createState() => _PurchaseRequestFormState();
}

class _PurchaseRequestFormState extends State<PurchaseRequestForm> {
  int count = 1;
  List<RadioModel> optionData = new List<RadioModel>();
  CartBloc bloc;

  @override
  void initState() {
    super.initState();
    optionData.add(RadioModel(false, '', '택배로 받기'));
    optionData.add(RadioModel(false, '', '방문 수령'));
    bloc = BlocProvider.of<CartBloc>(context);
    bloc.add(InitCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<CartBloc>(context);

    var firstColumnWidth = MediaQuery.of(context).size.width * 0.3;
    var secondColumnWidth = MediaQuery.of(context).size.width * 0.6;
    var screenWidth = MediaQuery.of(context).size.width;

    void addToCart() {
      String deliveryCode = widget.result.stype == 'Y' ? 'P' : 'V';
      Product product = new Product(
          agentCode: widget.result.agentCode,
          sapCode: widget.result.sapCode != '' ? widget.result.sapCode : null,
          deliveryCode: deliveryCode,
          partNumber: widget.partNumber,
          username: common.globalUsername !='' ? common.globalUsername : null,
          session: common.session,
          count: count);
      bloc.add(AddCartEvent(product));
    }

//    Future<bool> orderNow() async {
//      DateTime timeNow = DateTime.now();
//      String deliveryCode = optionData[0].isSelected ? 'D' : 'P';
//      Product product = new Product(agentCode:widget.agentCode, deliveryCode:deliveryCode,
//          partNumber:widget.partNumber, username:common.globalUsername, session: common.session, count: count);
//      Order orderObject = new Order(
//          common.globalUser.username,
//          common.session,
//          common.globalUser.legalName,
//          common.globalUser.mobile,
//          common.globalUser.zipcode,
//          common.globalUser.addressExtended,
//          timeNow.toString(),
//          common.globalUser.address,
//          product);
//      if (await common.order(orderObject) == true) {
//        return true;
//      } else
//        return false;
//    }

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
                  fontSize: 13,
                  color: Color(0xff666666),
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Container(
              width: secondColumnWidth,
              padding: EdgeInsets.only(left: 10),
              child: Text(
                widget.partNumber ?? '',
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
                  fontSize: 13,
                  color: Color(0xff666666),
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
                  fontSize: 13,
                  color: Color(0xff666666),
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
                  fontSize: 13,
                  color: Color(0xff666666),
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
                    fontSize: 13,
                    color: Color(0xff666666),
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
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
                  fontSize: 13,
                  color: Color(0xff666666),
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Container(
              width: secondColumnWidth,
              padding: EdgeInsets.only(left: 10),
              child: Text(
                widget.result.mutual ?? '',
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
            height: 40,
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
                Padding(padding: const EdgeInsets.fromLTRB(0, 20, 0, 20)),
                Icon(
                  Icons.warning,
                  color: common.kPrimaryColor,
                  size: 15,
                ),
                Text(
                  '공백 특수기호 없이 특수문자만 입력하세요',
                  style: TextStyle(
                      fontFamily: 'HDharmony',
                      color: common.kPrimaryColor,
                      fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    var buyItem = Container(
      margin: EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: ButtonTheme(
//            padding: const EdgeInsets.fromLTRB(55, 15, 55, 15),
              buttonColor: common.kPrimaryColor,
              child: RaisedButton(
                child: Text(
                  '장바구니',
                  style: TextStyle(
                      fontFamily: 'HDharmony', fontSize: 15, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                onPressed: () async {
                  addToCart();
                },
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
//            padding: EdgeInsets.symmetric(vertical: 2.0),
              child: OutlineButton(
//              padding: const EdgeInsets.fromLTRB(55, 15, 55, 15),
                borderSide: BorderSide(
                  color: common.kPrimaryColor, //Color of the border
                  style: BorderStyle.solid, //Style of the border
                  width: 1, //width of the border
                ),
                child: Text(
                  '바로구매',
                  style: TextStyle(
                      fontFamily: 'HDharmony',
                      fontSize: 15,
                      color: common.kPrimaryColor),
                ),
                onPressed: () async {
                  CartModel cartItem = new CartModel(
                      mutual: widget.result.mutual,
                      deliveryCode: widget.result.stype == 'Y' ? 'P' : 'V',
                      price: widget.price,
                      krname: widget.koreanPartName,
                      enname: widget.englishPartName,
                      partNumber: widget.result.ptno,
                      count: count,
                      agentCode: widget.result.agentCode,
                      sapCode: widget.result.sapCode
                  );
                  if (optionData[0].isSelected) {
                    pushTo(
                        context,
                        DeliveryScreen(
                            item: cartItem,
                            count: count));
                  } else if (optionData[1].isSelected) {
                    pushTo(
                        context,
                        VisitScreen(
                            item: cartItem,
                            count: count));
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
    return BlocListener<CartBloc, CartState>(
        cubit: BlocProvider.of<CartBloc>(context),
        listener: (BuildContext context, state) {
          if (state.isAdded) {
            pushTo(
                context,
                CartScreen(
                ));
          } else if (state.errorMsg != '') {
            common.messageBox(state.errorMsg, context);
          }
        },
        child: BlocBuilder<CartBloc, CartState>(
            cubit: BlocProvider.of<CartBloc>(context),
            builder: (BuildContext context, state) {
              return Stack(
                children: [
                  Container(
                    child: Column(children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20.0, 30.0, 10.0, 20.0),
                        child: Text(
                          '차량부품 특성상 임의로 부품을 교체할 경우 문제가 발생할 수 있으므로 부품 구입 전 정확한 부품번호를 확인하시기 바랍니다.',
                          style: TextStyle(
                            fontFamily: 'HDharmony',
                            fontSize: 18,
                            color: Color(0xff666666),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Divider(
                        color: Colors.black54,
                        thickness: 1,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
                        child: Column(
                          children: [
                            partNumberItem,
                            koreanPartNameItem,
                            englishPartNameItem,
                            priceItem,
                            companyMarkItem,
                            ticketItem,
                            optionItem,
                            Divider(
                              color: Colors.black54,
                              thickness: 1,
                            ),
                            buyItem,
                          ],
                        ),
                      )
                    ]),
                  ),
                  Positioned(
                    child: LoadingIndicator(isLoading: state.isLoading),
                  ),
                ],
              );
            }));
  }
}
