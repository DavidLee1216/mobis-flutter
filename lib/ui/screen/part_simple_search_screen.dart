import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobispartsearch/bloc/simple_search_bloc.dart';
import 'package:mobispartsearch/common.dart';
import 'package:mobispartsearch/model/carModel_model.dart';
import 'package:mobispartsearch/ui/widget/loading_indication.dart';
import 'package:mobispartsearch/ui/widget/simple_search_result_form.dart';
import 'package:mobispartsearch/ui/widget/custom_radio_button.dart';

import '../../app_config.dart';

class PartSimpleSearchScreen extends StatefulWidget {
  @override
  _PartSimpleSearchScreenState createState() => _PartSimpleSearchScreenState();
}

class _PartSimpleSearchScreenState extends State<PartSimpleSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text(
          '부품 간단검색',
          style: TextStyle(
            fontFamily: 'HDharmony',
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: SimpleSearchListWidget()),
          ],
        ), //
      ),
    );
  }
}

class SimpleSearchListWidget extends StatefulWidget {
  @override
  _SimpleSearchListWidgetState createState() => _SimpleSearchListWidgetState();
}

class _SimpleSearchListWidgetState extends State<SimpleSearchListWidget> {
  bool searchType = false;
  bool searched = false;
  List<RadioModel> manufacturerData = new List<RadioModel>();
  List<RadioModel> carKindData = new List<RadioModel>();
  List<ModelSeq> carModels;
  int catSeq = 0;
  String modelDropdownValue;
  String hkgb = 'H';
  String vtpy = 'P';
  int hkgb_id = 0;
  int vtpy_id = 0;

  TextEditingController partNameController = TextEditingController();

  TextEditingController partNumberController = TextEditingController();

  SimpleSearchBloc bloc;

  @override
  void initState() {
    super.initState();
    manufacturerData.add(RadioModel(true, '', '현대'));
    manufacturerData.add(RadioModel(false, '', '기아'));
    carKindData.add(RadioModel(true, '', '승용/친환경'));
    carKindData.add(RadioModel(false, '', 'SUV/RV'));
    carKindData.add(RadioModel(false, '', '상용'));
    bloc = BlocProvider.of<SimpleSearchBloc>(context);
    bloc.add(InitSimpleSearchEvent());
  }

  void getCatSeq(String value){
    carModels = globalModels[hkgb_id][vtpy_id];
    for(int i = 0; i < carModels.length; i++){
      if(carModels[i].modelname == value){
        catSeq = carModels[i].seq;
        bloc.add(ModelSimpleSearchEvent(catSeq));
        return;
      }
    }
    catSeq = 0;
    bloc.add(ModelSimpleSearchEvent(catSeq));
  }

  @override
  Widget build(BuildContext context) {
    var manufactureItem = Container(
      height: 50,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
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
            minWidth: 0,
            height: 0,
            child: FlatButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              child: RadioItem(manufacturerData[0]),
              onPressed: () {
                setState(() {
                  manufacturerData
                      .forEach((element) => element.isSelected = false);
                  manufacturerData[0].isSelected = true;
                  bloc.add(HKGBSimpleSearchEvent(0));
                  hkgb = hkgb_list[0];
                  hkgb_id = 0;
                  modelDropdownValue = null;
                });
              },
            ),
          ),
          ButtonTheme(
            minWidth: 0,
            height: 0,
            child: FlatButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              child: RadioItem(manufacturerData[1]),
              onPressed: () {
                setState(() {
                  manufacturerData
                      .forEach((element) => element.isSelected = false);
                  manufacturerData[1].isSelected = true;
                  bloc.add(HKGBSimpleSearchEvent(1));
                  hkgb = hkgb_list[1];
                  hkgb_id = 1;
                  modelDropdownValue = null;
                });
              },
            ),
          ),
        ],
      ),
    );
    var cardKindItem = Container(
      height: 50,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              '차량 구분',
              style: TextStyle(
                fontFamily: 'HDharmony',
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                ButtonTheme(
                  minWidth: 0, //wraps child's width
                  height: 0, //wraps child's height
                  child: FlatButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    child: RadioItem(carKindData[0]),
                    onPressed: () {
                      setState(() {
                        carKindData.forEach((element) => element.isSelected = false);
                        carKindData[0].isSelected = true;
                        bloc.add(VTPYSimpleSearchEvent(0));
                        vtpy = vtpy_list[0];
                        vtpy_id = 0;
                        modelDropdownValue = null;
                      });
                    },
                  ),
                ),
                ButtonTheme(
                  minWidth: 0, //wraps child's width
                  height: 0, //wraps child's height
                  child: FlatButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    child: RadioItem(carKindData[1]),
                    onPressed: () {
                      setState(() {
                        carKindData.forEach((element) => element.isSelected = false);
                        carKindData[1].isSelected = true;
                        bloc.add(VTPYSimpleSearchEvent(1));
                        vtpy = vtpy_list[1];
                        vtpy_id = 1;
                        modelDropdownValue = null;
                      });
                    },
                  ),
                ),
                ButtonTheme(
                  minWidth: 0, //wraps child's width
                  height: 0, //wraps child's height
                  child: FlatButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    child: RadioItem(carKindData[2]),
                    onPressed: () {
                      setState(() {
                        carKindData.forEach((element) => element.isSelected = false);
                        carKindData[2].isSelected = true;
                        bloc.add(VTPYSimpleSearchEvent(2));
                        vtpy = vtpy_list[2];
                        vtpy_id = 2;
                        modelDropdownValue = null;
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

    var modelDropdownmenu = Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                    value: modelDropdownValue,
                    hint: Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        '[선택]',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'HDharmony',
                        ),
                      ),
                      alignment: Alignment.center,
                    ),
                    icon: Icon(Icons.keyboard_arrow_down),
                    iconSize: 14,
                    onChanged: (newValue) {
                      modelDropdownValue = newValue;
                      getCatSeq(modelDropdownValue);
                      setState(() {});
                    },
                    items: globalModels[hkgb_id][vtpy_id]?.map<DropdownMenuItem<String>>((item) {
                      return DropdownMenuItem<String>(
                        value: item.modelname,
                        child: Container(
                          width: 200,
                          child: Text(
                            item.modelname,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'HDharmony',
                              fontSize: 14,
                            ),
                          ),
//                          alignment: Alignment.center,
                        ),
                      );
                    })?.toList()),
              ),
            ),
          );

    var modelItem = Container(
        padding: EdgeInsets.all(10.0),
        child: Container(
          height: 40,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  '모델',
                  style: TextStyle(fontFamily: 'HDharmony', fontSize: 14),
                ),
              ),
              SizedBox(
                width: 50,
              ),
              modelDropdownmenu,
            ],
          ),
        ));

    var partName = Container(
        padding: EdgeInsets.all(10.0),
        child: Container(
          padding: const EdgeInsets.only(right: 10),
          height: 40,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  '한글부품명',
                  style: TextStyle(
                    fontFamily: 'HDharmony',
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
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
                  style: TextStyle(fontFamily: 'HDharmony', fontSize: 14.0),
                  controller: partNameController,
                ),
              )
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
                padding: EdgeInsets.only(left: 10),
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
                width: MediaQuery.of(context).size.width * 0.74,
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
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            searched = true;
            setState(() {
              bloc.add(SearchSimpleSearchEvent(
                  searchType
                      ? partNumberController.text
                      : partNameController.text,
                  searchType,
                  ));
            });
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
                bloc.add(SearchSimpleSearchMoreEvent());
              },
            ),
          ),
        ));

    var generalSearchItems = Container(
      child: Column(
        children: [
          cardKindItem,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9),
            child: Divider(
              color: Colors.black54,
            ),
          ),
          modelItem,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9),
            child: Divider(
              color: Colors.black54,
            ),
          ),
          partName,
        ],
      ),
    );

    var partNumberSearchItems = Container(
      child: partNumber,
    );

    return BlocBuilder<SimpleSearchBloc, SimpleSearchState>(
      cubit: BlocProvider.of<SimpleSearchBloc>(context),
      builder: (BuildContext context, state) {
        return Stack(
          children: [
              ListView(
              shrinkWrap: true,
              children: [
                Row(
                  children: [
                    ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width / 2,
                      height: 50,
                      buttonColor: Colors.white,
                      child: RaisedButton(
                        child: !searchType
                            ? Text(
                                '일반 검색',
                                style: TextStyle(
                                  fontFamily: 'HDharmony',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Color.fromRGBO(0, 63, 114, 1),
                                ),
                              )
                            : Text(
                                '일반 검색',
                                style: TextStyle(
                                  fontFamily: 'HDharmony',
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                        shape: !searchType
                            ? Border(
                                bottom: BorderSide(
                                    color: Color.fromRGBO(0, 63, 114, 1), width: 3))
                            : Border(
                                bottom: BorderSide(
                                    color: Colors.transparent, width: 3)),
                        onPressed: () {
                          searchType = false;
                          searched = false;
                          setState(() {});
                        },
                      ),
                    ),
                    ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width / 2,
                      height: 50,
                      buttonColor: Colors.white,
                      child: RaisedButton(
                        child: searchType
                            ? Text(
                                '부품번호로 검색',
                                style: TextStyle(
                                  fontFamily: 'HDharmony',
                                  fontSize: 15,
                                  color: Color.fromRGBO(0, 63, 114, 1),
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : Text(
                                '부품번호로 검색',
                                style: TextStyle(
                                  fontFamily: 'HDharmony',
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                        shape: searchType
                            ? Border(
                                bottom: BorderSide(
                                    color: Color.fromRGBO(0, 63, 114, 1), width: 3))
                            : Border(
                                bottom: BorderSide(
                                    color: Colors.transparent, width: 3)),
                        onPressed: () {
                          searchType = true;
                          searched = false;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 20.0),
                  child: Column(
                    children: [
                      Text(
                        '현대/기아 차량에 대한 기본적인 부품정보를 제공하고 있습니다.',
                        style: TextStyle(
                          fontFamily: 'HDharmony',
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        '- 조회되는 부품 가격은 당사 직영점 기준 판매 가격이며, 부품대리점의 판매 가격과 상이할 수 있으니 참고 바랍니다.',
                        style: TextStyle(
                          fontFamily: 'HDharmony',
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        '- 간단 검색으로 부품 식별이 어렵거나, 희망하는 차종 정보가 없을 경우 당사 고객센터(1588-7278)를 통해 정확한 정보를 확인하시기 바랍니다.',
                        style: TextStyle(
                          fontFamily: 'HDharmony',
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
                manufactureItem,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(
                    color: Colors.black54,
                  ),
                ),
                !searchType ? generalSearchItems : partNumberSearchItems,
                Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
                searchButton,
                SizedBox(height: 30),
                state.searchResult != null && state.searchResult.length > 0? SimpleSearchResultsForm() : Container(),
                (state.nomore==false && state.searchResult != null && state.searchResult.length > 0) ? searchMoreButton : Container(),
              ],
            ),
            Positioned(
              child: LoadingIndicator(isLoading: state.isLoading),
            ),
          ]
        );
      },
    );
  }
}
