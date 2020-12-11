import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobispartsearch/common.dart';
import 'package:mobispartsearch/model/UserHistoryModel.dart';

abstract class UserHistoryEvent {}

class UserHistoryInitEvent extends UserHistoryEvent{}
class UserHistoryLoadEvent extends UserHistoryEvent{}

class UserHistoryState{
  int page;
  List<UserHistoryModel> userHistoryList;
  UserHistoryState({this.page=0, this.userHistoryList});

  factory UserHistoryState.init() => UserHistoryState();

}

class UserHistoryBloc extends Bloc<UserHistoryEvent, UserHistoryState>{
  UserHistoryBloc() : super(UserHistoryState());

  @override
  Stream<UserHistoryState> mapEventToState(UserHistoryEvent event) async* {
    try {
      if(event is UserHistoryInitEvent){
        final stream = await getUserHistoryStream(username: globalUsername,
            page: 1, limit: globalRecordCountPerPage);
        yield UserHistoryState(userHistoryList: stream, page: 1);
      }
      else if (event is UserHistoryLoadEvent) {
        final stream = await getUserHistoryStream(username: globalUsername,
            page: state.page + 1,
            limit: globalRecordCountPerPage);
        yield stream.isEmpty
            ? state : UserHistoryState(userHistoryList: state.userHistoryList + stream, page: state.page + 1);
      }
    } catch(e){
      yield UserHistoryState();
    }
  }

}