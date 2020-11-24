import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobispartsearch/bloc/market_search_bloc.dart';
import 'package:mobispartsearch/bloc/notice_bloc.dart';
import 'package:mobispartsearch/ui/screen/home_screen.dart';
import 'package:mobispartsearch/ui/screen/purchase_request_screen.dart';
import 'package:mobispartsearch/utils/navigation.dart';

class MarketSearchResultsForm extends StatefulWidget {
  @override
  _MarketSearchResultsFormState createState() =>
      _MarketSearchResultsFormState();
}

class _MarketSearchResultsFormState extends State<MarketSearchResultsForm> {
  @override
  Widget build(BuildContext context) {
    var bloc  = BlocProvider.of<MarketSearchBloc>(context);
    return BlocBuilder<MarketSearchBloc, MarketSearchState>(
      cubit: BlocProvider.of<MarketSearchBloc>(context),
      builder: (BuildContext context, state) {
        return Container(
            child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                  color: Colors.black26,
                  width: 1,
                  ),
                ),
                child: Column(
                children: [
                  Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    state.kr_name+'(${state.en_name})',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.left,
                  )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "-${state.price}원(부가세 포함)",
                      style: TextStyle(fontSize: 14, color: Colors.black),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ListView.builder(itemBuilder: (BuildContext context, int index){
              return Column(
                children: [
                  MarketSearchResultForm(
                    companyMark:state.searchResult[index].mutual,
                    canDelivery: state.searchResult[index].stype=='Y'? true : false,
                    address1: state.searchResult[index].sido,
                    address2: state.searchResult[index].sigungu,
                    phoneNumber: state.searchResult[index].tel,
                    canSale: state.searchResult[index].stype=='Y'? true : false,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              );
            }),
//            MarketSearchResultForm(
//              companyMark: '강원부품(주)',
//              canDelivery: true,
//              address1: '강원도 원주시 현충로 255',
//              address2: '강원도 원주시 현충로 255',
//              phoneNumber: '033-743-1850',
//              canSale: true,
//            ),
//            SizedBox(
//              height: 10,
//            ),
//            MarketSearchResultForm(
//              companyMark: '강원부품(주)',
//              canDelivery: false,
//              address1: '강원도 원주시 현충로 255',
//              address2: '강원도 원주시 현충로 255',
//              phoneNumber: '033-743-1850',
//              canSale: true,
//            ),
//            SizedBox(
//              height: 10,
//            ),
//            MarketSearchResultForm(
//              companyMark: '강원부품(주)',
//              canDelivery: false,
//              address1: '강원도 원주시 현충로 255',
//              address2: '강원도 원주시 현충로 255',
//              phoneNumber: '033-743-1850',
//              canSale: true,
//            ),
//            SizedBox(
//              height: 10,
//            ),
//            MarketSearchResultForm(
//              companyMark: '강원부품(주)',
//              canDelivery: false,
//              address1: '강원도 원주시 현충로 255',
//              address2: '강원도 원주시 현충로 255',
//              phoneNumber: '033-743-1850',
//              canSale: false,
//            ),
//            SizedBox(
//              height: 10,
//            ),
            Container(
              child: Center(
                child: ListView.builder(itemBuilder: (BuildContext, index){
                  return Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        GestureDetector(
                          child: Container(
                            height: 20.0,
                            width: 20.0,
                            child: new Center(
                              child: new Text(state.pageModel.pages[index].toString(),
                                  style: new TextStyle(
                                      color:
                                      state.pageModel.pages[index]==state.pageModel.curr_page ? Colors.white : Colors.black54,
                                      //fontWeight: FontWeight.bold,
                                      fontSize: 8.0)),
                            ),
                            decoration: new BoxDecoration(
                              color: state.pageModel.pages[index]==state.pageModel.curr_page
                                  ? Colors.black54
                                  : Colors.transparent,
                              border: new Border.all(
                                  width: 1.0,
                                  color: state.pageModel.pages[index]==state.pageModel.curr_page
                                      ? Colors.black54
                                      : Colors.grey),
                              borderRadius: const BorderRadius.all(const Radius.circular(1.0)),
                            ),
                          ),
                          onTap: (){
                            bloc.add(SearchMarketSearchEvent(state.ptno, state.sido, state.sigungu, state.pageModel.pages[index]));
                          },
                        ),
                        SizedBox(width: 5,),
                      ],
                    ),
                  );
                }),),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      );
  }
    );
  }
}

class MarketSearchResultForm extends StatefulWidget {
  final String companyMark;
  final bool canDelivery;
  final String address1;
  final String address2;
  final String phoneNumber;
  bool canSale = true;
  MarketSearchResultForm({
    Key key,
    this.companyMark,
    this.canDelivery,
    this.address1,
    this.address2,
    this.phoneNumber,
    this.canSale,
  }) : super(key: key);
  @override
  _MarketSearchResultFormState createState() => _MarketSearchResultFormState();
}

class _MarketSearchResultFormState extends State<MarketSearchResultForm> {
  @override
  Widget build(BuildContext context) {
    var ScreenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Table(
              columnWidths: {
                0: FixedColumnWidth(ScreenWidth * 0.28),
                1: FixedColumnWidth(ScreenWidth * 0.68),
              },
              border: TableBorder.all(width: 1.0, color: Colors.black26),
              children: [
                TableRow(children: [
                  TableCell(
                    child: SizedBox(
                      height: 30,
                      child: Center(
                        child: Text(
                          '상호명',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: SizedBox(
                      height: 30,
                      width: ScreenWidth * 0.68,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  widget.companyMark,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            widget.canDelivery
                                ? Container(
                                    padding: EdgeInsets.only(left: 50),
                                    child: Text(
                                      '택배주문가능',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.indigo),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  )
                ]),
                TableRow(children: [
                  TableCell(
                    child: SizedBox(
                      height: 60,
                      child: Center(
                        child: Text(
                          '주소',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      height: 60,
                      padding: EdgeInsets.only(left: 10),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.address1,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              widget.address2,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ]),
                TableRow(children: [
                  TableCell(
                    child: SizedBox(
                      height: 30,
                      child: Center(
                        child: Text(
                          '전화번호',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      width: ScreenWidth * 0.68,
                      height: 30,
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 30,
                              padding: EdgeInsets.only(left: 10),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.phoneNumber,
                                style: TextStyle(fontSize: 12, color: Colors.black),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                          SizedBox(width: 50,),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 2.0),
                            child: OutlineButton(
                              borderSide: BorderSide(
                                color: kPrimaryColor, //Color of the border
                                style: BorderStyle.solid, //Style of the border
                                width: 1, //width of the border
                              ),
                              child: Text('지도보기', style: TextStyle(fontSize: 12, color: Colors.indigo),),
                              onPressed: (){

                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ]),
              ],
            )),
          Container(
            padding: EdgeInsets.symmetric(horizontal:10.0),
            child: Container(
              width: ScreenWidth * 0.96,
              padding: EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black26,
                  width: 1,
                ),
              ),
              child: Center(
                child: widget.canSale?Container(
                    width: ScreenWidth*0.25,
                    height: 25,
                    child: RaisedButton(
                      child: Text('구매요청', style: TextStyle(fontSize: 12, color: Colors.white),),
                      color: kPrimaryColor,
                      onPressed: (){
                        pushTo(context, PurchaseRequestScreen(partNumber:'97651B2000', koreanPartName:'플레이트 & 그로메트－에어컨 쿨러 라인',
                            englishPartName: 'PLATE & GROMMET-A/C COOLER LIN', price:1870, companyMark:'강원부품(주)'));
                      },
                    )):
                    Container(
                      child: Text('해당 판매점은 전화로 직접 문의 부탁드립니다.', style: TextStyle(fontSize: 12,),),
                    )
                ),
            ),
          ),
      ],
    );
  }
}
