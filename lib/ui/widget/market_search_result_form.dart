import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobispartsearch/bloc/market_search_bloc.dart';
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
    var bloc = BlocProvider.of<MarketSearchBloc>(context);
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
                            state.krname + '(${state.enname})',
                            style: TextStyle(
                              fontFamily: 'HDharmony',
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
                          style: TextStyle(
                              fontFamily: 'HDharmony',
                              fontSize: 14,
                              color: Colors.black),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                MarketSearchResultListWidget(),
                SizedBox(
                  height: 10,
                ),
                MarketSearchPageListWidget(),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        });
  }
}

class MarketSearchResultListWidget extends StatefulWidget {
  @override
  _MarketSearchResultListWidgetState createState() =>
      _MarketSearchResultListWidgetState();
}

class _MarketSearchResultListWidgetState
    extends State<MarketSearchResultListWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MarketSearchBloc, MarketSearchState>(
        cubit: BlocProvider.of<MarketSearchBloc>(context),
        builder: (BuildContext context, state) {
          if (state.searchResult == null || state.searchResult.length == 0) {
            return Container();
          }
          return ListView.builder(
              itemCount: state.searchResult.length,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    MarketSearchResultForm(
                      companyMark: state.searchResult[index].mutual,
                      canDelivery: state.searchResult[index].stype == 'Y',
                      address1: state.searchResult[index].sido,
                      address2: state.searchResult[index].sigungu,
                      phoneNumber: state.searchResult[index].tel,
                      canSale: state.searchResult[index].stype == 'Y',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                );
              });
        });
  }
}

class MarketSearchPageListWidget extends StatefulWidget {
  @override
  _MarketSearchPageListWidgetState createState() =>
      _MarketSearchPageListWidgetState();
}

class _MarketSearchPageListWidgetState
    extends State<MarketSearchPageListWidget> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MarketSearchBloc>(context);
    return BlocBuilder<MarketSearchBloc, MarketSearchState>(
        cubit: BlocProvider.of<MarketSearchBloc>(context),
        builder: (BuildContext context, state) {
          if (state.pageModel == null || state.pageModel.pageCnt == null) {
            return Container();
          }
          return Container(
            height: 40,
            child: ListView.builder(
                itemCount: state.pageModel.pages.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  return state.pageModel.pageCnt == 1
                      ? Container()
                      : Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              GestureDetector(
                                child: Container(
                                  height: 30.0,
                                  width: 30.0,
                                  child: new Center(
                                    child: new Text(
                                        state.pageModel.pages[index].toString(),
                                        style: new TextStyle(
                                            fontFamily: 'HDharmony',
                                            color:
                                                state.pageModel.pages[index] ==
                                                        state.pageModel.curPage
                                                    ? Colors.white
                                                    : Colors.black54,
                                            //fontWeight: FontWeight.bold,
                                            fontSize: 12.0)),
                                  ),
                                  decoration: new BoxDecoration(
                                    color: state.pageModel.pages[index] ==
                                            state.pageModel.curPage
                                        ? Colors.black54
                                        : Colors.transparent,
                                    border: new Border.all(
                                        width: 1.0,
                                        color: state.pageModel.pages[index] ==
                                                state.pageModel.curPage
                                            ? Colors.black54
                                            : Colors.grey),
                                    borderRadius: const BorderRadius.all(
                                        const Radius.circular(1.0)),
                                  ),
                                ),
                                onTap: () {
                                  bloc.add(SearchMarketSearchEvent(
                                      state.sido,
                                      state.sigungu,
                                      state.ptno,
                                      state.pageModel.pages[index]));
                                },
                              ),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        );
                }),
          );
        });
  }
}

class MarketSearchResultForm extends StatefulWidget {
  final String krname;
  final String enname;
  final String price;
  final String ptno;
  final String companyMark;
  final bool canDelivery;
  final String address1;
  final String address2;
  final String phoneNumber;
  final bool canSale;
  MarketSearchResultForm({
    Key key,
    this.krname,
    this.enname,
    this.price,
    this.ptno,
    this.companyMark,
    this.canDelivery,
    this.address1,
    this.address2,
    this.phoneNumber,
    this.canSale = true,
  }) : super(key: key);
  @override
  _MarketSearchResultFormState createState() => _MarketSearchResultFormState();
}

class _MarketSearchResultFormState extends State<MarketSearchResultForm> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Table(
              columnWidths: {
                0: FixedColumnWidth(screenWidth * 0.26),
                1: FixedColumnWidth(screenWidth * 0.66),
              },
              border: TableBorder(
                top: BorderSide(color: Colors.black, width: 1.5),
                bottom: BorderSide(
                  color: Colors.black,
                  width: 1.5,
                ),
                horizontalInside: BorderSide(
                    width: 1,
                    color: Color(0xff666666),
                    style: BorderStyle.solid),
                verticalInside: BorderSide(color: Color(0xff666666), width: 1),
              ),
              children: [
                TableRow(children: [
                  TableCell(
                    child: Container(
                      color: Color(0xffcccccc),
                      child: SizedBox(
                        height: 40,
                        child: Center(
                          child: Text(
                            '상호명',
                            style: TextStyle(
                                fontFamily: 'HDharmony',
                                fontSize: 13,
                                color: Color(0xff666666)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: SizedBox(
                      height: 40,
                      width: screenWidth * 0.68,
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
                                      fontFamily: 'HDharmony',
                                      fontSize: 12,
                                      color: Colors.black),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            widget.canDelivery
                                ? Container(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Image.asset(
                                        'assets/images/shipped3.png'))
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  )
                ]),
                TableRow(children: [
                  TableCell(
                    child: Container(
                      color: Color(0xffcccccc),
                      child: SizedBox(
                        height: 60,
                        child: Center(
                          child: Text(
                            '주소',
                            style: TextStyle(
                                fontFamily: 'HDharmony',
                                fontSize: 13,
                                color: Color(0xff666666)),
                            textAlign: TextAlign.center,
                          ),
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
                              style: TextStyle(
                                  fontFamily: 'HDharmony',
                                  fontSize: 12,
                                  color: Colors.black),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              widget.address2,
                              style: TextStyle(
                                  fontFamily: 'HDharmony',
                                  fontSize: 12,
                                  color: Colors.black),
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
                    child: Container(
                      color: Color(0xffcccccc),
                      child: SizedBox(
                        height: 40,
                        child: Center(
                          child: Text(
                            '전화번호',
                            style: TextStyle(
                              fontFamily: 'HDharmony',
                              fontSize: 13,
                              color: Color(0xff666666),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      width: screenWidth * 0.68,
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 40,
                              padding: EdgeInsets.only(left: 10),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.phoneNumber,
                                style: TextStyle(
                                    fontFamily: 'HDharmony',
                                    fontSize: 12,
                                    color: Colors.black),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                            child: OutlineButton(
                              borderSide: BorderSide(
                                color: kPrimaryColor, //Color of the border
                                style: BorderStyle.solid, //Style of the border
                                width: 1, //width of the border
                              ),
                              child: Text(
                                '지도보기',
                                style: TextStyle(
                                    fontFamily: 'HDharmony',
                                    fontSize: 12,
                                    color: Colors.indigo),
                              ),
                              onPressed: () {},
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
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Container(
            width: screenWidth * 0.96,
            padding: EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black26,
                width: 1,
              ),
            ),
            child: Center(
                child: widget.canSale
                    ? Container(
                        width: screenWidth * 0.4,
                        height: 50,
                        child: RaisedButton(
                          child: Text(
                            '구매요청',
                            style: TextStyle(
                                fontFamily: 'HDharmony',
                                fontSize: 15,
                                color: Colors.white),
                          ),
                          color: kPrimaryColor,
                          onPressed: () {
                            pushTo(
                                context,
                                PurchaseRequestScreen(
                                    partNumber: widget.ptno,
                                    koreanPartName: widget.krname,
                                    englishPartName: widget.enname,
                                    price: widget.price,
                                    companyMark: widget.companyMark));
                          },
                        ))
                    : Container(
                        child: Text(
                          '해당 판매점은 전화로 직접 문의 부탁드립니다.',
                          style: TextStyle(
                            fontFamily: 'HDharmony',
                            fontSize: 12,
                          ),
                        ),
                      )),
          ),
        ),
      ],
    );
  }
}
