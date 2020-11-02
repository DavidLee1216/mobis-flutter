import 'package:flutter/material.dart';
import 'package:hyundai_mobis/ui/screen/home_screen.dart';
import 'package:hyundai_mobis/ui/screen/notification_screen.dart';
import 'package:hyundai_mobis/ui/widget/market_search_result_form.dart';
import 'package:hyundai_mobis/ui/widget/custom_radio_button.dart';

import 'package:hyundai_mobis/ui/screen/my_page_screen.dart';
import 'package:hyundai_mobis/ui/widget/navigation_bar.dart';
import 'package:hyundai_mobis/utils/navigation.dart';

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
        title: Text('부품판매점 검색'),
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
  String location1DropdownValue = 'aaa';
  String location2DropdownValue = 'aaa';

  var partNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    manufacturerData.add(RadioModel(false, '', '현대'));
    manufacturerData.add(RadioModel(false, '', '기아'));
    marketData.add(RadioModel(false, '', '전체'));
    marketData.add(RadioModel(false, '', '직영점'));
    marketData.add(RadioModel(false, '', '대리점(매장)'));
    marketData.add(RadioModel(false, '', '대리점(온라인몰)'));
  }

  @override
  Widget build(BuildContext context) {
    var mainWidth = MediaQuery.of(context).size.width;
    var manufactureItem = Container(
      height: 50,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              '제조사',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
              width: mainWidth*0.25,
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                '판매점',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            width: mainWidth*0.75,
            child: Column(
              children:[
              ButtonTheme(
                child: FlatButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  child: RadioItem(marketData[0]),
                  onPressed: () {
                    setState(() {
                      marketData.forEach((element) => element.isSelected = false);
                      marketData[0].isSelected = true;
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
                      marketData.forEach((element) => element.isSelected = false);
                      marketData[1].isSelected = true;
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
                      marketData.forEach((element) => element.isSelected = false);
                      marketData[2].isSelected = true;
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
                      marketData.forEach((element) => element.isSelected = false);
                      marketData[3].isSelected = true;
                    });
                  },
                ),
              ),]
            ),
          )
        ],
      ),
    );
    var location1Dropdownmenu = Container(
        width: 180,
        height: 30,
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: location1DropdownValue,
//            decoration: InputDecoration(
//                labelText: '[선택]'
//            ),
            hint: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  '[선택]',
                )),
            icon: Icon(Icons.keyboard_arrow_down),
            iconSize: 14,
            onChanged: (String newValue) {
              setState(() {
                location1DropdownValue = newValue;
              });
            },
            items: <String>['aaa', 'bbb']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Container(
                  width: 60,
                  child: Text(
                    value,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  alignment: Alignment.center,
                ),
              );
            }).toList(),
          ),
        ));
    var location2Dropdownmenu = Container(
        width: 180,
        height: 30,
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: location2DropdownValue,
//            decoration: InputDecoration(
//                labelText: '[선택]'
//            ),
            hint: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  '[선택]',
                )),
            icon: Icon(Icons.keyboard_arrow_down),
            iconSize: 14,
            onChanged: (String newValue) {
              setState(() {
                location2DropdownValue = newValue;
              });
            },
            items: <String>['aaa', 'bbb']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Container(
                  width: 60,
                  child: Text(
                    value,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  alignment: Alignment.center,
                ),
              );
            }).toList(),
          ),
        ));
    var locationItem = Container(
        padding: EdgeInsets.all(10.0),
        child: Container(
          child: Row(
            children: [
              Container(
                width: mainWidth*0.25,
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  '지역설정',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    location1Dropdownmenu,
                    SizedBox(height: 10,),
                    location2Dropdownmenu,
                  ],
                )
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
                padding: EdgeInsets.only(left: 20),
                child: Text('부품번호'),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1),
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    contentPadding: EdgeInsets.only(left: 10),
                  ),
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 14.0),
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
            minWidth: MediaQuery.of(context).size.width / 3.0,
            height: 40,
            buttonColor: Color.fromRGBO(0, 63, 114, 1),
            child: RaisedButton(
              child: Text(
                '검색',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                searched = true;
                setState(() {

                });
              },
            ),
          ),
        ));

    var partNumberSearchItems = Container(
      child: partNumber,
    );

    return ListView(
      children: [
        Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                '부품번호를 입력하시면 해당 부품을 직접 방문 혹은 온라인을 통해 구매할 수 있는 판매점을 알려드립니다.',
                style: TextStyle(
                  fontSize: 14,
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                '판매점이 조회되지 않는 경우 당사 고객센터(1588-7278)로 문의 바랍니다.',
                style: TextStyle(
                  fontSize: 14,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
        Divider(
          height: 2,
          color: Colors.black54,
        ),
        partNumberSearchItems,
        Divider(height: 2, color: Colors.black54,),
        locationItem,
        Divider(height: 2, color: Colors.black54,),
        marketItem,
        Divider(height:2, color: Colors.black54,),
        manufactureItem,
        Divider(
          height: 2,
          color: Colors.black54,
        ),
        searchButton,
        SizedBox(height: 30),
        searched?MarketSearchResultsForm():Container(),
      ],
    );
  }
}
