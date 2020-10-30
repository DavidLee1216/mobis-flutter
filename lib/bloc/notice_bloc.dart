import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyundai_mobis/bloc/notice_bloc.dart';
import 'package:hyundai_mobis/repository/notice_repository.dart';

abstract class NoticeEvent{}

enum EnumNoticeEvent{None, Drop, SearchClick, TitleSearch, ContentSearch}

class NoticeDropClickedEvent extends NoticeEvent{}

class NoticeSearchClickedEvent extends NoticeEvent{}

class NoticeSearchFinisedEvent extends NoticeEvent{}

class NoticeSearchTitleEvent extends NoticeEvent{
  final String searchWord;
  NoticeSearchTitleEvent({@required this.searchWord});
}
class NoticeSearchContentEvent extends NoticeEvent{
  final String searchWord;
  NoticeSearchContentEvent({@required this.searchWord});
}

class NoticeState{
  EnumNoticeEvent kind;
  Stream<String> noticeStream;
  NoticeState({this.kind=EnumNoticeEvent.None, this.noticeStream=const Stream.empty()});

  NoticeState _setProps({EnumNoticeEvent kind, Stream noticeStream})=>NoticeState(kind: kind??this.kind, noticeStream: noticeStream??this.noticeStream);

  factory NoticeState.init()=>NoticeState();
  NoticeState dropClicked(){
    log(kind.toString());
    if(kind!=EnumNoticeEvent.Drop)
      return _setProps(kind: EnumNoticeEvent.Drop);
    else
      return _setProps(kind: EnumNoticeEvent.None);
    log(kind.toString());
  }
  NoticeState searchClicked()=>_setProps(kind: EnumNoticeEvent.SearchClick);
  NoticeState searchTitle(Stream stream)=>_setProps(kind: EnumNoticeEvent.TitleSearch, noticeStream: stream);
  NoticeState searchContent(Stream stream)=>_setProps(kind: EnumNoticeEvent.ContentSearch, noticeStream: stream);

  NoticeState stream(Stream stream) =>
      _setProps(noticeStream: stream);

  bool isSearch()=>(kind==EnumNoticeEvent.TitleSearch||kind==EnumNoticeEvent.ContentSearch);
  bool isDrop()=>(kind==EnumNoticeEvent.Drop);
  bool isSearchClicked()=>(kind==EnumNoticeEvent.SearchClick);
}

class NoticeBloc extends Bloc<NoticeEvent, NoticeState>{
  NoticeRepository noticeRepository;
  NoticeBloc({this.noticeRepository}):super(NoticeState());

  @override
  NoticeState get initialState=>NoticeState.init();

  @override
  Stream<NoticeState> mapEventToState(NoticeEvent event) async* {
    if(event is NoticeDropClickedEvent){
      try{
        yield state.dropClicked();
      } catch(e){

      }
    }
    else if(event is NoticeSearchClickedEvent){
      state.searchClicked();
    }
    else if(event is NoticeSearchTitleEvent){
      try{
        final stream = noticeRepository.getTitleNoticeStream(event.searchWord);
        yield state.stream(stream);
      }catch(e){

      }
    }
    else if(event is NoticeSearchContentEvent){
      try{
        final stream = noticeRepository.getContentNoticeStream(event.searchWord);
        yield state.stream(stream);
      }catch(e){

      }
    }
  }
  
}