import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobispartsearch/model/page_model.dart';
import 'package:mobispartsearch/model/simple_search_model.dart';
import 'package:mobispartsearch/app_config.dart';
import 'package:mobispartsearch/repository/simple_search_repository.dart';


abstract class SimpleSearchEvent {}

class InitSimpleSearchEvent extends SimpleSearchEvent {}

class HKGBSimpleSearchEvent extends SimpleSearchEvent {
  final int idx;

  HKGBSimpleSearchEvent(this.idx);
}

class VTPYSimpleSearchEvent extends SimpleSearchEvent {
  final int idx;

  VTPYSimpleSearchEvent(this.idx);
}

class ModelSimpleSearchEvent extends SimpleSearchEvent {
  final int model;

  ModelSimpleSearchEvent(this.model);
}

class SearchSimpleSearchEvent extends SimpleSearchEvent {
  final searchWord;
  bool searchType;
  SearchSimpleSearchEvent(this.searchWord, this.searchType);
}

class SearchSimpleSearchMoreEvent extends SimpleSearchEvent{
}

class SimpleSearchState {
  String hkgb;
  String vtpy;
  int model = 0;
  String keyword;
  bool searchType;
  List<SimpleSearchResultModel> searchResult;
  int searchResultCnt;
  int page;
  bool nomore;
  bool isLoading;

  SimpleSearchState(
      {this.hkgb = 'H',
      this.vtpy = 'P',
      this.model = 0,
      this.keyword = '',
      this.searchType = false,
      this.searchResult,
      this.isLoading = false,
      this.searchResultCnt = 0,
      this.nomore = false,
      this.page = 0});

  factory SimpleSearchState.init() => SimpleSearchState();

  SimpleSearchState _setProps(
          {String hkgb,
          String vtpy,
          int model,
          String keyword,
          bool searchType,
          List<SimpleSearchResultModel> searchResult,
          bool isLoading,
          int searchResultCnt,
          bool nomore,
          int page}) =>
      SimpleSearchState(
        hkgb: hkgb ?? this.hkgb,
        vtpy: vtpy ?? this.vtpy,
        model: model ?? this.model,
        keyword: keyword ?? this.keyword,
        searchType: searchType ?? this.searchType,
        searchResult: searchResult ??
            this.searchResult,
        isLoading: isLoading ?? this.isLoading,
        searchResultCnt: searchResultCnt ?? this.searchResultCnt ?? 0,
        nomore: nomore ?? this.nomore,
        page: page ?? this.page,
      );

  SimpleSearchState submitting() => _setProps(isLoading: true);
  SimpleSearchState success(
          {String hkgb,
          String vtpy,
          int model,
          String keyword,
          bool searchType,
          List<SimpleSearchResultModel> searchResult,
          bool isLoading,
          int searchResultCnt,
          bool nomore,
          int page}) =>
      _setProps(
          hkgb: hkgb,
          vtpy: vtpy,
          model: model,
          keyword: keyword,
          searchType: searchType,
          searchResult: searchResult,
          isLoading: false,
          searchResultCnt: searchResultCnt,
          nomore: nomore,
          page: page);
}

class SimpleSearchBloc extends Bloc<SimpleSearchEvent, SimpleSearchState> {
  SimpleSearchRepository simpleSearchRepository;
  SimpleSearchBloc({this.simpleSearchRepository}) : super(SimpleSearchState());

  @override
  Stream<SimpleSearchState> mapEventToState(SimpleSearchEvent event) async* {
    if (event is InitSimpleSearchEvent) yield* _mapInitEventToState();
    if (event is HKGBSimpleSearchEvent) yield* _mapHKGBEventToState(event.idx);
    if (event is VTPYSimpleSearchEvent) yield* _mapVTPYEventToState(event.idx);
    if (event is ModelSimpleSearchEvent)
      yield* _mapModelSelectEventToState(event.model);
    if (event is SearchSimpleSearchEvent)
      yield* _mapSearchEventToState(
          event.searchWord, event.searchType);
    if (event is SearchSimpleSearchMoreEvent)
      yield* _mapSearchMoreEventToState();
  }

  Stream<SimpleSearchState> _mapInitEventToState() async* {
    try {
      yield state.submitting();
      List<SimpleSearchResultModel> searchResult =
          new List<SimpleSearchResultModel>();
      yield state.success(
          hkgb: 'H',
          vtpy: 'P',
          model: 0,
          searchResult: searchResult, searchResultCnt: 0);
    } catch (e) {
      yield state.success(model: 0, searchResult: null, searchResultCnt: 0);
    }
  }

  Stream<SimpleSearchState> _mapHKGBEventToState(int idx) async* {
    try {
      yield state.submitting();
      yield state.success(hkgb: hkgb_list[idx]);
    } catch (e) {
      yield state.success(model: 0, searchResult: null, searchResultCnt: 0);
    }
  }

  Stream<SimpleSearchState> _mapVTPYEventToState(int idx) async* {
    try {
      yield state.submitting();
      yield state.success(vtpy: vtpy_list[idx]);
    } catch (e) {
      yield state.success(model: 0, searchResult: null, searchResultCnt: 0);
    }
  }

  Stream<SimpleSearchState> _mapModelSelectEventToState(int model) async* {
    try {
      yield state.submitting();
      yield state.success(model: model,);
    } catch (e) {
      yield state.success(model: 0, searchResult: null, searchResultCnt: 0);
    }
  }

  Stream<SimpleSearchState> _mapSearchEventToState(
      String keyword, bool searchType) async* {
    try {
      yield state.submitting();
      List<SimpleSearchResultModel> searchResult = (searchType == false)
          ? await simpleSearchRepository.searchPartGeneral(
              hkgb: state.hkgb,
              vtpy: state.vtpy,
              catSeq: state.model,
              searchWord: keyword,
              firstIndex: 0,
              recordCountPerPage: globalRecordCountPerPage)
          : await simpleSearchRepository.searchPartPtno(
              hkgb: state.hkgb,
              ptno: keyword,
              firstIndex: 0,
              recordCountPerPage: globalRecordCountPerPage);
      if (searchResult == null || searchResult.length == 0)
      {
        yield state.success(keyword: keyword, searchResult: new List<SimpleSearchResultModel>(), searchType: searchType, nomore: true);
      }
      else {
        bool nomore = false;
        if(searchResult.length < globalRecordCountPerPage)
          nomore = true;
        yield state.success(keyword: keyword, searchResult: searchResult, searchType: searchType, searchResultCnt: searchResult[0].totalCnt, nomore: nomore, page: 1);
      }
    } catch (e) {
      yield state.success(model: 0, searchResult: null, searchResultCnt: 0);
    }
  }

  Stream<SimpleSearchState> _mapSearchMoreEventToState() async* {
    try {
      yield state.submitting();
      print(state.page);
      List<SimpleSearchResultModel> searchResult = (state.searchType == false)
          ? await simpleSearchRepository.searchPartGeneral(
          hkgb: state.hkgb,
          vtpy: state.vtpy,
          catSeq: state.model,
          searchWord: state.keyword,
          firstIndex: state.page * globalRecordCountPerPage,
          recordCountPerPage: globalRecordCountPerPage)
          : await simpleSearchRepository.searchPartPtno(
          hkgb: state.hkgb,
          ptno: state.keyword,
          firstIndex: state.page * globalRecordCountPerPage,
          recordCountPerPage: globalRecordCountPerPage);
      print(searchResult);
      if (searchResult == null || searchResult.length == 0)
      {
        yield state.success(nomore: true);
      }
      else {
        state.searchResult.addAll(searchResult);
        yield state.success(searchResult: state.searchResult, nomore: false, page: state.page + 1);
      }
    } catch (e) {
      yield state.success(model: 0, searchResult: null);
    }
  }
}
