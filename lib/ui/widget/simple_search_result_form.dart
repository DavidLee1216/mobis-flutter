import 'dart:developer';

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
          return Column(
            mainAxisSize: MainAxisSize.min,
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
                        state.keyword != ''
                            ? "에 대한 검색 결과(총 ${state.searchResultCnt}건)"
                            : "검색 결과(총 ${state.searchResultCnt}건)",
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
              SimpleSearchResultListWidget(),
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
                        ' 부품 번호를 선택하시면 판매점을 조회하실 수 있습니다.',
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
              SimpleSearchPageListWidget(),
              SizedBox(
                height: 20,
              ),
            ],
          );
        });
  }
}

class SimpleSearchResultListWidget extends StatefulWidget {
  @override
  _SimpleSearchResultListWidgetState createState() =>
      _SimpleSearchResultListWidgetState();
}

class _SimpleSearchResultListWidgetState
    extends State<SimpleSearchResultListWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SimpleSearchBloc, SimpleSearchState>(
        cubit: BlocProvider.of<SimpleSearchBloc>(context),
        builder: (BuildContext context, state) {
          if (state.searchResult == null || state.searchResultCnt == 0) {
            return Container();
          }
          return ListView.builder(
              itemCount: state.searchResult.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return SimpleSearchResultForm(
                  partNumber: state.searchResult[index].ptno,
                  koreanPartName: state.searchResult[index].krname,
                  englishParName: state.searchResult[index].enname,
                  price: state.searchResult[index].price.toString() + '원',
                );
              });
        });
  }
}

class SimpleSearchPageListWidget extends StatefulWidget {
  @override
  _SimpleSearchPageListWidgetState createState() =>
      _SimpleSearchPageListWidgetState();
}

class _SimpleSearchPageListWidgetState
    extends State<SimpleSearchPageListWidget> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SimpleSearchBloc>(context);
    return BlocBuilder<SimpleSearchBloc, SimpleSearchState>(
        cubit: BlocProvider.of<SimpleSearchBloc>(context),
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
                                        state.pageModel.pages[index]
                                            .toString(),
                                        style: new TextStyle(
                                            fontFamily: 'HDharmony',
                                            color: state.pageModel
                                                        .pages[index] ==
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
                                  bloc.add(SearchSimpleSearchEvent(
                                      state.keyword,
                                      state.searchType,
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
    return Container(
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
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
                        style: BorderStyle.solid)),
                children: [
                  TableRow(children: [
                    TableCell(
                      child: Container(
                        color: Color(0xffcccccc),
                        child: SizedBox(
                          height: 40,
                          child: Center(
                            child: Text(
                              '부품 번호',
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
                      child: Container(
                        color: Color(0xffcccccc),
                        child: SizedBox(
                          height: 40,
                          child: Center(
                            child: Text(
                              '한글 부품명',
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
                        child: Center(
                          child: Text(
                            widget.koreanPartName,
                            style: TextStyle(
                                fontFamily: 'HDharmony',
                                fontSize: 13,
                                color: Colors.black),
                            textAlign: TextAlign.left,
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
                              '영어 부품명',
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
                        child: Center(
                          child: Text(
                            widget.englishParName,
                            style: TextStyle(
                                fontFamily: 'HDharmony',
                                fontSize: 13,
                                color: Colors.black),
                            textAlign: TextAlign.left,
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
                              '가격(부가세포함)',
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
                        child: Center(
                          child: Text(
                            widget.price,
                            style: TextStyle(
                                fontFamily: 'HDharmony',
                                fontSize: 13,
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
      ),
    );
  }
}
