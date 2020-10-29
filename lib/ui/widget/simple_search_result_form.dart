import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyundai_mobis/bloc/notice_bloc.dart';

class SimpleSearchResultsForm extends StatefulWidget {
  @override
  _SimpleSearchResultsFormState createState() => _SimpleSearchResultsFormState();
}

class _SimpleSearchResultsFormState extends State<SimpleSearchResultsForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Center(
            child: Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("'에이컨'", style: TextStyle(fontSize: 14, color: Color.fromRGBO(0, 63, 114, 1)),),
                  Text("에 대한 검색 결과(총 11건)", style: TextStyle(fontSize: 14, color: Colors.black),),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          SimpleSearchResultForm(
            partNumber: '97651B2000',
            koreanPartName: '플레이트 & 그로메트－에어컨 쿨러 라인',
            englishParName: 'PLATE & GROMMET-A/C COOLER LIN',
            price: '1,870원',
          ),
          SizedBox(height: 10,),
          SimpleSearchResultForm(
            partNumber: '97651B2000',
            koreanPartName: '플레이트 & 그로메트－에어컨 쿨러 라인',
            englishParName: 'PLATE & GROMMET-A/C COOLER LIN',
            price: '1,870원',
          ),
          SizedBox(height: 10,),
          SimpleSearchResultForm(
            partNumber: '97651B2000',
            koreanPartName: '플레이트 & 그로메트－에어컨 쿨러 라인',
            englishParName: 'PLATE & GROMMET-A/C COOLER LIN',
            price: '1,870원',
          ),
          SizedBox(height: 10,),
          SimpleSearchResultForm(
            partNumber: '97651B2000',
            koreanPartName: '플레이트 & 그로메트－에어컨 쿨러 라인',
            englishParName: 'PLATE & GROMMET-A/C COOLER LIN',
            price: '1,870원',
          ),
          SizedBox(height: 10,),
          SimpleSearchResultForm(
            partNumber: '97651B2000',
            koreanPartName: '플레이트 & 그로메트－에어컨 쿨러 라인',
            englishParName: 'PLATE & GROMMET-A/C COOLER LIN',
            price: '1,870원',
          ),
          SizedBox(height: 10,),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Image.asset('images/reference.png'),
                  Text('부품 번호를 선택하시면 판매점을 조회하실 수 있습니다.', style: TextStyle(color: Colors.black, fontSize:12), ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
          Container(
            child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      padding: EdgeInsets.zero,
                      child: OutlineButton(
                        child: Text('1', style: TextStyle(fontSize: 8, color: Colors.black), textAlign: TextAlign.left,),
                        onPressed: (){},
                      ),
                    ),
                    SizedBox(width: 5,),
                    Container(
                      width: 20,
                      height: 20,
                      padding: EdgeInsets.zero,
                      child: OutlineButton(
                        child: Text('2', style: TextStyle(fontSize: 8, color: Colors.black), textAlign: TextAlign.left,),
                        onPressed: (){},
                      ),
                    )
                  ],
                )
            ),
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}

class SimpleSearchResultForm extends StatefulWidget {
  final String partNumber;
  final String koreanPartName;
  final String englishParName;
  final String price;
  SimpleSearchResultForm(
      {Key key,
      this.partNumber,
      this.koreanPartName,
      this.englishParName,
      this.price})
      : super(key: key);
  @override
  _SimpleSearchResultFormState createState() => _SimpleSearchResultFormState();
}

class _SimpleSearchResultFormState extends State<SimpleSearchResultForm> {
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
                          '부품 번호',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: SizedBox(
                      height: 30,
                      child: Center(
                        child: Text(
                          widget.partNumber,
                          style: TextStyle(fontSize: 12, color: Colors.black),
                          textAlign: TextAlign.left,
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
                          '한글 부품명',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: SizedBox(
                      height: 30,
                      child: Center(
                        child: Text(
                          widget.koreanPartName,
                          style: TextStyle(fontSize: 12, color: Colors.black),
                          textAlign: TextAlign.left,
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
                          '영어 부품명',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: SizedBox(
                      height: 30,
                      child: Center(
                        child: Text(
                          widget.englishParName,
                          style: TextStyle(fontSize: 12, color: Colors.black),
                          textAlign: TextAlign.left,
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
                          '가격(부가세포함)',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: SizedBox(
                      height: 30,
                      child: Center(
                        child: Text(
                          widget.price,
                          style: TextStyle(fontSize: 12, color: Colors.black),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  )
                ]),
              ],
            )),
      ],
    );
  }
}
