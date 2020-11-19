import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyundai_mobis/model/page_model.dart';
import 'package:hyundai_mobis/model/simple_search_model.dart';
import 'package:hyundai_mobis/common.dart';
import 'package:hyundai_mobis/repository/simple_search_repository.dart';

const List<String> hkgb_list = ['H', 'K'];
const List<String> vtpy_list = ['P', 'R', 'C'];


abstract class SimpleSearchEvent{}

class InitSimpleSearchEvent extends SimpleSearchEvent{
}

class HKGBSimpleSearchEvent extends SimpleSearchEvent{
  final int idx;

  HKGBSimpleSearchEvent(this.idx);
}

class VTPYSimpleSearchEvent extends SimpleSearchEvent{
  final int idx;

  VTPYSimpleSearchEvent(this.idx);
}

class ModelSimpleSearchEvent extends SimpleSearchEvent{
  final String model;

  ModelSimpleSearchEvent(this.model);
}

class SearchSimpleSearchEvent extends SimpleSearchEvent{
  final searchWord;
  bool searchType;
  int page;
  SearchSimpleSearchEvent(this.searchWord, this.searchType, this.page);
}

class SimpleSearchState{
  String hkgb;
  String vtpy;
  String model;
  String keyword;
  bool searchType;
  List<String> carModels;
  List<SimpleSearchResultModel> searchResult;
  PageModel pageModel;
  bool isLoading;

  SimpleSearchState({this.hkgb='H', this.vtpy='P', this.model='', this.keyword='', this.carModels, this.searchResult, this.isLoading=false, this.pageModel});


  factory SimpleSearchState.init()=>SimpleSearchState();

  SimpleSearchState _setProps({String hkgb,  String vtpy, String model, String keyword, List<String> carModels, List<SimpleSearchResultModel> searchResult, bool isLoading, PageModel pageModel})=>
      SimpleSearchState(
          hkgb: hkgb??this.hkgb,
          vtpy: vtpy??this.vtpy,
          model: model??this.model,
          keyword: keyword??this.keyword,
          carModels:carModels??this.carModels??new List<String>(),
          searchResult:searchResult?? this.searchResult??new List<SimpleSearchResultModel>(),
          isLoading: isLoading??this.isLoading,
          pageModel: pageModel??this.pageModel??new PageModel()..init(),
      );

  SimpleSearchState submitting() => _setProps(isLoading: true);
  SimpleSearchState success({String hkgb, String vtpy, String model, String keyword, List<String> carModels, List<SimpleSearchResultModel> searchResult, bool isLoading, PageModel pageModel}) =>
      _setProps(hkgb: hkgb, vtpy: vtpy, model: model, carModels: carModels, searchResult: searchResult, isLoading: false, pageModel: pageModel);
}

class SimpleSearchBloc extends Bloc<SimpleSearchEvent, SimpleSearchState> {
  SimpleSearchRepository simpleSearchRepository;
  SimpleSearchBloc({this.simpleSearchRepository}) : super(SimpleSearchState());

  @override
  Stream<SimpleSearchState> mapEventToState(SimpleSearchEvent event) async* {
    if(event is InitSimpleSearchEvent)
      yield* _mapInitEventToState();
    if(event is HKGBSimpleSearchEvent)
      yield* _mapHKGBEventToState(event.idx);
    if(event is VTPYSimpleSearchEvent)
      yield* _mapVTPYEventToState(event.idx);
    if(event is ModelSimpleSearchEvent)
      yield* _mapModelSelectEventToState(event.model);
    if(event is SearchSimpleSearchEvent)
      yield* _mapSearchEventToState(event.searchWord, event.searchType, event.page);
  }

  Stream<SimpleSearchState> _mapInitEventToState() async* {
    try{
      yield state.submitting();
      List<String> carModels = await simpleSearchRepository.getModels(hkgb:'H', vtpy:'P');
      List<SimpleSearchResultModel> searchResult = new List<SimpleSearchResultModel>();
      yield state.success(model: carModels[0], carModels: carModels, searchResult: searchResult);
    } catch(e){
      yield state.success();
    }
  }

  Stream<SimpleSearchState> _mapHKGBEventToState(int idx) async* {
    try{
      yield state.submitting();
      log('hkgb');
      List<String> carModels = await simpleSearchRepository.getModels(hkgb:hkgb_list[idx], vtpy:state.vtpy);
      yield state.success(hkgb: hkgb_list[idx], carModels: carModels);
    } catch(e){
      yield state.success();
    }
  }

  Stream<SimpleSearchState> _mapVTPYEventToState(int idx) async* {
    try{
      yield state.submitting();
      List<String> carModels = await simpleSearchRepository.getModels(hkgb:state.hkgb, vtpy:vtpy_list[idx]);
      yield state.success(vtpy: vtpy_list[idx], carModels: carModels);
    } catch(e){
      yield state.success();
    }
  }

  Stream<SimpleSearchState> _mapModelSelectEventToState(String model) async* {
    try{
      yield state.submitting();
      yield state.success(model: model);
    } catch(e){
      yield state.success();
    }
  }

  Stream<SimpleSearchState> _mapSearchEventToState(String keyword, bool searchType, int page) async* {
    try{
      yield state.submitting();
      List<SimpleSearchResultModel> searchResult = (searchType==false) ?
            await simpleSearchRepository.searchPartGeneral(hkgb: state.hkgb, vtpy: state.vtpy, catSeq: state.model, searchWord: state.keyword, firstIndex: 1 + (page-1)*globalRecordCountPerPage , recordCountPerPage: globalRecordCountPerPage):
            await simpleSearchRepository.searchPartPtno(hkgb: state.hkgb, ptno:state.keyword, firstIndex: 1 + (page-1)*globalRecordCountPerPage, recordCountPerPage: globalRecordCountPerPage);
      if(searchResult==null || searchResult.length==0)
        yield state.success();
      else{
        PageModel pageModel = new PageModel()..init();
        pageModel.setPageCnt(searchResult[0].totalCnt~/globalRecordCountPerPage + 1);
        pageModel.setCurPage(page);
        yield state.success(searchResult: searchResult, pageModel: pageModel);
      }
    } catch(e){
      yield state.success();
    }
  }

}