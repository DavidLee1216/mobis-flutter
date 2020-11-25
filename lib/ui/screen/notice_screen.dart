
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobispartsearch/bloc/notice_bloc.dart';
import 'package:mobispartsearch/ui/widget/notice_form.dart';
import 'package:mobispartsearch/ui/screen/home_screen.dart';
import 'package:mobispartsearch/common.dart' as common;

class NoticeScreen extends StatefulWidget {
  @override
  _NoticeScreenState createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  bool searchIconClicked = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<NoticeBloc>(context).add(NoticeLoadEvent(20));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text('공지사항'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              searchIconClicked = !searchIconClicked;
              setState(() {});
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            searchIconClicked ? SearchBarWidget() : Container(),
            Divider(
              height: 3,
              color: Colors.black54,
            ),
            Expanded(child: NoticeListWidget()),
          ],
        ), //
      ),
    );
  }
}

class SearchBarWidget extends StatefulWidget {
  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  String dropdownValue = '제목';
  final _keywordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var dropdownmenu = DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: Icon(Icons.keyboard_arrow_down),
        iconSize: 16,
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
        items:
            <String>['제목', '내용'].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Container(
              width: 60,
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'HDharmony',
                  fontSize: 14,
                ),
              ),
              alignment: Alignment.center,
            ),
          );
        }).toList(),
      ),
    );
    var keywordBox = Container(
        height: 40,
        child: TextField(
          controller: _keywordController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(hintText: '검색어를 입력해 주세요'),
        ));
    var searchButton = ButtonTheme(
      minWidth: MediaQuery.of(context).size.width / 5,
      height: 40,
      buttonColor: kPrimaryColor,
      child: RaisedButton(
        child: Text('검색',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'HDharmony',
              color: Colors.white,
            )),
        onPressed: () {
          BlocProvider.of<NoticeBloc>(context)
              .add(NoticeSearchButtonClickedEvent());
          if (dropdownValue == '제목')
            BlocProvider.of<NoticeBloc>(context).add(
                NoticeSearchTitleEvent(searchWord: _keywordController.text));
          if (dropdownValue == '내용')
            BlocProvider.of<NoticeBloc>(context).add(
                NoticeSearchContentEvent(searchWord: _keywordController.text));
        },
      ),
    );

    return Column(children: [
      SizedBox(height: 20),
      Container(
        padding: EdgeInsets.all(10),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
            width: 80,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: dropdownmenu,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(child: keywordBox),
          SizedBox(
            width: 10,
          ),
          searchButton,
        ]),
      ),
      SizedBox(height: 20),
    ]);
  }
}

class NoticeListWidget extends StatefulWidget {
  @override
  _NoticeListWidgetState createState() => _NoticeListWidgetState();
}

class _NoticeListWidgetState extends State<NoticeListWidget> {
  final _scrollController = ScrollController();

  final _scrollThreshold = 20.0;

  int maxPage = 1;
  EnumNoticeEvent kind = EnumNoticeEvent.TitleSearch;
  String searchWord = '';

  NoticeBloc bloc;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    bloc = BlocProvider.of<NoticeBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoticeBloc, NoticeState>(
      cubit: BlocProvider.of<NoticeBloc>(context),
      builder: (BuildContext context, state) {
        if (state is NoticeState) {
          kind = state.kind;
          searchWord = state.keyword;
          maxPage = state.page;
          if (state.noticeList != null && state.noticeList.isEmpty) {
            return Center(
              child: Text(''),
            );
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return NoticeForm(
                title: state.noticeList[index].title,
                date: common.dateformatter.format(state.noticeList[index].date),
                text: state.noticeList[index].content,
              );
            },
            itemCount: state.noticeList != null ? state.noticeList.length : 0,
            controller: _scrollController,
          );
        }
        return Container();
      },
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll > 5 &&
        maxScroll - currentScroll <= _scrollThreshold &&
        bloc != null) {
      if (kind == EnumNoticeEvent.TitleSearch)
        bloc.add(
            NoticeSearchTitleEvent(searchWord: searchWord, page: maxPage + 1));
      else
        bloc.add(NoticeSearchContentEvent(
            searchWord: searchWord, page: maxPage + 1));
      Future.delayed(Duration(milliseconds: 200), () {});
    }
  }
}
