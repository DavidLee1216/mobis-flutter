import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobispartsearch/bloc/simple_search_bloc.dart';
import 'package:mobispartsearch/ui/screen/home_screen.dart';

class SimpleSearchResultsForm extends StatefulWidget {
  @override
  _SimpleSearchResultsFormState createState() =>
      _SimpleSearchResultsFormState();
}

class _SimpleSearchResultsFormState extends State<SimpleSearchResultsForm> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SimpleSearchBloc>(context);
    return BlocBuilder<SimpleSearchBloc, SimpleSearchState>(
        cubit: BlocProvider.of<SimpleSearchBloc>(context),
        builder: (BuildContext context, state) {
          return Container(
            child: Column(
              children: [
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          state.keyword,
                          style: TextStyle(
                              fontFamily: 'HDharmony',
                              fontSize: 14,
                              color: kPrimaryColor),
                        ),
                        Text(
                          "에 대한 검색 결과(총 11건)",
                          style: TextStyle(
                              fontFamily: 'HDharmony',
                              fontSize: 14,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                  return SimpleSearchResultForm(
                    partNumber: state.searchResult[index].ptno,
                    koreanPartName: state.searchResult[index].krname,
                    englishParName: state.searchResult[index].enname,
                    price: state.searchResult[index].price.toString() + '원',
                  );
                }),
//              SimpleSearchResultForm(
//                partNumber: '97651B2000',
//                koreanPartName: '플레이트 & 그로메트－에어컨 쿨러 라인',
//                englishParName: 'PLATE & GROMMET-A/C COOLER LIN',
//                price: '1,870원',
//              ),
//              SizedBox(height: 10,),
//              SimpleSearchResultForm(
//                partNumber: '97651B2000',
//                koreanPartName: '플레이트 & 그로메트－에어컨 쿨러 라인',
//                englishParName: 'PLATE & GROMMET-A/C COOLER LIN',
//                price: '1,870원',
//              ),
//              SizedBox(height: 10,),
//              SimpleSearchResultForm(
//                partNumber: '97651B2000',
//                koreanPartName: '플레이트 & 그로메트－에어컨 쿨러 라인',
//                englishParName: 'PLATE & GROMMET-A/C COOLER LIN',
//                price: '1,870원',
//              ),
//              SizedBox(height: 10,),
//              SimpleSearchResultForm(
//                partNumber: '97651B2000',
//                koreanPartName: '플레이트 & 그로메트－에어컨 쿨러 라인',
//                englishParName: 'PLATE & GROMMET-A/C COOLER LIN',
//                price: '1,870원',
//              ),
//              SizedBox(height: 10,),
//              SimpleSearchResultForm(
//                partNumber: '97651B2000',
//                koreanPartName: '플레이트 & 그로메트－에어컨 쿨러 라인',
//                englishParName: 'PLATE & GROMMET-A/C COOLER LIN',
//                price: '1,870원',
//              ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Image.asset('assets/images/reference.png'),
                        Text(
                          '부품 번호를 선택하시면 판매점을 조회하실 수 있습니다.',
                          style: TextStyle(
                              fontFamily: 'HDharmony',
                              color: Colors.black,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Center(
                    child: ListView.builder(
                        itemBuilder: (BuildContext context, index) {
                      return Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            GestureDetector(
                              child: Container(
                                height: 20.0,
                                width: 20.0,
                                child: new Center(
                                  child: new Text(
                                      state.pageModel.pages[index].toString(),
                                      style: new TextStyle(
                                          fontFamily: 'HDharmony',
                                          color: state.pageModel.pages[index] ==
                                                  state.pageModel.curPage
                                              ? Colors.white
                                              : Colors.black54,
                                          //fontWeight: FontWeight.bold,
                                          fontSize: 8.0)),
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
                                bloc.add(SearchSimpleSearchEvent(
                                    state.keyword,
                                    state.searchType,
                                    state.pageModel.pages[index]));
                              },
                            ),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      );
                    }),
//                    child: Row(
//                      mainAxisSize: MainAxisSize.min,
//                      children: [
//                        Container(
//                          width: 20,
//                          height: 20,
//                          padding: EdgeInsets.zero,
//                          child: OutlineButton(
//                            child: Text('1', style: TextStyle(fontFamily: 'HDharmony',
//                                fontSize: 8, color: Colors.black),
//                              textAlign: TextAlign.left,),
//                            onPressed: () {},
//                          ),
//                        ),
//                        SizedBox(width: 5,),
//                        Container(
//                          width: 20,
//                          height: 20,
//                          padding: EdgeInsets.zero,
//                          child: OutlineButton(
//                            child: Text('2', style: TextStyle(fontFamily: 'HDharmony',
//                                fontSize: 8, color: Colors.black),
//                              textAlign: TextAlign.left,),
//                            onPressed: () {},
//                          ),
//                        ),
//                      ],
//                    )
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        });
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
    var screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Table(
              columnWidths: {
                0: FixedColumnWidth(screenWidth * 0.28),
                1: FixedColumnWidth(screenWidth * 0.68),
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
                          style: TextStyle(
                              fontFamily: 'HDharmony',
                              fontSize: 12,
                              color: Colors.black),
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
                          style: TextStyle(
                              fontFamily: 'HDharmony',
                              fontSize: 12,
                              color: Colors.black),
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
                          style: TextStyle(
                              fontFamily: 'HDharmony',
                              fontSize: 12,
                              color: Colors.black),
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
                          style: TextStyle(
                              fontFamily: 'HDharmony',
                              fontSize: 12,
                              color: Colors.black),
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
                          style: TextStyle(
                              fontFamily: 'HDharmony',
                              fontSize: 12,
                              color: Colors.black),
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
                          style: TextStyle(
                              fontFamily: 'HDharmony',
                              fontSize: 12,
                              color: Colors.black),
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
                          style: TextStyle(
                              fontFamily: 'HDharmony',
                              fontSize: 12,
                              color: Colors.black),
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
                          style: TextStyle(
                              fontFamily: 'HDharmony',
                              fontSize: 12,
                              color: Colors.black),
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
