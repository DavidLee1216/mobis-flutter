import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobispartsearch/model/page_model.dart';
import 'package:mobispartsearch/model/simple_search_model.dart';
import 'package:mobispartsearch/common.dart';
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
  int page;
  SearchSimpleSearchEvent(this.searchWord, this.searchType, this.page);
}

class SimpleSearchState {
  String hkgb;
  String vtpy;
  int model = 0;
  String keyword;
  bool searchType;
  List<SimpleSearchResultModel> searchResult;
  int searchResultCnt;
  PageModel pageModel;
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
      this.pageModel});

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
          PageModel pageModel}) =>
      SimpleSearchState(
        hkgb: hkgb ?? this.hkgb,
        vtpy: vtpy ?? this.vtpy,
        model: model ?? this.model,
        keyword: keyword ?? this.keyword,
        searchType: searchType ?? this.searchType,
        searchResult: searchResult ??
            this.searchResult ??
            new List<SimpleSearchResultModel>(),
        isLoading: isLoading ?? this.isLoading,
        searchResultCnt: searchResultCnt ?? this.searchResultCnt ?? 0,
        pageModel: pageModel ?? this.pageModel
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
          PageModel pageModel}) =>
      _setProps(
          hkgb: hkgb,
          vtpy: vtpy,
          model: model,
          keyword: keyword,
          searchType: searchType,
          searchResult: searchResult,
          isLoading: false,
          searchResultCnt: searchResultCnt,
          pageModel: pageModel);
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
          event.searchWord, event.searchType, event.page);
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
      yield state.success(model: model, pageModel: null);
    } catch (e) {
      yield state.success(model: 0, searchResult: null, searchResultCnt: 0);
    }
  }

  Stream<SimpleSearchState> _mapSearchEventToState(
      String keyword, bool searchType, int page) async* {
    try {
      yield state.submitting();
      List<SimpleSearchResultModel> searchResult = (searchType == false)
          ? await simpleSearchRepository.searchPartGeneral(
              hkgb: state.hkgb,
              vtpy: state.vtpy,
              catSeq: state.model,
              searchWord: keyword,
              firstIndex: 0 + (page - 1) * globalRecordCountPerPage,
              recordCountPerPage: globalRecordCountPerPage)
          : await simpleSearchRepository.searchPartPtno(
              hkgb: state.hkgb,
              ptno: keyword,
              firstIndex: 0 + (page - 1) * globalRecordCountPerPage,
              recordCountPerPage: globalRecordCountPerPage);
      if (searchResult == null || searchResult.length == 0)
      {
        yield state.success(keyword: keyword, searchResult: null, searchResultCnt: 0, pageModel: null);
      }
      else {
        PageModel pageModel = new PageModel()..init();
        pageModel.setPageCnt(
            searchResult[0].totalCnt ~/ globalRecordCountPerPage + 1);
        pageModel.setCurPage(page);
        yield state.success(keyword: keyword, searchResult: searchResult, searchResultCnt: searchResult[0].totalCnt, pageModel: pageModel);
      }
    } catch (e) {
      log(e.toString());
      yield state.success(model: 0, searchResult: null, searchResultCnt: 0);
    }
  }
}
