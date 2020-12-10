import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobispartsearch/bloc/user_history_bloc.dart';
import 'package:mobispartsearch/common.dart' as common;
import 'package:intl/intl.dart';

class UserHistoryScreen extends StatefulWidget {
  @override
  _UserHistoryScreenState createState() => _UserHistoryScreenState();
}

class _UserHistoryScreenState extends State<UserHistoryScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserHistoryBloc>(context).add(UserHistoryInitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      leading: BackButton(color: Colors.black),
      title: Text(
        '공지사항',
        style: TextStyle(
          fontFamily: 'HDharmony',
        ),
      ),
      centerTitle: true,
    ),
    body: SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 30,),
            Expanded(child: UserHistoryListWidget()),
          ],
        ),
      ),
    ),
    );
  }
}


class UserHistoryListWidget extends StatefulWidget {
  @override
  _UserHistoryListWidgetState createState() => _UserHistoryListWidgetState();
}

class _UserHistoryListWidgetState extends State<UserHistoryListWidget> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 20.0;

  DateFormat dateformatter = DateFormat('yyyy.MM.dd kk:mm');

  @override
  void initState(){
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserHistoryBloc, UserHistoryState>(
      cubit: BlocProvider.of<UserHistoryBloc>(context),
      builder: (BuildContext context, state) {
          if (state.userHistoryList == null) {
            return Center(
              child: Text(
                '',
                style: TextStyle(
                  fontFamily: 'HDharmony',
                ),
              ),
            );
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(dateformatter.format(state.userHistoryList[index].regDtm),
                    style: TextStyle(
                        fontFamily: 'HDharmony',
                        color: Colors.black)),
                subtitle: Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      state.userHistoryList[index].result=='success'? '접속성공' : '접속실패',
                      style: TextStyle(
                          fontFamily: 'HDharmony',
                          fontSize: 10,
                          color: Colors.black54),
                    )),
              );
            },
            itemCount: state.userHistoryList != null ? state.userHistoryList.length : 0,
            controller: _scrollController,
          );
      },
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll > 5 &&
        maxScroll - currentScroll <= _scrollThreshold) {
      BlocProvider.of<UserHistoryBloc>(context).add(UserHistoryLoadEvent());
      Future.delayed(Duration(milliseconds: 200), () {});
    }
  }
}
