import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobispartsearch/bloc/simple_search_bloc.dart';
import 'package:mobispartsearch/common.dart';
import 'package:mobispartsearch/ui/widget/simple_search_result_form.dart';
import 'package:mobispartsearch/ui/widget/custom_radio_button.dart';

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
        title: Text('부품 간단검색'),
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
  List<String> carModels;
  String modelDropdownValue = null;
  String hkgb = 'H';
  String vtpy = 'P';

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

  Future<List<String>> loadModels() async {
    List<String> models = await getModelsFromRemote(hkgb, vtpy);
    modelDropdownValue ??= models[0];
    carModels = models;
    return models;
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
                  fontWeight: FontWeight.bold),
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
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              '차량 구분',
              style: TextStyle(
                  fontFamily: 'HDharmony',
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ),
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
                  modelDropdownValue = null;
                });
              },
            ),
          ),
        ],
      ),
    );

    var modelDropdownmenu = FutureBuilder(
        future: loadModels(),
        builder: (context, snapshot) {
          return Container(
            width: 290,
//            height: 40,
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                  value: modelDropdownValue,
                  hint: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        '[선택]',
                      )),
                  icon: Icon(Icons.keyboard_arrow_down),
                  iconSize: 14,
                  onChanged: (newValue) {
                    modelDropdownValue = newValue;
                    setState(() {});
                  },
                  items: snapshot.data?.map<DropdownMenuItem<String>>((item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Container(
                        width: 160,
                        child: Text(
                          item,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'HDharmony',
                            fontSize: 14,
                          ),
                        ),
                        alignment: Alignment.center,
                      ),
                    );
                  })?.toList()),
            ),
          );
        });

    var modelItem = Container(
        padding: EdgeInsets.all(10.0),
        child: Container(
          height: 30,
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
          height: 30,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text('한글부품명'),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1),
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
          height: 30,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text('부품번호'),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.74,
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1),
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    contentPadding: EdgeInsets.only(left: 10),
                  ),
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontFamily: 'HDharmony', fontSize: 14.0),
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
        height: 60,
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
                  1));
            });
          },
        ),
      ),
    ));

    var generalSearchItems = Container(
      child: Column(
        children: [
          cardKindItem,
          Divider(
            height: 2,
            color: Colors.black54,
          ),
          modelItem,
          Divider(
            height: 2,
            color: Colors.black54,
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
        return ListView(
          children: [
            Row(
              children: [
                ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width / 2,
                  height: 40,
                  buttonColor: Colors.white,
                  child: RaisedButton(
                    child: !searchType
                        ? Text(
                            '일반 검색',
                            style: TextStyle(
                              fontFamily: 'HDharmony',
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
                        ? Border(bottom: BorderSide(color: Color.fromRGBO(0, 63, 114, 1), width: 3))
                        : Border(bottom: BorderSide(color: Colors.transparent, width: 3)),
                    onPressed: () {
                      searchType = false;
                      searched = false;
                      setState(() {});
                    },
                  ),
                ),
                ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width / 2,
                  height: 40,
                  buttonColor: Colors.white,
                  child: RaisedButton(
                    child: searchType
                        ? Text(
                            '부품번호로 검색',
                            style: TextStyle(
                              fontFamily: 'HDharmony',
                              fontSize: 15,
                              color: Color.fromRGBO(0, 63, 114, 1),
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
                        ? Border(bottom: BorderSide(color: Color.fromRGBO(0, 63, 114, 1), width: 3))
                        : Border(bottom: BorderSide(color: Colors.transparent, width: 3)),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                color: Colors.black54,
              ),
            ),
            manufactureItem,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                color: Colors.black54,
              ),
            ),
            !searchType ? generalSearchItems : partNumberSearchItems,
            searchButton,
            SizedBox(height: 30),
            searched ? SimpleSearchResultsForm() : Container(),
          ],
        );
      },
    );
  }
}
