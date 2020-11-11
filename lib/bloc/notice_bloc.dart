import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyundai_mobis/bloc/notice_bloc.dart';
import 'package:hyundai_mobis/repository/notice_repository.dart';

abstract class NoticeEvent{}

enum EnumNoticeEvent{Load, TitleSearch, ContentSearch}

class NoticeLoadEvent extends NoticeEvent{}

class NoticeSearchTitleEvent extends NoticeEvent{
  final String searchWord;
  NoticeSearchTitleEvent({@required this.searchWord});
}
class NoticeSearchContentEvent extends NoticeEvent{
  final String searchWord;
  NoticeSearchContentEvent({@required this.searchWord});
}

abstract class NoticeBaseState extends Equatable {
  NoticeBaseState([List noticeList = const []]) : super(noticeList);
}

class NoticeState{
  EnumNoticeEvent kind;
  List<Notice> noticeList;
  NoticeState({this.kind, this.noticeList});

  NoticeState _setProps({EnumNoticeEvent kind, List<Notice> noticeList})=>NoticeState(kind: kind??this.kind, noticeList: noticeList??this.noticeList);

  factory NoticeState.init()=>NoticeState();
  NoticeState searchTitle(List<Notice> noticeList)=>_setProps(kind: EnumNoticeEvent.TitleSearch, noticeList: noticeList);
  NoticeState searchContent(List<Notice> noticeList)=>_setProps(kind: EnumNoticeEvent.ContentSearch, noticeList: noticeList);

  bool isSearch()=>(kind==EnumNoticeEvent.TitleSearch||kind==EnumNoticeEvent.ContentSearch);
}

class NoticeBloc extends Bloc<NoticeEvent, NoticeState>{
  NoticeRepository noticeRepository;
  NoticeBloc({this.noticeRepository}):super(NoticeState());

  @override
  NoticeState get initialState=>NoticeState.init();

  @override
  Stream<NoticeState> mapEventToState(NoticeEvent event) async* {
    if(event is NoticeLoadEvent){
      try{
        final stream = await noticeRepository.getTitleNoticeStream('');
//        state.searchTitle(stream);
        yield NoticeState(kind:EnumNoticeEvent.TitleSearch, noticeList:stream);
      } catch(e){
        yield NoticeState(kind:EnumNoticeEvent.TitleSearch, noticeList:List<Notice>());
      }
    }
    else if(event is NoticeSearchTitleEvent){
      try{
        final stream = await noticeRepository.getTitleNoticeStream(event.searchWord);
//        state.searchTitle(stream);
        yield NoticeState(kind:EnumNoticeEvent.TitleSearch, noticeList:stream);
      }catch(e){
        yield NoticeState(kind:EnumNoticeEvent.TitleSearch, noticeList:List<Notice>());
      }
    }
    else if(event is NoticeSearchContentEvent){
      try{
        final stream = await noticeRepository.getContentNoticeStream(event.searchWord);
//        state.searchContent(stream);
        yield NoticeState(kind:EnumNoticeEvent.ContentSearch, noticeList:stream);
      }catch(e){
        yield NoticeState(kind:EnumNoticeEvent.TitleSearch, noticeList:List<Notice>());
      }
    }
  }
  
}