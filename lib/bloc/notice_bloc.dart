import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobispartsearch/model/notice_model.dart';
import 'package:mobispartsearch/repository/notice_repository.dart';

abstract class NoticeEvent {}

enum EnumNoticeEvent { Load, TitleSearch, ContentSearch }

class NoticeLoadEvent extends NoticeEvent{
  final int limit;
  NoticeLoadEvent(this.limit);
}

class NoticeSearchButtonClickedEvent extends NoticeEvent {}

class NoticeSearchTitleEvent extends NoticeEvent {
  final String searchWord;
  final int page;
  NoticeSearchTitleEvent({@required this.searchWord, this.page = 1});
}

class NoticeSearchContentEvent extends NoticeEvent {
  final String searchWord;
  final int page;
  NoticeSearchContentEvent({@required this.searchWord, this.page = 1});
}

class NoticeState {
  EnumNoticeEvent kind;
  String keyword;
  int page;
  List<Notice> noticeList;
  int initialLimit;
  NoticeState({this.kind, this.keyword, this.noticeList, this.page=0, this.initialLimit=20});

  NoticeState _setProps({EnumNoticeEvent kind, List<Notice> noticeList}) =>
      NoticeState(
          kind: kind ?? this.kind, noticeList: noticeList ?? this.noticeList);

  factory NoticeState.init() => NoticeState();
  NoticeState searchTitle(List<Notice> noticeList) =>
      _setProps(kind: EnumNoticeEvent.TitleSearch, noticeList: noticeList);
  NoticeState searchContent(List<Notice> noticeList) =>
      _setProps(kind: EnumNoticeEvent.ContentSearch, noticeList: noticeList);

  bool isSearch() => (kind == EnumNoticeEvent.TitleSearch ||
      kind == EnumNoticeEvent.ContentSearch);
}

class NoticeBloc extends Bloc<NoticeEvent, NoticeState> {
  NoticeRepository noticeRepository;
  NoticeBloc({this.noticeRepository}) : super(NoticeState());

  @override
  Stream<NoticeState> mapEventToState(NoticeEvent event) async* {
    if(event is NoticeLoadEvent){
      try{
        final stream = await noticeRepository.getTitleNoticeStream(title:'', page: 1, limit: event.limit);
        yield NoticeState(
          kind:EnumNoticeEvent.TitleSearch, noticeList:stream, keyword:'', page: 1, initialLimit: event.limit);
      } catch(e){
        yield NoticeState(
          kind:EnumNoticeEvent.TitleSearch, noticeList:List<Notice>());
      }
    } else if(event is NoticeSearchButtonClickedEvent){
        yield NoticeState(page: 0, noticeList: new List<Notice>());
    } else if(event is NoticeSearchTitleEvent){
      try{
        final stream = await noticeRepository.getTitleNoticeStream(
          title:event.searchWord, page: state.page+1, limit: (state.page==0)?state.initialLimit:10);
        yield stream.isEmpty
          ? state
          : NoticeState(
              kind:EnumNoticeEvent.TitleSearch,
              keyword: event.searchWord,
              noticeList:state.noticeList+stream, 
              page: state.page+1);
      } catch (e) {
        yield NoticeState(
            kind:EnumNoticeEvent.TitleSearch,
            keyword: event.searchWord,
            noticeList:List<Notice>());
      }
    }
    else if(event is NoticeSearchContentEvent){
      try{
        final stream = await noticeRepository.getContentNoticeStream(
            keyword:event.searchWord,
            page: state.page+1,
            limit: (state.page==0)
            ? state.initialLimit
            : 10);
        yield stream.isEmpty
          ? state
          : NoticeState(
            kind:EnumNoticeEvent.ContentSearch,
            keyword: event.searchWord,
            noticeList:state.noticeList+stream,
            page: state.page+1);
      } catch (e) {
        yield NoticeState(
            kind:EnumNoticeEvent.TitleSearch,
            keyword: event.searchWord,
            noticeList:List<Notice>());
      }
    }
  }
}
