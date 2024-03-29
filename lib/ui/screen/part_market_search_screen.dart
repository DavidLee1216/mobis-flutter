
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobispartsearch/bloc/market_search_bloc.dart';
import 'package:mobispartsearch/ui/widget/loading_indication.dart';
import 'package:mobispartsearch/ui/widget/market_search_result_form.dart';
import 'package:mobispartsearch/ui/widget/custom_radio_button.dart';

import '../../common.dart';

class PartMarketSearchScreen extends StatefulWidget {
  @override
  _PartMarketSearchScreenState createState() => _PartMarketSearchScreenState();
}

class _PartMarketSearchScreenState extends State<PartMarketSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text(
          '부품판매점 검색',
          style: TextStyle(
            fontFamily: 'HDharmony',
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: MarketSearchListWidget()),
          ],
        ), //
      ),
    );
  }
}

class MarketSearchListWidget extends StatefulWidget {
  @override
  _MarketSearchListWidgetState createState() => _MarketSearchListWidgetState();
}

class _MarketSearchListWidgetState extends State<MarketSearchListWidget> {
  bool searched = false;
  List<RadioModel> manufacturerData = new List<RadioModel>();
  List<RadioModel> marketData = new List<RadioModel>();
  String hkgb = 'H';
  String ptno = '';
  String sido;
  String sigungu;

  TextEditingController partNumberController = TextEditingController();

  MarketSearchBloc bloc;

  @override
  void initState() {
    super.initState();
    manufacturerData.add(RadioModel(true, '', '현대'));
    manufacturerData.add(RadioModel(false, '', '기아'));
    marketData.add(RadioModel(true, '', '전체'));
    marketData.add(RadioModel(false, '', '직영점'));
    marketData.add(RadioModel(false, '', '대리점(매장)'));
    marketData.add(RadioModel(false, '', '대리점(온라인몰)'));


    bloc = BlocProvider.of<MarketSearchBloc>(context);
  }

  void messageBox(String string){
    showDialog(context: context, builder: (context){
      return AlertDialog(content: Text(string),);
    });
  }

  @override
  Widget build(BuildContext context) {
    var mainWidth = MediaQuery.of(context).size.width;
    var manufactureItem = Container(
      height: 50,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Text(
              '제조사',
              style: TextStyle(
                fontFamily: 'HDharmony',
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          ButtonTheme(
            padding: const EdgeInsets.only(left: 20),
            child: FlatButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              child: RadioItem(manufacturerData[0]),
              onPressed: () {
                setState(() {
                  manufacturerData
                      .forEach((element) => element.isSelected = false);
                  manufacturerData[0].isSelected = true;
                  bloc.add(HKGBMarketSearchEvent(0));
                });
              },
            ),
          ),
          ButtonTheme(
            child: FlatButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              child: RadioItem(manufacturerData[1]),
              onPressed: () {
                setState(() {
                  manufacturerData
                      .forEach((element) => element.isSelected = false);
                  manufacturerData[1].isSelected = true;
                  bloc.add(HKGBMarketSearchEvent(1));
                });
              },
            ),
          ),
        ],
      ),
    );

    var marketItem = Container(
      child: Row(
        children: [
          Center(
            child: Container(
              width: mainWidth * 0.25,
              padding: const EdgeInsets.only(left: 30.0),
              child: Text(
                '판매점',
                style: TextStyle(
                  fontFamily: 'HDharmony',
                  fontSize: 14,
                ),
              ),
            ),
          ),
          Container(
            width: mainWidth * 0.75,
            child: Column(children: [
              ButtonTheme(
                child: FlatButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  child: RadioItem(marketData[0]),
                  onPressed: () {
                    setState(() {
                      marketData
                          .forEach((element) => element.isSelected = false);
                      marketData[0].isSelected = true;
                      bloc.add(SetMarketMarketSearchEvent(0));
                    });
                  },
                ),
              ),
              ButtonTheme(
                child: FlatButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  child: RadioItem(marketData[1]),
                  onPressed: () {
                    setState(() {
                      marketData
                          .forEach((element) => element.isSelected = false);
                      marketData[1].isSelected = true;
                      bloc.add(SetMarketMarketSearchEvent(1));
                    });
                  },
                ),
              ),
              ButtonTheme(
                child: FlatButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  child: RadioItem(marketData[2]),
                  onPressed: () {
                    setState(() {
                      marketData
                          .forEach((element) => element.isSelected = false);
                      marketData[2].isSelected = true;
                      bloc.add(SetMarketMarketSearchEvent(2));
                    });
                  },
                ),
              ),
              ButtonTheme(
                child: FlatButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  child: RadioItem(marketData[3]),
                  onPressed: () {
                    setState(() {
                      marketData
                          .forEach((element) => element.isSelected = false);
                      marketData[3].isSelected = true;
                      bloc.add(SetMarketMarketSearchEvent(3));
                    });
                  },
                ),
              ),
            ]),
          )
        ],
      ),
    );
    var location1Dropdownmenu = Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: sido,
            hint: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                '[선택]',
                style: TextStyle(
                  fontFamily: 'HDharmony',
                ),
              ),
            ),
            icon: Icon(Icons.keyboard_arrow_down),
            iconSize: 14,
            onChanged: (String newValue) {
              setState(() {
                sido = newValue;
                sigungu = findFirstSigungu(sido);
              });
            },
            items: globalSido?.map<DropdownMenuItem<String>>((item) {
              return DropdownMenuItem<String>(
                value: item.sido,
                child: Container(
                  width: 200,
                  child: Text(
                    item.sido,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'HDharmony',
                      fontSize: 14,
                    ),
                  ),
                  alignment: Alignment.center,
                ),
              );
            })?.toList(),
          ),
        ));
    var location2Dropdownmenu = Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: sigungu,
            hint: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                '[선택]',
                style: TextStyle(
                  fontFamily: 'HDharmony',
                ),
              ),
            ),
            icon: Icon(Icons.keyboard_arrow_down),
            iconSize: 14,
            onChanged: (String newValue) {
              setState(() {
                sigungu = newValue;
              });
            },
            items:
                findSido(sido)?.sigungus?.map<DropdownMenuItem<String>>((item) {
              return DropdownMenuItem<String>(
                value: item.sigungu,
                child: Container(
                  width: 200,
                  child: Text(
                    item.sigungu,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'HDharmony',
                      fontSize: 14,
                    ),
                  ),
                  alignment: Alignment.center,
                ),
              );
            })?.toList(),
          ),
        ));
    var locationItem = Container(
        padding: EdgeInsets.all(10.0),
        child: Container(
          child: Row(
            children: [
              Container(
                width: mainWidth * 0.23,
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  '지역설정',
                  style: TextStyle(fontFamily: 'HDharmony', fontSize: 14),
                ),
              ),
              Container(
                  child: Column(
                children: [
                  location1Dropdownmenu,
                  SizedBox(
                    height: 10,
                  ),
                  location2Dropdownmenu,
                ],
              ))
            ],
          ),
        ));

    var partNumber = Container(
        padding: EdgeInsets.all(10.0),
        child: Container(
          height: 40,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  '부품번호',
                  style: TextStyle(
                    fontFamily: 'HDharmony',
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
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
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontFamily: 'HDharmony',
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                  controller: partNumberController,
                  onEditingComplete: () {
                    bloc.add(SetPtnoMarketSearchEvent(partNumberController.text));
                  },
                ),
              )
            ],
          ),
        ));

    var searchButton = Center(
        child: Container(
      padding: EdgeInsets.only(top: 20.0),
      child: ButtonTheme(
        minWidth: MediaQuery.of(context).size.width / 1.1,
        height: 50,
        buttonColor: Color.fromRGBO(0, 63, 114, 1),
        child: RaisedButton(
          child: Text(
            '검색',
            style: TextStyle(
              fontFamily: 'HDharmony',
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            ptno = partNumberController.text;
            if (ptno != '') {
              searched = true;
              bloc.add(SearchMarketSearchEvent(ptno, sido, sigungu));
              setState(() {});
            } else {
              showToastMessage(text:'부품번호를 입력하세요.', position: 1);
            }
          },
        ),
      ),
    ));


    var searchMoreButton = Center(
        child: Container(
          width: MediaQuery.of(context).size.width/3,
          padding: EdgeInsets.only(top: 20.0),
          child: ButtonTheme(
            minWidth: MediaQuery.of(context).size.width / 1.1,
            height: 50,
            buttonColor: Colors.white,
            child: RaisedButton(
              child: Text(
                '더 보기',
                style: TextStyle(
                  fontFamily: 'HDharmony',
                  fontSize: 15,
                  color: Color.fromRGBO(0, 63, 114, 1),
                ),
              ),
              onPressed: () {
                  bloc.add(SearchMarketSearchMoreEvent());
              },
            ),
          ),
        ));

    var partNumberSearchItems = Container(
      child: partNumber,
    );

    return BlocBuilder<MarketSearchBloc, MarketSearchState>(
    cubit: BlocProvider.of<MarketSearchBloc>(context),
    builder: (BuildContext context, state) {
        partNumberController.text = state.ptno;
        manufacturerData[0].isSelected = state.hkgb=='H'? true : false;
        manufacturerData[1].isSelected = state.hkgb=='H'? false : true;
        return Stack(
            children: [
              ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '부품번호를 입력하시면 해당 부품을 직접 방문 혹은 온라인을 통해 구매할 수 있는 판매점을 알려드립니다.',
                          style: TextStyle(
                            fontFamily: 'HDharmony',
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '- 판매점이 조회되지 않는 경우 당사 고객센터(1588-7278)로 문의 바랍니다.',
                          style: TextStyle(
                            fontFamily: 'HDharmony',
                            fontSize: 13,
                            color: Color(0xff666666),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 2,
                    color: Colors.black,
                  ),
                  partNumberSearchItems,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      color: Colors.black54,
                    ),
                  ),
                  locationItem,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      color: Colors.black54,
                    ),
                  ),
                  marketItem,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      color: Colors.black54,
                    ),
                  ),
                  manufactureItem,
                  Divider(
                    height: 2,
                    color: Colors.black54,
                  ),
                  searchButton,
                  SizedBox(height: 30),
                  state.searchResult!=null && state.searchResult.length > 0 ? MarketSearchResultsForm() : Container(),
                  (state.nomore==false && state.searchResult!=null && state.searchResult.length > 0) ? searchMoreButton : Container(),
                ],
              ),
              Positioned(
                child: LoadingIndicator(isLoading: state.isLoading),
              ),
            ]
        );
      }
    );
  }
}
